import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName = '/orderList';
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
    );
  }
}
