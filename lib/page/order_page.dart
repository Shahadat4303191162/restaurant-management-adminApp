import 'package:cafe_admin/provider/order_provider.dart';
import 'package:cafe_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_list_page.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/Order';
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => ListView(
          padding: const EdgeInsets.all(appPadding),
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Text('Today',style: Theme.of(context).textTheme.titleLarge,),
                        const SizedBox(height: 5,),
                        const Divider(height: 2,color: Colors.black,),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text ('Total Order'),
                                SizedBox(height: 5,),
                                Text('${provider.getFilteredListBySingleDay(DateTime.now()).length}',style: Theme.of(context).textTheme.titleMedium)
                              ],
                            ),
                            Column(
                              children: [
                                Text ('Total Sell'),
                                SizedBox(height: 5,),
                                Text('$currencysymbol ${provider.getTotalSaleBySingleDate(DateTime.now())}',style: Theme.of(context).textTheme.titleMedium)
                              ],
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(
                                context,
                                OrderListPage.routeName,
                                arguments: OrderFilter.TODAY,
                              ),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Text('Yesterday',style: Theme.of(context).textTheme.titleLarge,),
                          const SizedBox(height: 5,),
                          const Divider(height: 2,color: Colors.black),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text ('Total Order'),
                                  const SizedBox(height: 5,),
                                  Text('${provider
                                      .getFilteredListBySingleDay(DateTime.now()
                                      .subtract(const Duration(days: 1))).length}',
                                    style: Theme.of(context).textTheme.titleMedium,)
                                ],
                              ),
                              Column(
                                children: [
                                  const Text ('Total Sell'),
                                  const SizedBox(height: 5,),
                                  Text('$currencysymbol ${provider.getTotalSaleBySingleDate(DateTime.now().subtract(const Duration(days: 1)))}',
                                      style: Theme.of(context).textTheme.titleMedium)
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(
                                  context,
                                  OrderListPage.routeName,
                                  arguments: OrderFilter.YESTERDAY,
                                ),
                            child: const Text('View All'),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Text('Last 7 days',style: Theme.of(context).textTheme.titleLarge,),
                        const SizedBox(height: 5,),
                        const Divider(height: 2,color: Colors.black,),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text ('Total Order'),
                                const SizedBox(height: 5,),
                                Text('${provider.getFilteredListByWeek(
                                    DateTime.now().subtract(const Duration(days: 7))).length}',
                                    style: Theme.of(context).textTheme.titleMedium)                              ],
                            ),
                            Column(
                              children: [
                                const Text ('Total Sell'),
                                const SizedBox(height: 5,),
                                Text('$currencysymbol ${provider.getTotalSaleByWeek(
                                    DateTime.now().subtract(const Duration(days: 7)))}',
                                    style: Theme.of(context).textTheme.titleMedium)                              ],
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(
                                context,
                                OrderListPage.routeName,
                                arguments: OrderFilter.SEVER_DAYS,
                              ),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Text('This Month',style: Theme.of(context).textTheme.titleLarge,),
                          const SizedBox(height: 5,),
                          const Divider(height: 2,color: Colors.black),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text ('Total Order'),
                                  const SizedBox(height: 5,),
                                  Text('${provider.getFilteredListByMonth(DateTime.now()).length}',
                                      style: Theme.of(context).textTheme.titleMedium)
                                ],
                              ),
                              Column(
                                children: [
                                  const Text ('Total Sell'),
                                  const SizedBox(height: 5,),
                                  Text('$currencysymbol ${provider.getTotalSaleByMonth(DateTime.now())}',
                                      style: Theme.of(context).textTheme.titleMedium)
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(
                                  context,
                                  OrderListPage.routeName,
                                  arguments: OrderFilter.THIS_MONTH,
                                ),
                            child: const Text('View All'),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Text('Last 3 Months',style: Theme.of(context).textTheme.titleLarge,),
                        const SizedBox(height: 5,),
                        const Divider(height: 2,color: Colors.black,),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text ('Total Order'),
                                const SizedBox(height: 5,),
                                Text('${provider.getFilteredListByWeek(
                                    DateTime.now().subtract(const Duration(days: 90))).length}',
                                    style: Theme.of(context).textTheme.titleMedium)                                ],
                            ),
                            Column(
                              children: [
                                const Text ('Total Sell'),
                                const SizedBox(height: 5,),
                                Text('$currencysymbol ${provider.getTotalSaleByWeek(
                                    DateTime.now().subtract(const Duration(days: 90)))}',
                                    style: Theme.of(context).textTheme.titleMedium)                               ],
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(
                                context,
                                OrderListPage.routeName,
                                arguments: OrderFilter.THREE_MONTH,
                              ),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Text('This year',style: Theme.of(context).textTheme.titleLarge,),
                          const SizedBox(height: 5,),
                          const Divider(height: 2,color: Colors.black),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text ('Total Order'),
                                  const SizedBox(height: 5,),
                                  Text('${provider.getFilteredListByYear(DateTime.now()).length}',
                                      style: Theme.of(context).textTheme.titleMedium)
                                ],
                              ),
                              Column(
                                children: [
                                  const Text ('Total Sell'),
                                  const SizedBox(height: 5,),
                                  Text('$currencysymbol ${provider.getTotalSaleByYear(DateTime.now())}',
                                      style: Theme.of(context).textTheme.titleMedium)
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(
                                  context,
                                  OrderListPage.routeName,
                                  arguments: OrderFilter.THIS_YEAR,
                                ),
                            child: const Text('View All'),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Text('All Time',style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 5,),
                    const Divider(height: 2,color: Colors.black),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text ('Total Order'),
                            const SizedBox(height: 5,),
                            Text('${provider.orderPaymentList.length}',
                                style: Theme.of(context).textTheme.titleMedium)
                          ],
                        ),
                        Column(
                          children: [
                            const Text ('Total Sell'),
                            const SizedBox(height: 5,),
                            Text('$currencysymbol ${provider.getTotalSale()}',
                                style: Theme.of(context).textTheme.titleMedium)
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(
                            context,
                            OrderListPage.routeName,
                            arguments: OrderFilter.ALL_TIME,
                          ),
                      child: const Text('View All'),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
