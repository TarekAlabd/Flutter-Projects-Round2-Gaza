import 'package:flutter/material.dart';

class AddNewPaymentPage extends StatefulWidget {
  const AddNewPaymentPage({super.key});

  @override
  State<AddNewPaymentPage> createState() => _AddNewPaymentPageState();
}

class _AddNewPaymentPageState extends State<AddNewPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Payment'),
      ),
      body: const Center(
        child: Text('Add New Payment Page'),
      ),
    );
  }
}