import 'package:flutter/material.dart';

class OrderRequestPage extends StatelessWidget {
  static const String routeName = '/salesPage';
  const OrderRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Order Request List'),
      ),
    );
  }
}
