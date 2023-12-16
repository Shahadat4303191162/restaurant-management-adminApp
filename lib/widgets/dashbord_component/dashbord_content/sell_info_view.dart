import 'package:cafe_admin/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../models/sell_info_dashboard_content_model.dart';

class SellInfoView extends StatelessWidget {

  final SellInfoDashboardContentModel item;
  const SellInfoView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: skyBlue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(item.title),
            trailing: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(item.percentage),
              ),
            ),
            subtitle: Text(item.numOfAmount,style: TextStyle(fontSize: 20),),
          ),
          //Text(item.numOfAmount,style: TextStyle(fontSize: 25),),
        ],
      ),
    );
  }
}
