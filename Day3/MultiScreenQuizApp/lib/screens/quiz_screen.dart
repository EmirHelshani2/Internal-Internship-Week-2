import 'package:flutter/material.dart';

import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Question> questions = const [
    Question(
      questionText:
          'Which widget is commonly used for vertical layouts in Flutter?',
      options: ['Row', 'Column', 'Stack', 'Container'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Which method rebuilds the UI in a StatefulWidget?',
      options: ['build()', 'dispose()', 'setState()', 'createState()'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText:
          'Which widget helps create a new page navigation in Flutter?',
      options: ['Navigator', 'Expanded', 'Padding', 'Align'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'What is used to add empty space between widgets?',
      options: ['Spacer', 'Card', 'Text', 'IconButton'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'Which widget allows scrolling when content is too tall?',
      options: ['SafeArea', 'Scaffold', 'SingleChildScrollView', 'Center'],
      correctAnswerIndex: 2,
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  bool isNavigatingToResult = false;

  Future<void> answerQuestion(int selectedAnswerIndex) async {
    if (isNavigatingToResult) {
      return;
    }

    final Question currentQuestion = questions[currentQuestionIndex];
    final bool isCorrect =
        selectedAnswerIndex == currentQuestion.correctAnswerIndex;
    final int updatedScore = isCorrect ? score + 1 : score;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            isCorrect ? 'Correct answer!' : 'Wrong answer. Try the next one.',
          ),
          duration: const Duration(milliseconds: 500),
        ),
      );

    if (currentQuestionIndex == questions.length - 1) {
      setState(() {
        score = updatedScore;
        isNavigatingToResult = true;
      });

      await Future<void>.delayed(const Duration(milliseconds: 350));

      if (!mounted) {
        return;
      }

      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => ResultScreen(
            score: score,
            totalQuestions: questions.length,
            onRestart: restartQuiz,
          ),
        ),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        isNavigatingToResult = false;
      });

      return;
    }

    setState(() {
      score = updatedScore;
      currentQuestionIndex++;
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      isNavigatingToResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Day 3 - Quiz App'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double contentWidth = constraints.maxWidth < 640
                  ? constraints.maxWidth
                  : 560;

              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFF3949AB),
                            child: Icon(
                              Icons.quiz_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: Text(
                            'Multi-screen Quiz App',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF102A43),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Question ${currentQuestionIndex + 1} of ${questions.length}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF486581),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: (currentQuestionIndex + 1) / questions.length,
                          borderRadius: BorderRadius.circular(12),
                          minHeight: 8,
                        ),
                        const SizedBox(height: 24),
                        Card(
                          color: const Color(0xFFE8EAF6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              currentQuestion.questionText,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: Color(0xFF102A43),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...List<
                          Widget
                        >.generate(currentQuestion.options.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => answerQuestion(index),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  '${String.fromCharCode(65 + index)}. ${currentQuestion.options[index]}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 8),
                        Text(
                          'Current score: $score',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF486581),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
