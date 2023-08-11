const String diverseSelectionId ='id';
const String diverseSelectionProductId ='productId';
const String diverseSelectionSize ='size';
const String diverseSelectionSalePrice ='salePrice';
const String diverseSelectionPurchasePrice ='purPrice';
class DiverseSelectionModel{
  String? id, productId,size;
  num salePrice,purPrice;

  DiverseSelectionModel({
    this.id,
    this.productId,
    this.size,
    required this.salePrice,
    required this.purPrice});
}
