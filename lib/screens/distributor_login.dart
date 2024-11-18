import 'package:flutter/material.dart';

class DistributorLoginPage extends StatelessWidget {
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _batchIdController = TextEditingController();
  final TextEditingController _retailerController = TextEditingController();

  void _submitDetails() {
    // Logic to update details on the blockchain
    // You can replace this with your blockchain interaction code.
    print("Medicine Name: ${_medicineNameController.text}");
    print("Batch ID: ${_batchIdController.text}");
    print("Retailer Address: ${_retailerController.text}");
    _medicineNameController.clear();
    _batchIdController.clear();
    _retailerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Distributor Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _medicineNameController,
              decoration: InputDecoration(labelText: 'Medicine Name'),
            ),
            TextField(
              controller: _batchIdController,
              decoration: InputDecoration(labelText: 'Batch ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _retailerController,
              decoration: InputDecoration(labelText: 'Retailer Address'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitDetails,
              child: Text('Submit Details'),
            ),
          ],
        ),
      ),
    );
  }
}
