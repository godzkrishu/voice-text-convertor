import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsScreen extends StatefulWidget {
  @override
  _TtsScreenState createState() => _TtsScreenState();
}

class _TtsScreenState extends State<TtsScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _textController = TextEditingController();
  TtsState _ttsState = TtsState.stopped;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Set up the completion handler
    flutterTts.setCompletionHandler(() {
      setState(() {
        _ttsState = TtsState.stopped;
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
  // Play text-to-speech
  Future<void> _play() async {
    if (_textController.text.isEmpty) {
      _showErrorDialog("Please enter some text to convert to speech.", context);
      return;
    }

    try {
      await flutterTts.setLanguage("en-IN"); // Set the accent to Indian English
      await flutterTts.setPitch(1.2);
      await flutterTts.setSpeechRate(0.5); // Slower rate
      await flutterTts.speak(_textController.text);
      setState(() {
        _ttsState = TtsState.playing;
      });
    } catch (e) {
      _showErrorDialog("An error occurred while trying to play text-to-speech.", context);
    }
  }

  // Pause TTS
  Future<void> _pause() async {
    await flutterTts.pause();
    setState(() {
      _ttsState = TtsState.paused;
    });
  }

  // Stop TTS
  Future<void> _stop() async {
    await flutterTts.stop();
    setState(() {
      _ttsState = TtsState.stopped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text to Speech',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Enter text below and convert it into speech!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 20),
                // Text Input Box
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _textController,
                    maxLines: 15,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      hintText: 'Enter text here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.play_arrow,
                      label: "Play",
                      onPressed: _ttsState == TtsState.playing ? null : _play,
                      color: Colors.green,
                    ),
                    _buildActionButton(
                      icon: Icons.pause,
                      label: "Pause",
                      onPressed: _ttsState == TtsState.paused ? null : _pause,
                      color: Colors.orange,
                    ),
                    _buildActionButton(
                      icon: Icons.stop,
                      label: "Stop",
                      onPressed: _ttsState == TtsState.stopped ? null : _stop,
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Footer Information
                const Text(
                  "Ensure your device's volume is turned up for the best experience.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build action buttons
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

enum TtsState { playing, paused, stopped }

// Show error dialog
void _showErrorDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
