import 'package:flutter/material.dart';

import 'models/tracker_item.dart';

void main() {
  runApp(const TaskExpenseTrackerApp());
}

class TaskExpenseTrackerApp extends StatelessWidget {
  const TaskExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day 3 - Tracker App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00897B)),
        scaffoldBackgroundColor: const Color(0xFFF3F7F6),
        useMaterial3: true,
      ),
      home: const TrackerHomeScreen(),
    );
  }
}

class TrackerHomeScreen extends StatefulWidget {
  const TrackerHomeScreen({super.key});

  @override
  State<TrackerHomeScreen> createState() => _TrackerHomeScreenState();
}

class _TrackerHomeScreenState extends State<TrackerHomeScreen> {
  final List<TrackerItem> trackerItems = [
    TrackerItem(
      title: 'Buy Flutter course notes',
      amount: 15.0,
      description: 'Study materials for internship practice.',
    ),
    TrackerItem(
      title: 'Complete UI practice task',
      amount: 0,
      description: 'Finish the assigned layout challenge.',
      isPaid: true,
    ),
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> showAddItemDialog() async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Tracker Item'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      prefixIcon: Icon(Icons.edit_note_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title cannot be empty.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      prefixIcon: Icon(Icons.attach_money_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Amount cannot be empty.';
                      }

                      if (double.tryParse(value.trim()) == null) {
                        return 'Enter a valid number.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.notes_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description cannot be empty.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (!(formKey.currentState?.validate() ?? false)) {
                  return;
                }

                setState(() {
                  trackerItems.add(
                    TrackerItem(
                      title: titleController.text.trim(),
                      amount: double.parse(amountController.text.trim()),
                      description: descriptionController.text.trim(),
                    ),
                  );
                });

                Navigator.of(context).pop();
                _showMessage('Item added successfully.');
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    titleController.dispose();
    amountController.dispose();
    descriptionController.dispose();
  }

  void toggleItemStatus(int index, bool value) {
    setState(() {
      trackerItems[index].isPaid = value;
    });

    _showMessage(
      value ? 'Item marked as paid/done.' : 'Item marked as unpaid/active.',
    );
  }

  void deleteItem(int index) {
    final String deletedTitle = trackerItems[index].title;

    setState(() {
      trackerItems.removeAt(index);
    });

    _showMessage('$deletedTitle deleted.');
  }

  @override
  Widget build(BuildContext context) {
    final int paidItemsCount = trackerItems.where((item) => item.isPaid).length;
    final double totalAmount = trackerItems.fold(
      0,
      (sum, item) => sum + item.amount,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Day 3 - Tracker App'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddItemDialog,
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Task/Expense Tracker',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF102A43),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Track your items, update their status, and manage totals with setState.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xFF486581),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildSummaryChip(
                              label: 'Items',
                              value: trackerItems.length.toString(),
                              icon: Icons.list_alt_rounded,
                            ),
                            _buildSummaryChip(
                              label: 'Paid/Done',
                              value: paidItemsCount.toString(),
                              icon: Icons.check_circle_outline_rounded,
                            ),
                            _buildSummaryChip(
                              label: 'Total Amount',
                              value: '\$${totalAmount.toStringAsFixed(2)}',
                              icon: Icons.payments_outlined,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: trackerItems.isEmpty
                      ? const Center(
                          child: Text(
                            'No tracker items yet. Add one to get started.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF486581),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: trackerItems.length,
                          itemBuilder: (context, index) {
                            final TrackerItem item = trackerItems[index];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF102A43),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            item.description,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              height: 1.4,
                                              color: Color(0xFF486581),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Amount: \$${item.amount.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF0B6E4F),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Switch(
                                                value: item.isPaid,
                                                onChanged: (value) =>
                                                    toggleItemStatus(
                                                      index,
                                                      value,
                                                    ),
                                              ),
                                              Text(
                                                item.isPaid
                                                    ? 'Paid / Done'
                                                    : 'Active / Unpaid',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: item.isPaid
                                                      ? const Color(0xFF2E7D32)
                                                      : const Color(0xFFEF6C00),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => deleteItem(index),
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.redAccent,
                                      ),
                                      tooltip: 'Delete item',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryChip({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF00695C)),
          const SizedBox(width: 8),
          Text(
            '$label: $value',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF102A43),
            ),
          ),
        ],
      ),
    );
  }
}
