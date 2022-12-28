import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../data/ExpensesMethods.dart';
import '../data/model/ValidationItem.dart';
import 'ExpensesAndProfitProvider.dart';

class ExpensesProvider extends ChangeNotifier{
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

  Future<bool> get dataOfExpensesIsValid  async {
    String? result = await ExpensesMethods().addExpenses(priceData.value.toString(),
        contentData.value.toString(), dateData.value.toString());
    if(result == null){
      Toast.show('تم اضافه المصروفات',gravity: Toast.center, duration: Toast.lengthLong);
      return true;
    }else{
      Toast.show(result.toString(),gravity: Toast.center);
      return false;
    }
  }

  List<Map<String, dynamic>>? expensesDataList = [];
  Future<void> getExpensesData() async {
    expensesDataList = await ExpensesMethods().getExpenses();
    for (int i =0; i<expensesDataList!.length;i++){
      print(expensesDataList![i]['dateOfAction'].toString());
    }
    print(expensesDataList);
    notifyListeners();
  }
  // Future<void> deleteExpenses(int id) async {
  //   bool result = await ExpensesMethods().deleteExpenses(id);
  //   if (result==true){
  //     Toast.show('تم حذف المصروفات',gravity: Toast.center, duration: Toast.lengthLong);
  //
  //   }else{
  //     Toast.show('حدث مشكله اثناء حذف المصروفات',gravity: Toast.center, duration: Toast.lengthLong);
  //
  //   }
  // }

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
    bool? result = await ExpensesMethods().updateExpenses(content, price, date, id);
    if(result == true){
      ExpensesAndProfitProvider().getProfitAndExpenses();
      Toast.show('تم تعديل الملاحظه',gravity: Toast.center, duration: Toast.lengthLong);
      return true;
    }else{
      Toast.show('فشل التعديل',gravity: Toast.center);
      return false;
    }
  }
}