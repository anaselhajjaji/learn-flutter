class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});

  static List<Transaction> generateDummyTransactions() {
    return [
      /* dummy transactions */
      Transaction(
        id: 'id1',
        title: 'New Shoes',
        amount: 85,
        date: DateTime.now(),
      ),
      Transaction(
        id: 'id2',
        title: 'Groceries',
        amount: 200,
        date: DateTime.now().subtract(Duration(days: 1)),
      ),
      Transaction(
        id: 'id3',
        title: 'Clothes',
        amount: 150,
        date: DateTime.now().subtract(Duration(days: 2)),
      )
    ];
  }
}
