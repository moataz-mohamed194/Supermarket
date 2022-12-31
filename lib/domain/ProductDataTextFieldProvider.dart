
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../data/ProductMethods.dart';
import '../data/model/ValidationItem.dart';

class ProductDataTextFieldProvider extends ChangeNotifier{
  ValidationItem nameOfProductData = ValidationItem(null, null);
  ValidationItem get nameOfProduct => nameOfProductData;

  void changeNameOfProduct(String value) {
    if (value.length>1) {
      nameOfProductData = ValidationItem(value, null);
    } else {
      nameOfProductData = ValidationItem(null, "must the name of Product be longer");
    }
    notifyListeners();
  }

  ValidationItem codeOfProductData = ValidationItem(null, null);
  ValidationItem get codeOfProduct => codeOfProductData;

  void changeCodeOfProduct(String value) {
    if (value.length>1) {
      codeOfProductData = ValidationItem(value, null);
    } else {
      codeOfProductData = ValidationItem(null, "must add the code of product");
    }
    notifyListeners();
  }

  ValidationItem priceOfProductData = ValidationItem(null, null);
  ValidationItem get priceOfProduct => priceOfProductData;

  void changePriceOfProduct(String value) {
    try{
      double.parse(value);
    }catch(e){
      priceOfProductData = ValidationItem(null, "must add the price of product");
    }
    if (value.length>1) {
      try{
        double.parse(value);
        priceOfProductData = ValidationItem(value, null);
      }catch(e){
        priceOfProductData = ValidationItem(null, "must add the price of product");
      }
    } else {
      priceOfProductData = ValidationItem(null, "must add the price of product");
    }
    notifyListeners();
  }

  ValidationItem noteOfProductData = ValidationItem(null, null);
  ValidationItem get noteOfProduct => noteOfProductData;

  void changeNoteOfProduct(String value) {
    if (value.length>1) {
      noteOfProductData = ValidationItem(value, null);
    } else {
      noteOfProductData = ValidationItem(null, "must add the note of product");
    }
    notifyListeners();
  }

  ValidationItem countOfProductData = ValidationItem(null, null);
  ValidationItem get countOfProduct => countOfProductData;

  void changeCountOfProduct(String value) {
    if (value.length>1&&value.contains(RegExp(r"^[0-9]*$")) == true) {
      countOfProductData = ValidationItem(value, null);
    } else {
      countOfProductData = ValidationItem(null, "must add the price of product");
    }
    notifyListeners();
  }

  

  Future<bool> get dataOfProductIsValid  async {
    String? result = await ProductMethods().addProduct(nameOfProductData.value.toString(),
        countOfProductData.value.toString(),
          priceOfProductData.value.toString(),
          noteOfProductData.value.toString(),
          codeOfProductData.value.toString(),
          'fff');
          print(result);
        if(result == null){
          Toast.show('تم اضافه المنتج',gravity: Toast.center, duration: Toast.lengthLong);
          return true;
        }else{
          Toast.show(result.toString(),gravity: Toast.center);
          return false;
        }
  }

  bool deleteProductValid(int id){
    try {
      ProductMethods().deleteProduct(id);
      return true;
    }catch(e){
      return false;
    }
  }

  bool editProductValid(String id, String name, String count, String price, String note, String code){
    if(nameOfProductData.value != null && nameOfProductData.value != name){
      name = nameOfProductData.value!;
    }
    if (countOfProductData.value != null && countOfProductData.value != count){
      count = countOfProductData.value!;
    }
    if (priceOfProductData.value != null && priceOfProductData.value != price){
      price = priceOfProductData.value!;
    }
    if (noteOfProductData.value != null && noteOfProductData.value != note){
      note = noteOfProductData.value!;
    }
    if (codeOfProductData.value != null && codeOfProductData.value != code){
      code = codeOfProductData.value!;
    }
    try {
      ProductMethods().editProduct(id, name, count, price, note, code);
      return true;
    }catch(e){
      return false;
    }
  }
}