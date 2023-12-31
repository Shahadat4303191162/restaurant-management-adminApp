import 'package:cafe_admin/models/drawer_list_tile_model.dart';
import 'package:flutter/material.dart';

class DashboardItemView extends StatelessWidget {

  final DrawerListTileModel item;
  final Function(String) onPressed;

  const DashboardItemView({
    super.key,
    required this.item,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed(item.title);
      },
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5,),
            Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
