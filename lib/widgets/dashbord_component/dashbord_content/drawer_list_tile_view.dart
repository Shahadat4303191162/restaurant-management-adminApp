import 'package:cafe_admin/models/drawer_list_tile_model.dart';
import 'package:flutter/material.dart';

class DrawerListTileView extends StatelessWidget {

  final DrawerListTileModel item;
  final Function(String) onPressed;

  const DrawerListTileView({super.key,required this.item,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(item.title);
      },
      child: (item.subItems != null && item.subItems!.isNotEmpty)
          ? ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 16.0),
              leading: Icon(item.icon),
              title: Text(item.title),
              children: item.subItems!.map((subItem) {
                return DrawerListTileView(
                  item: subItem,
                  onPressed: onPressed,
                );
              }).toList(),
            )
          : ListTile(
              title: Text(item.title),
              leading: Icon(item.icon),
            ),
    );
  }
}
