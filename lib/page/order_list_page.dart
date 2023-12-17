import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/order_provider.dart';
import '../utils/constants.dart';
import 'order_details_page.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName = '/orderList';
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = ModalRoute.of(context)!.settings.arguments as OrderFilter;
    final orderList = Provider.of<OrderProvider>(context,listen: false).getFilteredList(filter);
    orderList.sort((orderM1,orderM2) => orderM2.paymentDate.timestamp.compareTo(orderM1.paymentDate.timestamp));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Order List'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith((states) => green),
            columns: const  [
              DataColumn(
                  label: Text('Order Time',style: TextStyle(fontWeight: FontWeight.bold))
              ),
              DataColumn(
                  label: Text('Order Id',style: TextStyle(fontWeight: FontWeight.bold))
              ),
              DataColumn(
                  label: Text('Payment Method ',style: TextStyle(fontWeight: FontWeight.bold),)
              ),
              DataColumn(
                  label: Text('Price ',style: TextStyle(fontWeight: FontWeight.bold),)
              ),
            ],
            rows: List.generate(orderList.length, (index) =>
                DataRow(cells: [
                  DataCell(
                    Text(
                      DateFormat('dd/MM/yyyy hh:mm:ss a').format(orderList[index].paymentDate.timestamp.toDate()),
                    ),
                      onTap:(){
                        Navigator.pushNamed(context, OrderDetailsPage.routeName,arguments: orderList[index]);
                      }
                  ),
                  DataCell(Text(orderList[index].paymentId!),
                  onTap:(){
                    Navigator.pushNamed(context, OrderDetailsPage.routeName,arguments: orderList[index]);
                  }
                  ),
                  DataCell(
                    Text(orderList[index].paymentMethod),
                      onTap:(){
                        Navigator.pushNamed(context, OrderDetailsPage.routeName,arguments: orderList[index]);
                      }
                  ),
                  DataCell(
                      Text(orderList[index].grandTotal.toString()),
                      onTap:(){
                        Navigator.pushNamed(context, OrderDetailsPage.routeName,arguments: orderList[index]);
                      }
                  ),
                ])),
          ),
        ),
      )
    );
  }
}
