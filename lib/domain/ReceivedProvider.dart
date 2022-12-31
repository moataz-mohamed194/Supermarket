import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../data/ReceivedMethods.dart';
import '../data/model/ValidationItem.dart';

class ReceivedProvider extends ChangeNotifier{
  ValidationItem contentData = ValidationItem(null, null);
  // bool receivedData = false;
  // get received => receivedData;

  ValidationItem get content => contentData;

  ValidationItem dateData = ValidationItem(null, null);
  ValidationItem get date => dateData;

  void changeContent(String value) {
    contentData = ValidationItem(value, null);
    notifyListeners();
  }

  // void changeReceived(bool value) {
  //   receivedData = value;
  //   notifyListeners();
  // }

  void changeDate(String value) {
    dateData = ValidationItem(value, null);
    notifyListeners();
  }

  Future<bool> get dataOfReceivedIsValid  async {
    String? result = await ReceivedMethods().addReceived(contentData.value.toString(),
        dateData.value.toString());
    if(result == null){
      Toast.show('تم اضافه الربح',gravity: Toast.center, duration: Toast.lengthLong);
      return true;
    }else{
      Toast.show(result.toString(),gravity: Toast.center);
      return false;
    }
  }

  List<Map<String, dynamic>>? receivedDataList = [];
  Future<void> getReceivedData() async {
    receivedDataList = await ReceivedMethods().getReceived();
    notifyListeners();
  }
  Future<void> deleteReceivedData(int id) async {
    await ReceivedMethods().deleteReceived(id);
    await getReceivedData();
    notifyListeners();
  }
  Future<void> editReceivedData(int id) async {
    await ReceivedMethods().editReceived(id);
    await getReceivedData();
    notifyListeners();
  }

}