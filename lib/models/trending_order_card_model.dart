class TrendingOrderDashboardContentModel{
  String title,price,order,income;
  String? imageUrl;

  TrendingOrderDashboardContentModel({
    required this.title,
    this.imageUrl,
    required this.price,
    required this.order,
    required this.income
  });
}

final List<TrendingOrderDashboardContentModel> tOrderInfo =[
  TrendingOrderDashboardContentModel(
      title: 'BBQ Baked Pasta',
      price: '270',
      order: '35',
      income: '3400'
  ),
  TrendingOrderDashboardContentModel(
      title: 'BBQ Pizz',
      price: '315',
      order: '40',
      income: '6500'
  ),
  TrendingOrderDashboardContentModel(
      title: 'Pizz Blast',
      price: '450',
      order: '12',
      income: '4500'
  ),
  TrendingOrderDashboardContentModel(
      title: 'Chicken Burger',
      price: '215',
      order: '50',
      income: '6300'
  ),
];