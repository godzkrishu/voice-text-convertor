---

# Text-to-Speech and Speech-to-Text Flutter App

A comprehensive Flutter application that integrates both **Text-to-Speech (TTS)** and **Speech-to-Text (STT)** functionalities. The app enables seamless interaction between text and voice, offering a user-friendly experience.

---

## Features

- 🎤 **Speech-to-Text (STT)**: Convert your speech into text in real-time.
- 📢 **Text-to-Speech (TTS)**: Play audio versions of your written text.
- 🔒 **Permission Handling**: Dynamically manage microphone and storage permissions.
- 🛠 **Modular Architecture**: Separate screens for STT and TTS functionality.
- 💡 **Clean UI**: Visually appealing and responsive design.

---

## Project Structure

```bash
text_speech/
├── lib/
│   ├── main.dart                # Entry point for the app
│   ├── screens/
│   │   ├── stt_screen.dart      # Speech-to-Text screen
│   │   └── tts_screen.dart      # Text-to-Speech screen
├── pubspec.yaml                 # Flutter dependencies
└── README.md                    # Project documentation
```

---

## Dependencies

This app relies on the following Flutter/Dart packages:

- **speech_to_text**: For real-time speech recognition (STT).
- **flutter_tts**: To convert text to speech (TTS).
- **permission_handler**: To handle permissions for microphone and storage.

---

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/godzkrishu/text-to-speech
   cd text-to-speech
   ```

2. Install the dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

---

## Usage

1. **Launch the app**: Open it on your device or emulator.
2. **Speech-to-Text**:
   - Navigate to the **STT screen**.
   - Tap the microphone button to start speaking and view the transcribed text.
3. **Text-to-Speech**:
   - Navigate to the **TTS screen**.
   - Type your text and press the play button to hear the audio.

---
