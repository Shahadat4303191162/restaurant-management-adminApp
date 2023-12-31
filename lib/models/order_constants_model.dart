const String deliveryChargeKey = 'deliverycharge';//key gula ki hobe doc er constant hisebe
const String discountKey = 'discount';
const String vatKey = 'vat';

class OrderConstantsModel{
  num  discount, vat;

  OrderConstantsModel({
    this.discount =0,
    this.vat =0,
  });

  Map<String,dynamic>toMap(){
    return<String, dynamic>{
      discountKey : discount,
      vatKey : vat,
    };
  }

  factory OrderConstantsModel.fromMap(Map<String,dynamic>map){
    return OrderConstantsModel(
        discount: map[discountKey],
        vat: map[vatKey]
    );
  }
}