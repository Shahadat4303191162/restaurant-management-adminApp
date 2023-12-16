import 'package:cafe_admin/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../models/trending_order_card_model.dart';


class TrendingOrderView extends StatelessWidget {
  final TrendingOrderDashboardContentModel item;
  const TrendingOrderView({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10)),
              child: Image.asset(
                  'images/img_1.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text('$currencysymbol ${item.price}',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Order ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${item.order}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Income ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '$currencysymbol ${item.income}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: appPadding,)
        ],
      ),
    );
  }
}
