class TrackerItem {
  TrackerItem({
    required this.title,
    required this.amount,
    required this.description,
    this.isPaid = false,
  });

  final String title;
  final double amount;
  final String description;
  bool isPaid;
}
