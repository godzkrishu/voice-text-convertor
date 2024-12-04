import 'package:flutter/material.dart';
import 'screens/stt_screen.dart';
import 'screens/tts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STT & TTS Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Speech & Text Conversion",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App title or welcome header
            const Text(
              "Welcome to Speech & Text Conversion",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),

            // Speech-to-Text Button
            _buildButton(
              context,
              "Speech-to-Text",
              Icons.mic,
              const SpeechToTextScreen(),
              Colors.blueAccent,
              Colors.lightBlue,
            ),

            const SizedBox(height: 20),

            // Text-to-Speech Button
            _buildButton(
              context,
              "Text-to-Speech",
              Icons.volume_up,
              TtsScreen(),
              Colors.greenAccent,
              Colors.green,
            ),

            const SizedBox(height: 40),

            // App footer or tagline
            const Text(
              "Convert your speech to text & text to speech effortlessly!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build styled buttons
  Widget _buildButton(
      BuildContext context,
      String label,
      IconData icon,
      Widget screen,
      Color startColor,
      Color endColor,
      ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: endColor.withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
