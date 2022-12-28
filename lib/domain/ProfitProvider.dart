import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../data/ProfitMethods.dart';
import '../data/model/ValidationItem.dart';

class ProfitProvider extends ChangeNotifier{
  ValidationItem priceData = ValidationItem(null, null);
  ValidationItem contentData = ValidationItem(null, null);
  ValidationItem get price => priceData;
  ValidationItem get content => contentData;

  ValidationItem dateData = ValidationItem(null, null);
  ValidationItem get date => dateData;

  void changeContent(String value) {
    contentData = ValidationItem(value, null);
    notifyListeners();
  }

  void changePrice(String value) {
    priceData = ValidationItem(value, null);
    notifyListeners();
  }

  void changeDate(String value) {
    dateData = ValidationItem(value, null);
    notifyListeners();
  }

  Future<bool> get dataOfProfitIsValid  async {
    String? result = await ProfitMethods().addProfit(priceData.value.toString(),
        contentData.value.toString(), dateData.value.toString(), 1);
    if(result == null){
      Toast.show('تم اضافه الربح',gravity: Toast.center, duration: Toast.lengthLong);
      return true;
    }else{
      Toast.show(result.toString(),gravity: Toast.center);
      return false;
    }
  }

  List<Map<String, dynamic>>? profitDataList = [];
  Future<void> getProfitData() async {
    profitDataList = await ProfitMethods().getProfit();
    for (int i =0; i<profitDataList!.length;i++){
      print(profitDataList![i]['dateOfAction'].toString());
    }
    print(profitDataList);
    notifyListeners();
  }


  Future<bool> editNotesData (String price, String content, String id , String date ) async {
    if(contentData.value != null && contentData.value != content){
      content = contentData.value!;
    }
    if (priceData.value != null && priceData.value != price){
      price = priceData.value!;
    }
    if (dateData.value != null && dateData.value != date){
      date = dateData.value!;
    }
    bool? result = await ProfitMethods().updateProfit(content, price, date, id, 1);
    print(result);
    if(result == true){
      Toast.show('تم تعديل الربح',gravity: Toast.center, duration: Toast.lengthLong);
      return true;
    }else{
      Toast.show('فشل التعديل',gravity: Toast.center);
      return false;
    }
  }
}