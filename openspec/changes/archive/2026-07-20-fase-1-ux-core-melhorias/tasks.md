## 1. SentenceNotifier — Indexed Operations

- [x] 1.1 Add `removeAt(int index)` method to `SentenceNotifier`
- [x] 1.2 Add `reorder(int oldIndex, int newIndex)` method to `SentenceNotifier`

## 2. Sentence Bar — Reorder & Specific Removal

- [x] 2.1 Add reorder controls (left/right arrows) and tap-to-remove to `SentenceBar` widget
- [x] 2.2 Add tap handler to `_MiniCard` to remove specific card via `removeAt()`
- [x] 2.3 Add move-left/move-right arrow buttons for reordering cards
- [x] 2.4 Update `SentenceBar` tests for new interactions

## 3. TTS Visual Feedback

- [x] 3.1 Add `speakingIndexProvider` StateProvider for reactive speech tracking
- [x] 3.2 Implement `_speakSentence()` async method that iterates cards, updates `speakingIndexProvider`, and awaits TTS completion
- [x] 3.3 Add visual highlight state (animated border/background) to `_MiniCard` when its index matches `speakingIndex`
- [x] 3.4 Add Stop button that replaces Speak button during active speech (calls `tts.stop()`)
- [x] 3.5 Disable Speak button and action buttons while TTS is active

## 4. Category Card Bridge

- [x] 4.1 Create `CategoryChipBar` widget (horizontal scrollable row of category chips)
- [x] 4.2 Add selected category state to ConverseScreen (default: "Geral")
- [x] 4.3 Inject `PictogramRepository` into ConverseScreen to load categories
- [x] 4.4 Filter card grid by selected category
- [x] 4.5 Update ConverseScreen layout: insert `CategoryChipBar` between action buttons and card grid
- [x] 4.6 Verify LearnScreen behavior remains unchanged

## 5. Saved Phrases

- [x] 5.1 Create `SavedPhrase` model with `id`, `name`, `cardIds`, `createdAt`
- [x] 5.2 Create `SavedPhrasesNotifier` (StateNotifier) with `load()`, `save()`, `delete()`, `loadInto()` methods
- [x] 5.3 Create `savedPhrasesProvider` Riverpod provider
- [x] 5.4 Persist saved phrases via `SharedPreferences` (JSON serialization)
- [x] 5.5 Add Save button to ConverseScreen (with optional name dialog)
- [x] 5.6 Create `SavedPhrasesScreen` with list, tap-to-load, long-press-to-delete
- [x] 5.7 Add navigation entry to HomeScreen for saved phrases (`/saved-phrases` route)
- [x] 5.8 Write tests for `SavedPhrasesNotifier` (8 tests)

## 6. High Contrast Mode

- [x] 6.1 Add high contrast color palette to `DesignTokens` (hcBackground, hcText, hcBrand, etc.)
- [x] 6.2 Implement `AppTheme.highContrast()` with real high-contrast `ThemeData`
- [x] 6.3 Create `highContrastModeProvider` (StateNotifierProvider\<HighContrastNotifier, bool\>) with SharedPreferences persistence
- [x] 6.4 Add high contrast toggle to SettingsScreen
- [x] 6.5 Wire theme switching in `app.dart` to listen to `highContrastModeProvider`
