import 'package:cafe_admin/models/order_constants_model.dart';
import 'package:cafe_admin/provider/order_provider.dart';
import 'package:cafe_admin/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class Vat_DiscountPage extends StatefulWidget {
  static const String routeName = '/vat_discount';
  const Vat_DiscountPage({super.key});

  @override
  State<Vat_DiscountPage> createState() => _Vat_DiscountPageState();
}

class _Vat_DiscountPageState extends State<Vat_DiscountPage> {
  late OrderProvider orderProvider;
  double discountslidervalue = 0;
  double vatslidervalue = 0;
  bool needUpdate = false;

  @override
  void didChangeDependencies() {
    orderProvider = Provider.of(context,listen: false);
    orderProvider.getOrderConstants2().then((value) {
      setState(() {
        discountslidervalue = orderProvider.orderConstantsModel.discount.toDouble();
        vatslidervalue = orderProvider.orderConstantsModel.vat.toDouble();
      });
    });

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Vat & discount'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0,
            horizontal: screenWidth > 1000 ? screenWidth * 0.3
                : screenWidth > 600 ? screenWidth * 0.1 : 20),
        child: ListView(
          children: [
            Card(
              elevation: 10,
              child:
                  ListTile(
                    title: const Text('Discount'),
                    trailing: Text(' ${discountslidervalue.round()}%'),
                    subtitle: Slider(
                      activeColor: Colors.deepPurple.shade300,
                      inactiveColor: Colors.grey,
                      min: 0,
                      max: 30,
                      divisions: 30,
                      label: discountslidervalue.toStringAsFixed(0),
                      value: discountslidervalue.toDouble(),
                      onChanged: (value){
                        setState(() {
                          discountslidervalue = value;
                          _checkUpdate();
                        });
                      },
                    ),
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              elevation: 10,
              child: ListTile(
                title: const Text('VAT'),
                trailing: Text('${vatslidervalue.round()}%'),
                subtitle: Slider(
                  activeColor: Colors.deepPurple.shade300,
                  inactiveColor: Colors.grey,
                  min: 0,
                  max: 50,
                  divisions: 50,
                  label: vatslidervalue.toStringAsFixed(0),
                  value: vatslidervalue.toDouble(),
                  onChanged: (value){
                    setState(() {
                      vatslidervalue = value;
                      _checkUpdate();
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: needUpdate ? () {
                  EasyLoading.show(status: 'Updating....',dismissOnTap: false);
                  final model = OrderConstantsModel(
                    discount: discountslidervalue,
                    vat: vatslidervalue
                  );
                  orderProvider.addOrderConstants(model).then((value) {
                    EasyLoading.dismiss();
                  }).catchError((onError){
                    showMsg(context, 'Could not update');
                    EasyLoading.dismiss();
                    throw onError;
                  });
                } : null,
                child: const Text('UPDATE'))
          ],
        ),
      ),
    );
  }

  void
  _checkUpdate() {
    needUpdate = orderProvider.orderConstantsModel.discount.toDouble() !=
        discountslidervalue || orderProvider.orderConstantsModel.vat.toDouble() !=
        vatslidervalue;
  }
}
