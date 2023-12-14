import 'package:cafe_admin/utils/constants.dart';
import 'package:cafe_admin/widgets/dashbord_component/sell_info_view.dart';
import 'package:flutter/material.dart';

import '../models/dashboard_monthly_rev_model.dart';
import '../models/sell_info_dashboard_content_model.dart';
import '../models/trending_order_card_model.dart';
import '../widgets/dashbord_component/dashbaord_monthly_rev_view.dart';
import '../widgets/dashbord_component/trending_order_grid_View.dart';
import '../widgets/responsive.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  static const String routeName = '/dashboard content';

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Responsive(
              mobile: SellInfoCardGridView(
                crossAxisCount: _size.width < 850 ? 2 : 4,
                childAspectRatio: _size.width < 850 ? 1.3 : 1,
              ),
              tablet: SellInfoCardGridView(),
              desktop: SellInfoCardGridView(
                childAspectRatio: _size.width < 1100 ? 0.6 : 2,
              ),
            ),
            SizedBox(height: appPadding),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        RecentOrderRequested(),
                        if(Responsive.isMobile(context))
                          SizedBox(height: appPadding,),
                        if(Responsive.isMobile(context))
                          MonthlyRevenue(),
                      ],
                    )
                ),
                if(!Responsive.isMobile(context))
                  SizedBox(width: appPadding),
                if(!Responsive.isMobile(context))
                  Expanded(
                    flex: 5,
                    child: MonthlyRevenue()
                )
              ],
            ),
            SizedBox(height: appPadding),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: TrendingOrders()
                )
              ],
            ),
            SizedBox(height: appPadding),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: RecentlyPlacedOrders()
                )
              ],
            ),
            SizedBox(height: appPadding),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Rating(),
                        if(Responsive.isMobile(context))
                          SizedBox(height: appPadding,),
                        if(Responsive.isMobile(context))
                          Comments(),
                      ],
                    )
                ),
                if(!Responsive.isMobile(context))
                  SizedBox(width: appPadding),
                if(!Responsive.isMobile(context))
                  Expanded(
                      flex: 5,
                      child: Comments()
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Comments extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appPadding),
      decoration: const BoxDecoration(
        color: skyBlue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('COMMENTS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appPadding),
      decoration: const BoxDecoration(
        color: skyBlue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('RATING',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}

class RecentlyPlacedOrders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appPadding),
      decoration: const BoxDecoration(
        color: skyBlue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('RECENTLY PLACED ORDERS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            trailing: ElevatedButton(
              onPressed: () {  },
              style: ElevatedButton.styleFrom(
                  backgroundColor: dark
              ),
              child: const Text('View All',style: TextStyle(color: secondaryColor),),
            ),
          ),
          SizedBox(height: appPadding,),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith((states) => green),
              // decoration: const BoxDecoration(
              //   color: green
              // ),
              columns: const  [
                DataColumn(
                    label: Text('Order ID',style: TextStyle(fontWeight: FontWeight.bold))
                ),
                DataColumn(
                    label: Text('Product Name',style: TextStyle(fontWeight: FontWeight.bold))
                ),
                DataColumn(
                    label: Text('Order Status ',style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                DataColumn(
                    label: Text('Delivered Time ',style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                DataColumn(
                    label: Text('Price ',style: TextStyle(fontWeight: FontWeight.bold),)
                ),
              ],
              rows: const[
                DataRow(cells:[
                  DataCell(Text('gILkv0lhNayRl73J60QL')),
                  DataCell(Text('Mixed Chowmein')),
                  DataCell(Text('Pending')),
                  DataCell(Text('')),
                  DataCell(Text('260')),
                ]),
                DataRow(cells:[
                  DataCell(Text('0bUXUwFpyvJ8HOPL0YP8')),
                  DataCell(Text('Classic Zinger Burger')),
                  DataCell(Text('Processing')),
                  DataCell(Text('')),
                  DataCell(Text('320')),
                ]),
                DataRow(cells:[
                  DataCell(Text('K5jmvw0fNdDHdKrTdhTp')),
                  DataCell(Text('Chinese Masala Wrappo')),
                  DataCell(Text('Processing')),
                  DataCell(Text('')),
                  DataCell(Text('220')),
                ]),
                DataRow(cells:[
                  DataCell(Text('Cox9eIvYu6eFMVjSy1Dg')),
                  DataCell(Text('Mexican Noodles')),
                  DataCell(Text('Delivered')),
                  DataCell(Text('')),
                  DataCell(Text('330')),
                ]),
                DataRow(cells:[
                  DataCell(Text('QL1zl9Nj4F0Y0k9pxhzd')),
                  DataCell(Text('Chui Gosht - 1:5')),
                  DataCell(Text('Delivered')),
                  DataCell(Text('')),
                  DataCell(Text('450')),
                ]),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class TrendingOrders extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(appPadding),
      decoration: const BoxDecoration(
        color: skyBlue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('TRENDING ORDERS  (coming soon)',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: appPadding,),
          Responsive(
            mobile: TrendingOrdersCardGridView(
              crossAxisCount: _size.width < 650 ? 1 : 4,
              childAspectRatio: _size.width < 650 ? 1.3 : 1,
            ),
            tablet: TrendingOrdersCardGridView(
              crossAxisCount: _size.width < 950 ? 2 : 4,
              childAspectRatio: _size.width < 950 ? 1.3 : 1,
            ),
            desktop: TrendingOrdersCardGridView(
              childAspectRatio: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}



class MonthlyRevenue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appPadding),
      decoration: const BoxDecoration(
        color: skyBlue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('MONTHLY REVENUE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            trailing: ElevatedButton(
              onPressed: () {  },
              style: ElevatedButton.styleFrom(
                  backgroundColor: dark
              ),
              child: const Text('View All',style: TextStyle(color: secondaryColor),),
            ),
          ),
          SizedBox(height: appPadding,),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: demoRevenue.length,
              itemBuilder: (context, index) =>
                  DashboardMonthlyRevView(info: demoRevenue[index],),)
        ],
      ),
    );
  }
}

class RecentOrderRequested extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appPadding),
      decoration: const BoxDecoration(
        color: skyBlue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('RECENT ORDERS REQUESTED',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            trailing: ElevatedButton(
              onPressed: () {  },
              style: ElevatedButton.styleFrom(
                backgroundColor: dark
              ),
              child: const Text('View All',style: TextStyle(color: secondaryColor),),
            ),
          ),
          SizedBox(height: appPadding,),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text('Food Item',style: TextStyle(fontWeight: FontWeight.bold))
                ),
                DataColumn(
                    label: Text('Price',style: TextStyle(fontWeight: FontWeight.bold))
                ),
                DataColumn(
                    label: Text('Product ID',style: TextStyle(fontWeight: FontWeight.bold),)
                )
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('Mixed Chowmein')),
                  DataCell(Text('260')),
                  DataCell(Text('0bUXUwFpyvJ8HOPL0YP8')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Classic Zinger Burger')),
                  DataCell(Text('320')),
                  DataCell(Text('K5jmvw0fNdDHdKrTdhTp')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Chinese Masala Wrappo')),
                  DataCell(Text('220')),
                  DataCell(Text('QL1zl9Nj4F0Y0k9pxhzd')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Mexican Noodles')),
                  DataCell(Text('330')),
                  DataCell(Text('gILkv0lhNayRl73J60QL')),
                ]),

                DataRow(cells: [
                  DataCell(Text('Chui Gosht - 1:5')),
                  DataCell(Text('450')),
                  DataCell(Text('Cox9eIvYu6eFMVjSy1Dg')),
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SellInfoCardGridView extends StatelessWidget{
  const SellInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
    return
      GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: infoItem.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: appPadding,
          mainAxisSpacing: appPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context,index) => SellInfoView(item: infoItem[index]),

    );
  }
}

class TrendingOrdersCardGridView extends StatelessWidget {

  const TrendingOrdersCardGridView({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tOrderInfo.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: appPadding,
              mainAxisSpacing: appPadding,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) => TrendingOrderView(item: tOrderInfo[index],),);
  }
}

