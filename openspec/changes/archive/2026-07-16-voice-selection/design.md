## Context

Currently `TtsService` wraps `FlutterTts` with only `speak()`, `setLanguage()`, and `stop()`. Voice selection is entirely up to the device's default TTS engine. The app cannot choose which voice to use — crucial for a CAA app where voice quality directly impacts the child's communication experience.

`flutter_tts` provides `getVoices` which returns available system voices for the current language. Each voice has `name`, `locale`, and optional quality/feature flags. The app must filter by locale corresponding to the current `LanguageMode` (`pt-BR` or `en-US`), prioritize the most natural-sounding voices, and persist the selection.

## Goals / Non-Goals

**Goals:**
- Query available voices from `flutter_tts` for the current language
- Filter and prioritize up to 5 voices using a deterministic heuristic (prefer Google/neural/network voices for naturalness)
- Expose voices in Settings as selectable touch targets with a "listen" preview button
- Persist the selected voice name per language using `SharedPreferences`
- Apply the selected voice globally before any speech call
- Gracefully fall back to the first available voice when the saved voice is missing in a new language

**Non-Goals:**
- Downloading or installing new voices (system responsibility)
- Adjusting speech rate or pitch
- Per-card voice overrides
- Voice selection on iOS (Android only for now)

## Decisions

### D1: Dedicated `VoiceService` vs. extending `LanguageService`

- **Chosen**: New `VoiceService` class with its own Riverpod provider
- **Rationale**: Voice selection is an orthogonal concern — it has its own data source (flutter_tts voices), persistence key, and refresh lifecycle (changes when language changes). Keeping it separate avoids bloating `LanguageService` and follows single-responsibility.
- **Alternatives considered**:
  - Extend `LanguageService` — would mix language mode with voice concerns
  - Put logic directly in `TtsService` — would couple voice listing to low-level TTS

### D2: Voice prioritization heuristic

- **Chosen**: Rank by `name` prefix — prefer voices whose names start with or contain hints of neural/network quality: `"Google"`, `"Wavenet"`, `"Neural"`, `"High-quality"`, then natural-sounding engine names like `"en-US-Wavenet"`, `"pt-BR-Wavenet"`. Fall back to alphabetical order for remaining voices.
- **Rationale**: `flutter_tts` exposes voice names as strings. On Android, Google TTS names voices like `"pt-BR-Wavenet-A"`, `"pt-BR-Standard-A"`. Wavenet/Neural are consistently more natural. This heuristic is deterministic, requires no async quality probes, and works offline.
- **Alternatives considered**:
  - Use `voice.features` from flutter_tts (not always reliable across engines)
  - Let the user order manually (over-engineered for up to 5 items)

### D3: Persistence key per language

- **Chosen**: SharedPreference key `"voiceName"` storing the voice name string. Since voices are per-locale, the list is re-fetched on language change. If the saved name exists in the new list it's kept; otherwise fall back to index 0.
- **Rationale**: Simple, matches the existing `languageMode` persistence pattern. No need for a compound key because we always re-evaluate on language change.
- **Alternatives considered**:
  - Prefix key with locale (`"voiceName_pt-BR"`) — adds complexity for no benefit since we re-evaluate anyway

### D4: Voice applied before every speech call

- **Chosen**: `TtsService.speak()` calls `setVoice()` internally if a voice is configured, right after `setLanguage()`. `VoiceService` provides `applyToTts()` that `LanguageService.speak()` calls before speaking.
- **Rationale**: Guarantees the voice is always correct even if the OS TTS engine resets. Minimal overhead (setter is near-instant).
- **Alternatives considered**:
  - Set voice once at startup and on language change — may not survive engine resets

### D5: Preview phrase

- **PT**: "Oi, prazer, estou aqui para te ajudar."
- **EN**: "Hi, nice to meet you, I'm here to help you."
- **Rationale**: Friendly, warm, representative of the app's typical use, and short enough for a quick preview.

## Risks / Trade-offs

- **Voice availability varies by device**: The app only shows what the system provides. Some devices may have 0 voices for a locale (unlikely with Google TTS installed, but possible). Mitigation: `VoiceService` returns an empty list; the settings section shows a helpful message.
- **Heuristic may not always pick the best voice**: "Wavenet" vs "Standard" is clear, but less-known engines might be mis-ranked. Mitigation: The user hears the preview before choosing — they can pick any of the up to 5 options.
- **Preview audio is manual-only**: `flutter_tts.speak()` on the test phrase must be verified on device. Unit tests mock TTS and only verify the selection logic.
