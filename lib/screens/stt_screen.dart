import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextScreen extends StatefulWidget {
  const SpeechToTextScreen({super.key});

  @override
  State<SpeechToTextScreen> createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _transcribedText = "Press the button and start speaking";
  bool _isListening = false;

  Future<void> _checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      _showSnackbar("Microphone permission granted.", Colors.green);
    } else if (status.isDenied) {
      var result = await Permission.microphone.request();
      if (result.isGranted) {
        _showSnackbar("Microphone permission granted.", Colors.green);
      } else {
        _showSnackbar("Microphone permission denied.", Colors.red);
      }
    } else if (status.isPermanentlyDenied) {
      _showSnackbar(
        "Microphone permission permanently denied. Enable it from settings.",
        Colors.red,
      );
    }
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print("Status: $status");
        if (status == 'done' || status == 'notListening') {
         setState(() {
           print("stopping the listening");
           _isListening=false;
         });
        }
      },
      onError: (error) => print("Error: $error"),
    );

    if (available) {
      if (!mounted) return; // Ensure widget is mounted
      setState(() {
        _isListening = true;
        _transcribedText = "";
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _transcribedText = result.recognizedWords;
          });
        },
        listenFor: Duration(minutes: 60), // Adjust listening duration
        pauseFor: Duration(seconds: 10), // Adjust pause handling

      );
    } else {
      _showErrorDialog(
        "Speech recognition is not available or was denied.",
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkMicrophonePermission();
    // Set up the completion handler
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Speech-to-Text",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Card(
              elevation: 8,
              shadowColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height:400,
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      _transcribedText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            _isListening
                ? Column(
              children: const [
                CircularProgressIndicator(color: Colors.blueAccent),
                SizedBox(height: 10),
                Text(
                  "Listening...",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            )
                : const SizedBox(),
            const Spacer(),
            FloatingActionButton(
              onPressed: _isListening ? _stopListening : _startListening,
              backgroundColor: _isListening ? Colors.redAccent : Colors.blue,
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 8),
              Text('Error'),
            ],
          ),
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
}
