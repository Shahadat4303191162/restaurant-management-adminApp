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
              decoration: BoxDecoration(
                color: green
              ),
              columns: const [
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
              rows: [

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
            title: Text('TRENDING ORDERS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
              rows: [],
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

