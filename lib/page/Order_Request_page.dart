import 'package:flutter/material.dart';

class OrderRequestPage extends StatelessWidget {
  static const String routeName = '/salesPage';
  const OrderRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
    );
  }
}
