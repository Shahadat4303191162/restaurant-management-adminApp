
import 'package:cafe_admin/utils/constants.dart';

class SellInfoDashboardContentModel{
  String title,numOfAmount,percentage;


  SellInfoDashboardContentModel({
    required this.title,
    required this.numOfAmount,
    required this.percentage
  });
}

final List<SellInfoDashboardContentModel> infoItem = [
  SellInfoDashboardContentModel(
    title: 'Sells Graph',
    numOfAmount: '$currencysymbol 283404',
    percentage: '4.5 %'
  ),
  SellInfoDashboardContentModel(
      title: 'Total Visitors',
      numOfAmount: '28365404',
      percentage: '5 %'
  ),
  SellInfoDashboardContentModel(
      title: 'Last 7 Day ',
      numOfAmount: '$currencysymbol 283404',
      percentage: '4.5 %'
  ),
  SellInfoDashboardContentModel(
      title: 'Total Order',
      numOfAmount: '28340443',
      percentage: '3.4 %'
  ),
];