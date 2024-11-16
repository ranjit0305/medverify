import 'package:flutter/material.dart';
import 'transaction_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedVerify DApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _privateKeyController = TextEditingController();
  
  String rpcUrl = "http://127.0.0.1:7545"; // Replace with your RPC URL
  String contractAddress = "YOUR_CONTRACT_ADDRESS"; // Replace with your contract address
  late TransactionManager transactionManager;

  @override
  void initState() {
    super.initState();
    transactionManager = TransactionManager(rpcUrl, contractAddress);
  }

  void _initiateTransaction() async {
    String receiver = _receiverController.text;
    BigInt amount = BigInt.from(int.parse(_amountController.text));
    String privateKey = _privateKeyController.text;

    await transactionManager.initiateTransaction(receiver, amount, privateKey);
    _receiverController.clear();
    _amountController.clear();
    _privateKeyController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction initiated!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MedVerify DApp')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _receiverController,
              decoration: InputDecoration(labelText: 'Receiver Address'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount (in Wei)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _privateKeyController,
              decoration: InputDecoration(labelText: 'Private Key'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _initiateTransaction,
              child: Text('Initiate Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
