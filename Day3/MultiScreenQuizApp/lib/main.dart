import 'package:flutter/material.dart';

import 'screens/quiz_screen.dart';

void main() {
  runApp(const MultiScreenQuizApp());
}

class MultiScreenQuizApp extends StatelessWidget {
  const MultiScreenQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day 3 - Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3949AB)),
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
        useMaterial3: true,
      ),
      home: const QuizScreen(),
    );
  }
}
