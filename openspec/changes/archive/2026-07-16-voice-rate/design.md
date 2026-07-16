## Context

Currently `TtsService` hardcodes `_tts.setSpeechRate(0.5)` in the constructor and never changes it. At 0.5 the speech is noticeably fast for the target audience. The `VoiceService` from the `voice-selection` change handles voice selection independently — rate is a separate concern that can be layered on top.

## Goals / Non-Goals

**Goals:**
- Set a slower default speech rate (0.35) for child-friendly enunciation
- Provide 4 predefined levels as large touch targets in Settings
- Persist the selected rate using SharedPreferences
- Apply the rate before every `speak()` call
- Include a play preview button per level

**Non-Goals:**
- Continuous slider (less predictable for caregivers; hard to hit on small targets)
- Pitch adjustment
- Per-card or per-category rate overrides
- Localization of the rate UI labels beyond pt-BR

## Decisions

### D1: Predefined levels vs. continuous slider

- **Chosen**: 4 predefined levels as large touch targets
  - **Muito Lento** — 0.25
  - **Lento** — 0.35 (default)
  - **Médio** — 0.45
  - **Rápido** — 0.55
- **Rationale**: Predefined levels are more accessible — each is a large tappable card (same visual pattern as language mode and voice cards), no fine motor skill needed to drag a slider. Caregivers can tap through to hear each one and pick intuitively.
- **Alternatives considered**:
  - Slider (0.1–0.7) — harder to hit precisely, and the difference between 0.32 and 0.35 is imperceptible to most users; unnecessary granularity.
  - 3 levels — 4 covers the spectrum well without overwhelming.

### D2: Default value

- **Chosen**: 0.35 ("Lento")
- **Rationale**: 0.5 (current) feels rushed for a child processing speech-to-card association. Dropping to 0.35 is a noticeable but not exaggerated slowdown — about 30% slower. Pilot-test feedback on device may adjust this later.
- **Alternatives considered**: 0.3 (might sound unnatural/droning), 0.4 (too close to current to feel different).

### D3: Rate applied in `TtsService.speak()`

- **Chosen**: `TtsService` stores `_speechRate` (default 0.35) and calls `_tts.setSpeechRate(_speechRate)` before every `speak()`
- **Rationale**: Previous hardcoded call in constructor only set it once. OS TTS engine can reset between calls, so applying before each speech is safer.
- **Alternatives considered**:
  - Set only on init and on change — may not survive engine resets.

### D4: Persistence key

- **Chosen**: SharedPreference key `"speechRate"` storing the double as string.
- **Rationale**: Matches existing pattern (`languageMode`, `voiceName`). Simple and consistent.

### D5: Preview phrase

- Same as voice-selection: "Oi, prazer, estou aqui para te ajudar." (PT) / "Hi, nice to meet you, I'm here to help you." (EN)

## Risks / Trade-offs

- **New default changes existing behavior**: Users upgrading will hear slower speech. This is intentional and positive; no migration needed because the rate was never persisted before.
- **Perceptual difference between levels is subjective**: What sounds "Lento" to one caregiver may sound "Médio" to another. Mitigation: the preview button lets them hear before choosing.
- **Rate interacts with voice quality**: Some voices sound better at certain rates. Mitigation: rate and voice are independent controls; the user can tune both.
