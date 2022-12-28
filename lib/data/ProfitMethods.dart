import 'package:sqflite/sqflite.dart';

import '../main.dart';

class ProfitMethods{
  Future<List<Map<String, dynamic>>?> getProfit() async {
    final Database db = await initializedDB();
    List<Map<String, dynamic>> maps;

    maps = await db.query('profit',
        // columns: ['CONVERT (dateOfAction, DATE()) AS [dateOfAction]'],
        // where: 'dateOfAction = 2022-12-25',
);
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }


  Future<String?> addProfit(String price, String content, String date, int count) async {
    final Database db = await initializedDB();

    try{
      print(date);
      await db.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO profit(price, content, dateOfAction, count) VALUES($price, "$content", "$date", $count)');
        return null;
      });
      return null;
    }catch(e){
      print(e);
      return 'فشل اضافه المبلغ';
    }
  }

  Future<bool> deleteProfit(int id) async {
    try {
      final Database db = await initializedDB();
      await db.delete(
        'profit',
        where: 'id = $id',
      );
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> updateProfit(String content,String price,String date,String id, int count) async {

    try {
      final Database db = await initializedDB();

      // Update the given Dog.
      await db.update(
        'profit',
        {
          'price': '$price',
          'content': '$content',
          'dateOfAction': '$date',
          'count': count
        },
        where: 'id = $id',
      );
      return true;
    }catch(e){
      return false;
    }
  }

}