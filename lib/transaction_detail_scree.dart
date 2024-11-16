import 'package:flutter/material.dart';
import 'transaction_manager.dart';

class TransactionDetailScreen extends StatefulWidget {
  @override
  _TransactionDetailScreenState createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final TransactionManager _transactionManager = TransactionManager(
    "http://127.0.0.1:7545",
    "0xf57f0412284cf687105F71fa90E96f929A9E4AC4", // Replace with your contract address
  );
  List<dynamic> _transactions = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadTransactionHistory();
  }

  Future<void> _loadTransactionHistory() async {
    try {
      final transactions = await _transactionManager.fetchTransactionHistory();
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading transactions: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction History')),
      body: _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = _transactions[index];
                    return ListTile(
                      title: Text('Transaction #${transaction[0]}'),
                      subtitle: Text('Receiver: ${transaction[1]}, Amount: ${transaction[2]}'),
                    );
                  },
                ),
    );
  }
}
