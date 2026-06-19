import 'package:flutter/material.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day 1 - Grade Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        useMaterial3: true,
      ),
      home: const GradeCalculatorPage(),
    );
  }
}

class GradeCalculatorPage extends StatefulWidget {
  const GradeCalculatorPage({super.key});

  @override
  State<GradeCalculatorPage> createState() => _GradeCalculatorPageState();
}

class _GradeCalculatorPageState extends State<GradeCalculatorPage> {
  final TextEditingController firstGradeController = TextEditingController();
  final TextEditingController secondGradeController = TextEditingController();
  final TextEditingController thirdGradeController = TextEditingController();

  String averageResult = '';
  String statusText = '';

  @override
  void dispose() {
    firstGradeController.dispose();
    secondGradeController.dispose();
    thirdGradeController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void calculateAverage() {
    final String firstValue = firstGradeController.text.trim();
    final String secondValue = secondGradeController.text.trim();
    final String thirdValue = thirdGradeController.text.trim();

    if (firstValue.isEmpty || secondValue.isEmpty || thirdValue.isEmpty) {
      _showMessage('Please fill in all fields.');
      return;
    }

    final double? firstGrade = double.tryParse(firstValue);
    final double? secondGrade = double.tryParse(secondValue);
    final double? thirdGrade = double.tryParse(thirdValue);

    if (firstGrade == null || secondGrade == null || thirdGrade == null) {
      _showMessage('Please enter only numeric values.');
      return;
    }

    final double average = (firstGrade + secondGrade + thirdGrade) / 3;

    setState(() {
      averageResult = average.toStringAsFixed(2);
      statusText = average >= 50 ? 'Kalon' : 'Duhet përmirësim';
    });
  }

  Widget _buildGradeField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Widget _buildResultCard() {
    if (averageResult.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Enter your grades and press the button to see the average result.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Color(0xFF0D47A1)),
        ),
      );
    }

    final bool isPassing = statusText == 'Kalon';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isPassing ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Average: $averageResult',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF102A43),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Status: $statusText',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isPassing
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFFEF6C00),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day 1 - Grade Calculator'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double contentWidth = constraints.maxWidth < 640
                  ? constraints.maxWidth
                  : 520;

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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: Color(0xFF1565C0),
                            child: Icon(
                              Icons.calculate_rounded,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: Text(
                            'Grade Calculator UI',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF102A43),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            'Enter three grades or points to calculate the average.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              color: Color(0xFF486581),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildGradeField(
                          controller: firstGradeController,
                          label: 'First grade',
                          icon: Icons.looks_one_rounded,
                        ),
                        const SizedBox(height: 16),
                        _buildGradeField(
                          controller: secondGradeController,
                          label: 'Second grade',
                          icon: Icons.looks_two_rounded,
                        ),
                        const SizedBox(height: 16),
                        _buildGradeField(
                          controller: thirdGradeController,
                          label: 'Third grade',
                          icon: Icons.looks_3_rounded,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: calculateAverage,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Calculate Average'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildResultCard(),
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
