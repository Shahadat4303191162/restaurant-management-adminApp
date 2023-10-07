import 'package:cafe_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class MonthRevenueInfo{
  String title;
  int numOfPercentage,percentage;
  Color color;

  MonthRevenueInfo({
    required this.title,
    required this.numOfPercentage,
    required this.percentage,
    required this.color
  });
}

List demoRevenue = [
  MonthRevenueInfo(
    title: 'Week 1',
    numOfPercentage: 48,
    percentage: 48,
    color: green,
  ),

  MonthRevenueInfo(
    title: 'Week 2',
    numOfPercentage: 75,
    percentage: 75,
    color: green,
  ),

  MonthRevenueInfo(
    title: 'Week 3',
    numOfPercentage: 60,
    percentage: 60,
    color: green,
  ),

  MonthRevenueInfo(
    title: 'Week 4',
    numOfPercentage: 50,
    percentage: 50,
    color: green,
  ),
];