class Expense {
  String id;
  String title;
  double amount;
  DateTime date;
  String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['_id'],
      title: map['title'],
      amount: map['amount'] is int ? (map['amount'] as int).toDouble() : map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
    };
  }
}
