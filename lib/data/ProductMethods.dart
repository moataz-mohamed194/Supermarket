
import 'package:sqflite/sqflite.dart';
import '../main.dart';

class ProductMethods{


   Future<List<Map<String, dynamic>>?> getProducts(String name, String code, String minPrice, String maxPrice) async {
     final Database db = await initializedDB();
     String whereString = '';
    if (name!='null'){
      whereString = whereString + 'name = "$name"';
    }
    if (code != 'null' || minPrice != 'null' || maxPrice!= 'null'){
      print(code);
      print(code.runtimeType);
      print(minPrice);
      print(minPrice.runtimeType);
      print(maxPrice);
      print(maxPrice.runtimeType);
      whereString = whereString + ' AND ';
    }
      if (code!='null'){
        whereString = whereString + 'code = "$code"';
      }
     if (minPrice != 'null' || maxPrice!= 'null'){
       whereString = whereString + ' AND ';
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

   Future<bool> deleteProduct(int id) async {
     try {
       final Database db = await initializedDB();
       await db.delete(
         'Products',
         where: 'id = $id',
       );
       return true;
     }catch(e){
       return false;
     }
   }

   // 'CREATE TABLE Products (id INTEGER PRIMARY KEY , name TEXT, count INTEGER, price DECIMAL, note TEXT, code TEXT, qrCode TEXT )',

   Future<bool> editProduct(String id, String name, String count, String price, String note, String code) async {
     try {
       final Database db = await initializedDB();
       // await db.delete(
       //   'Products',
       //   where: 'id = $id',
       // );
       await db.update(
         'Products',
         {
           'name': '$name',
           'count': '$count',
           'price': '$price',
           'note': '$note',
           'code': '$code',
         },
         where: 'id = $id',
       );
       return true;
     }catch(e){
       return false;
     }
   }
}