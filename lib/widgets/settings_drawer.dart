import 'package:cafe_admin/page/Vat_discount_page.dart';
import 'package:cafe_admin/page/coustomizable_product.dart';
import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.blue.shade400,
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(context, Vat_DiscountPage.routeName),
            leading: const Icon(Icons.discount),
            title: const Text('Vat_Discount'),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(context, CustomizeProduct.routeName),
            leading: const Icon(Icons.edit),
            title: const Text('Customizable Product'),
          ),
        ],
      ),
    );
  }
}
