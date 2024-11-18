import 'package:flutter/material.dart';
import 'transaction_manager.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionManager _transactionManager = TransactionManager(
    "http://127.0.0.1:7545",
    "0xf57f0412284cf687105F71fa90E96f929A9E4AC4", // Replace with your contract address
  );

  final TextEditingController _batchIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _distributorController = TextEditingController();
  final TextEditingController _retailerController = TextEditingController();

  Future<void> _createBatch() async {
    final batchId = BigInt.parse(_batchIdController.text);
    final name = _nameController.text;
    final distributor = EthereumAddress.fromHex(_distributorController.text);
    final retailer = EthereumAddress.fromHex(_retailerController.text);

    final success = await _transactionManager.createBatch(batchId, name, distributor, retailer);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Batch created successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error creating batch.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Initiate Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _batchIdController, decoration: InputDecoration(labelText: 'Batch ID')),
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _distributorController, decoration: InputDecoration(labelText: 'Distributor Address')),
            TextField(controller: _retailerController, decoration: InputDecoration(labelText: 'Retailer Address')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createBatch,
              child: Text('Create Batch'),
            ),
          ],
        ),
      ),
    );
  }
}
