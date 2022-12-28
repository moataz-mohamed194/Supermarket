import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../data/ExpensesAndProfitMethods.dart';
import '../data/ExpensesMethods.dart';
import '../data/ProfitMethods.dart';
import '../data/model/ValidationItem.dart';

class ExpensesAndProfitProvider extends ChangeNotifier{
  ValidationItem toDateData = ValidationItem(null, null);
  ValidationItem fromDateData = ValidationItem(null, null);
  ValidationItem get toDate => toDateData;
  ValidationItem get content => fromDateData;

  void changeToDate(String value) {
    toDateData = ValidationItem(value, null);
    notifyListeners();
  }

  void changeFromDate(String value) {
    fromDateData = ValidationItem(value, null);
    notifyListeners();
  }

  List<Map<String, dynamic>>? expensesDataList = [];
  List<Map<String, dynamic>>? profitDataList = [];
  double totalOfProfit = 0;
  double totalOfExpenses = 0;
  double totalOfSold = 0;

  Future<void>  getProfitAndExpenses()  async {
    totalOfProfit = 0;
    totalOfExpenses = 0;
    totalOfSold = 0;
    profitDataList = [];
    expensesDataList = [];
    profitDataList = await ExpensesAndProfitMethods().getProfit(fromDateData.value.toString(),
        toDateData.value.toString());
    expensesDataList = await ExpensesAndProfitMethods().getExpenses(fromDateData.value.toString(),
        toDateData.value.toString());
    if(profitDataList != null) {
      for (int i = 0; i < profitDataList!.length; i++) {
        totalOfSold = totalOfSold +
            (profitDataList![i]['count'] * profitDataList![i]['price']);
      }
    }
    if(expensesDataList != null) {
      for (int i = 0; i < expensesDataList!.length; i++) {
        totalOfExpenses = totalOfExpenses + expensesDataList![i]['price'];
      }
    }
    totalOfProfit = totalOfSold - totalOfExpenses;
    print(totalOfSold);
    print(totalOfExpenses);
    print(totalOfProfit);
    print(profitDataList);
    print(expensesDataList);
    notifyListeners();
  }
  Future<void> deleteExpenses(int id) async {
    bool result = await ExpensesMethods().deleteExpenses(id);
    if (result==true){
      Toast.show('تم حذف المصروفات',gravity: Toast.center, duration: Toast.lengthLong);

    }else{
      Toast.show('حدث مشكله اثناء حذف المصروفات',gravity: Toast.center, duration: Toast.lengthLong);

    }
    getProfitAndExpenses();
  }
  Future<void> deleteProfit(int id) async {
    bool result = await ProfitMethods().deleteProfit(id);
    if (result==true){
      Toast.show('تم حذف الربح',gravity: Toast.center, duration: Toast.lengthLong);

    }else{
      Toast.show('حدث مشكله اثناء حذف الربح',gravity: Toast.center, duration: Toast.lengthLong);

    }
    getProfitAndExpenses();

  }
}