import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day 1 - Profile Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5AA8)),
        useMaterial3: true,
      ),
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  static const String _initialStatus = 'Ready to learn Flutter';
  static const String _clickedStatus = 'Profile button clicked successfully!';

  String statusMessage = _initialStatus;

  void _handleProfileButtonPressed() {
    setState(() {
      statusMessage = _clickedStatus;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Welcome to my Flutter Profile Card!'),
        ),
      );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF1E5AA8)),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFF1F2933),
                fontSize: 15,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FC),
      appBar: AppBar(
        title: const Text('Day 1 - Profile Card'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = constraints.maxWidth < 600
                  ? constraints.maxWidth
                  : 560;

              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: cardWidth),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 44,
                          backgroundColor: Color(0xFF1E5AA8),
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Emir Helshani',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF102A43),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Flutter Student Developer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF486581),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'I am learning Flutter during the Internal Internship Week II. '
                          'This profile card shows my name, role, contact information '
                          'and basic Flutter UI skills.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xFF334E68),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Divider(height: 1),
                        const SizedBox(height: 20),
                        _buildInfoRow(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: 'emirhelshani@gmail.com',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: '049 569 626',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          icon: Icons.school_outlined,
                          label: 'School',
                          value: 'British Gymnasium of Technology',
                        ),
                        const SizedBox(height: 24),
                        Text(
                          statusMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E5AA8),
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleProfileButtonPressed,
                            child: const Text('Click Me'),
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
