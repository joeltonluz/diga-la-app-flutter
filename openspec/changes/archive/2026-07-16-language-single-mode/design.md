## Context

The app has three language modes (pt, en, ptEn) that currently only affect speech. Card text (`Card.label`) always returns `labelPt`. The ptEn mode is rarely used and adds confusion — caregivers expect text to match the selected speech language. Removing ptEn and making text follow the language mode unifies the experience.

All card-display widgets use `Card.label` directly:
- `CardTile` in ConverseScreen grid and CategoryGridScreen
- `_MiniCard` in SentenceBar
- `CategoryGridScreen`'s app bar uses `category.name` (category-level, not card-level)

`LanguageService` is available in all screens that display cards (via Riverpod `ref` or direct prop).

## Goals / Non-Goals

**Goals:**
- Remove `ptEn` from `LanguageMode` enum
- Make card display text reflect the active language (pt → labelPt, en → labelEn)
- Migrate persisted `"ptEn"` values by falling back to pt
- Clean up `speak()` method

**Non-Goals:**
- Making category names (`Category.name`) language-aware — that's a future change if needed
- UI redesign of settings screen (only removing one option)
- Multi-locale text input or data model changes (both labelPt and labelEn stay on Card)

## Decisions

### D1: Text resolution via `LanguageService.labelFor(Card)` instead of modifying `Card.label`

- **Chosen**: Add `String labelFor(Card card)` to `LanguageService`
- **Rationale**: `Card` is a plain data model with no dependencies. Making it aware of `LanguageMode` would couple it to a service. Keeping text resolution in `LanguageService` (already injected everywhere) follows existing patterns.
- **Alternatives considered**:
  - Make `Card.label` accept `LanguageMode` parameter — still couples Card to the enum and requires passing mode through widget trees.
  - Riverpod `cardLabelProvider` — adds indirection without benefit.

### D2: Add `label` override to `CardTile` and `_MiniCard` instead of injecting `LanguageService`

- **Chosen**: `CardTile` gains an optional `String? label` parameter; `_MiniCard` gains `String label` (required). Callers pass the resolved label.
- **Rationale**: Keeps presentation widgets stateless and testable without service mocking. Parent widgets already have `LanguageService` access, so they resolve the text before passing down.
- **Alternatives considered**:
  - Inject `LanguageService` into `CardTile` — would require making it a `ConsumerWidget` everywhere and complicates testing.

### D3: Remove ptEn from enum, persist fallback to pt

- **Chosen**: Delete `ptEn` from `LanguageMode`. In `_loadSavedMode`, unrecognized persisted values (like `"ptEn"`) fall back to `LanguageMode.pt` via the existing `orElse: () => LanguageMode.pt`.
- **Rationale**: The existing `firstWhere` with `orElse` already handles unknown values — no migration code needed.
- **Alternatives considered**:
  - Keep ptEn but hide it — unnecessary dead code.

## Risks / Trade-offs

- **Backward compatibility**: Users who had ptEn selected will silently switch to pt. The app won't crash (existing orElse handles it), but behavior changes. Acceptable given ptEn was rarely used.
- **No category name i18n**: Category names (`Category.name`) remain single-locale. A caregiver using EN mode will see cards in English but category headers still in Portuguese. Mitigating: category names are emoji+short text, mostly visual.
