
import 'package:sqflite/sqflite.dart';
import '../main.dart';

class ProductMethods{


   Future<List<Map<String, dynamic>>?> getProducts(String name, String code, String minPrice, String maxPrice) async {
     final Database db = await initializedDB();
     String whereString = '';
    if (name!='null'){
      whereString = whereString + 'name = "$name"';
    }
    if (code!='null'){
      whereString = whereString + 'code = "$code"';
    }
    if (minPrice != 'null' && maxPrice== 'null'){
      whereString = whereString + 'price >= $minPrice';
    }
    if (maxPrice != 'null' && minPrice== 'null'){
      whereString = whereString + 'price <= $minPrice';
    }
    if (minPrice != 'null' && maxPrice!= 'null'){
      whereString = whereString + 'price > $minPrice AND price <= $maxPrice';
    }
     List<Map<String, dynamic>> maps;
    if (whereString != '') {
       maps = await db.query(
        'Products',
        where: whereString,
      );
    }else{
      maps = await db.query('Products');
    }
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<String?> addProduct(String name, String count, String price, String note, String code, String qrCode) async {
    final Database db = await initializedDB();

    try{
      await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
        'INSERT INTO Products(name, count, price, note, code, qrCode) VALUES("$name", $count, "$price", "$note", "$code", "$qrCode")');
        return null;
      });
     return null;
    }catch(e){
     return 'فشل اضافه المنتج';
    }
  }

}