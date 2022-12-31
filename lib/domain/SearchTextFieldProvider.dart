import 'package:flutter/material.dart';
import 'package:supermarket/data/ProductMethods.dart';

import '../data/model/ValidationItem.dart';


class SearchTextFieldProvider extends ChangeNotifier{
  ValidationItem codeData = ValidationItem(null, null);
  ValidationItem nameData = ValidationItem(null, null);
  ValidationItem minPriceData = ValidationItem(null, null);
  ValidationItem maxPriceData = ValidationItem(null, null);

  ValidationItem get code => codeData;
  ValidationItem get name => nameData;
  ValidationItem get minPrice => minPriceData;
  ValidationItem get maxPrice => maxPriceData;

  void changeName(String value) {
      nameData = ValidationItem(value, null);
    notifyListeners();
  }
  void changeCode(String value) {
      codeData = ValidationItem(value, null);
    notifyListeners();
  }
  void changeMinPrice(String value) {
      minPriceData = ValidationItem(value, null);
    notifyListeners();
  }
  void changeMaxPrice(String value) {
      maxPriceData = ValidationItem(value, null);
    notifyListeners();
  }

  List<Map<String, dynamic>>? searchData = [];

  Future<void> getSearchData() async {
    searchData = await ProductMethods().getProducts(nameData.value.toString(), codeData.value.toString(), minPriceData.value.toString(), maxPriceData.value.toString()) as List<Map<String, dynamic>>?;
    notifyListeners();
  }

  // Future<void> cleanSearchData() async {
  //   try {
  //     searchData?.clear();
  //     searchData = [];
  //   }catch(e){
  //     print(e);
  //   }
  //   notifyListeners();
  // }
}