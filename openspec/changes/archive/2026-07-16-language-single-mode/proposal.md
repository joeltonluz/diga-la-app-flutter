## Why

The app currently supports three language modes (pt, en, ptEn) for speech, but cards always display in Portuguese (`labelPt`). The ptEn bilingual mode adds complexity and confusion — caregivers expect card text to match the selected language. Removing ptEn simplifies the mental model and makes text follow the language choice, giving a unified experience.

## What Changes

- **REMOVE** `ptEn` from `LanguageMode` enum — only `pt` and `en` remain
- **MODIFY** `Card.label` getter to return text in the currently active language instead of always returning `labelPt`
- **MODIFY** all card-display surfaces to use `Card.label` (already done) or resolve text via `LanguageService`
- **MODIFY** `LanguageService.speak()` to remove the `ptEn` branch
- **MODIFY** `SettingsScreen` to show only two mode options
- **HANDLE** persisted `"ptEn"` from previous versions by falling back to `pt`
- **BREAKING**: Removes the ptEn speech mode — existing users who had it selected will default to pt

## Capabilities

### New Capabilities
- `language-text-resolution`: Resolving card display text according to the active language mode

### Modified Capabilities
- `language-settings`: Remove ptEn mode; text now follows language selection
- `card-grid`: Card text now reflects active language (not always labelPt)

## Impact

- `lib/models/card.dart`: `Card.label` getter needs access to current language mode
- `lib/services/language_service.dart`: Remove ptEn from enum and speak; add method for text resolution
- `lib/screens/settings_screen.dart`: Remove the third _ModeCard for ptEn; update test
- `lib/screens/converse_screen.dart`: No changes if using Card.label; verify
- `lib/screens/learn_screen.dart`: Category item text must use language-aware label
- `lib/screens/category_grid_screen.dart`: Category item text must use language-aware label
- `lib/widgets/sentence_bar.dart`: Mini-card labels must use language-aware label
- `test/services/language_service_test.dart`: Remove ptEn test; add text-resolution tests
- `test/screens/settings_screen_test.dart`: Expect exactly 2 options
- `openspec/specs/language-settings/spec.md`: Remove ptEn requirements, add text-resolution requirement
- `openspec/specs/card-grid/spec.md`: Update to reflect language-aware display
