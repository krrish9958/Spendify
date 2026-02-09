class Expense {
  final String title;
  final String note;
  final double amount;
  final DateTime date;
  final String category;
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      title: json['title'],
      note: json['note'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }

  Expense({
    required this.title,
    required this.note,
    required this.amount,
    required this.date,
    required this.category,
  });
}
