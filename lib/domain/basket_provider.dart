import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class BasketProvider extends ChangeNotifier{
  List<Map<String, dynamic>> basketData = [];

  Future<void> addToBasketData(Map<String, dynamic> data) async {
    bool add = false;
    for (int i =0;i<basketData.length;i++){
      if (basketData[i]['id']==data['id']){
        add=true;
      }
    }
    if (add==false){
      try {
        final Map<String, dynamic> data2 = {'countOfOrder': 1};
        data2.addAll(data);
        basketData.add(data2);
        Toast.show('تم الاضافه للسله', gravity: Toast.center);
      }catch(e){
        print(e);
      }
    }

    print(basketData);
    notifyListeners();
  }

  Future<void> cleanBasketData() async {
    basketData.clear();
    Toast.show('تم تفريغ للسله',gravity: Toast.center);

    notifyListeners();
  }

  Future<void> removeFromBasketData(Map<String, dynamic> data) async {
    var id = basketData.indexOf(data);
    print(basketData.indexOf(data));
    basketData.removeAt(id);
    Toast.show('تم الحذف للسله',gravity: Toast.center, duration: Toast.lengthLong);
    notifyListeners();
  }

  Future<void> increaseFromBasketData(Map<String, dynamic> data) async {
    var id = basketData.indexOf(data);
    int count = basketData[id]['count'];
    int countOfOrder = basketData[id]['countOfOrder'];
    if (countOfOrder>=count){
      Toast.show('تم الوصول للحد الاقصي',gravity: Toast.center, duration: Toast.lengthLong);
    }else{
      basketData[id].update('countOfOrder', (value) => countOfOrder+1 );//['countOfOrder']
    }
    notifyListeners();
  }

  Future<void> decreaseFromBasketData(Map<String, dynamic> data) async {
    var id = basketData.indexOf(data);
    int count = basketData[id]['count'];
    int countOfOrder = basketData[id]['countOfOrder'];
    if (countOfOrder>=count || countOfOrder == 1){
      Toast.show('تم الوصول للحد الاقصي',gravity: Toast.center, duration: Toast.lengthLong);
    }else{
      basketData[id].update('countOfOrder', (value) => countOfOrder-1 );//['countOfOrder']
    }
    notifyListeners();
  }




}