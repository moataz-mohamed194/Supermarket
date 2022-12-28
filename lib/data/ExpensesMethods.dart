import 'package:sqflite/sqflite.dart';

import '../main.dart';

class ExpensesMethods{
  Future<List<Map<String, dynamic>>?> getExpenses() async {
    final Database db = await initializedDB();
    List<Map<String, dynamic>> maps;

    maps = await db.query('Costs',
        // columns: ['CONVERT (dateOfAction, DATE()) AS [dateOfAction]'],
        // where: 'dateOfAction = 2022-12-25',
);
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }


  Future<String?> addExpenses(String price, String content, String date) async {
    final Database db = await initializedDB();

    try{
      print(date);
      await db.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO Costs(price, content, dateOfAction) VALUES($price, "$content", "$date")');
        return null;
      });
      return null;
    }catch(e){
      print(e);
      return 'فشل اضافه الملاحظه';
    }
  }

  Future<bool> deleteExpenses(int id) async {
    try {
      final Database db = await initializedDB();
      await db.delete(
        'Costs',
        where: 'id = $id',
      );
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> updateExpenses(String content,String price,String date,String id) async {

    try {
      final Database db = await initializedDB();

      // Update the given Dog.
      await db.update(
        'Costs',
        {
          'price': '$price',
          'content': '$content',
          'dateOfAction': '$date',
        },
        where: 'id = $id',
      );
      return true;
    }catch(e){
      return false;
    }
  }

}