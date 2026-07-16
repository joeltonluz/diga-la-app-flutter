## 1. LanguageMode enum — remove ptEn

- [x] 1.1 Remove `ptEn` from `LanguageMode` enum in `language_service.dart`
- [x] 1.2 Verify persisted "ptEn" falls back to `LanguageMode.pt` via existing `orElse`
- [x] 1.3 Update `language_service_test.dart`: remove ptEn speech test, confirm default + setMode tests pass

## 2. LanguageService.speak() — clean up ptEn branch

- [x] 2.1 Remove `ptEn` case from `speak()` switch
- [x] 2.2 Update `language_service_test.dart`: verify PT mode calls pt-BR once, EN mode calls en-US once

## 3. LanguageService.labelFor() — add text resolution

- [x] 3.1 Write unit tests for `labelFor`: returns labelPt in PT mode, returns labelEn in EN mode (TDD)
- [x] 3.2 Implement `String labelFor(Card card)` in `LanguageService`

## 4. CardTile — accept label override

- [x] 4.1 Add optional `String? label` parameter to `CardTile`
- [x] 4.2 Update build to display `label ?? card.label`
- [x] 4.3 Update `card_tile_test.dart` if exists, or verify no regression

## 5. SentenceBar MiniCard — accept label override

- [x] 5.1 Add required `String label` parameter to `_MiniCard`
- [x] 5.2 Update build to use parameter instead of `card.label`
- [x] 5.3 Update `SentenceBar` to pass resolved label from parent

## 6. Display surfaces — wire up language-aware labels

- [x] 6.1 `ConverseScreen`: watch `languageServiceProvider`, pass `languageService.labelFor(card)` to each `CardTile`
- [x] 6.2 `SentenceBar`: accept `LanguageService` or resolved labels; pass to `_MiniCard`
- [x] 6.3 `CategoryGridScreen`: use injected `languageService.labelFor(card)` in `CardTile`
- [x] 6.4 `LearnScreen`: no card text changes (category names only); verify no regression

## 7. SettingsScreen — remove ptEn option

- [x] 7.1 Remove the third `_ModeCard` for ptEn from `settings_screen.dart`
- [x] 7.2 Update `settings_screen_test.dart`: expect exactly 2 options (Português, English)

## 8. Main specs — update

- [x] 8.1 Update `openspec/specs/language-settings/spec.md` to reflect 2 modes and card text resolution
- [x] 8.2 Update `openspec/specs/card-grid/spec.md` to reflect language-aware display

## 9. Verification

- [x] 9.1 Run all existing tests — confirm nothing is broken
- [x] 9.2 Run `flutter analyze` — confirm no warnings or errors
- [x] 9.3 Manual smoke test: switch language mode, verify card text and speech both change
