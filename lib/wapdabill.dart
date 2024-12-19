import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BillInputScreen(),
    );
  }
}

class BillInputScreen extends StatefulWidget {
  const BillInputScreen({super.key});

  @override
  State<BillInputScreen> createState() => _BillInputScreenState();
}

class _BillInputScreenState extends State<BillInputScreen> {
  final _unitController = TextEditingController();
  String _result = '';

  void calculateBill() {
    if (_unitController.text.isEmpty) {
      setState(() {
        _result = 'Please enter the units consumed.';
      });
      return;
    }

    int? unitConsume = int.tryParse(_unitController.text);
    if (unitConsume == null) {
      setState(() {
        _result = 'Please enter a valid number.';
      });
      return;
    }

    int pricePerUnit = unitConsume < 200 ? 30 : 50;
    int totalBill = unitConsume * pricePerUnit;
    double tax = totalBill * 17 / 100;
    double billWithTax = totalBill + tax;

    setState(() {
      _result = '''
Unit Consumed: $unitConsume
Price per Unit: Rs $pricePerUnit
Total Bill: Rs $totalBill
Tax (17%): Rs ${tax.toStringAsFixed(2)}
Bill with Tax: Rs ${billWithTax.toStringAsFixed(2)}
      ''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electricity Bill Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 1.5),
              ),
              child: TextFormField(
                controller: _unitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Please enter units consumed',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: calculateBill,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Calculate Bill'),
              ),
            ),
            const SizedBox(height: 16),
            if (_result.isNotEmpty)
              Text(
                _result,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
