import 'package:sqflite/sqflite.dart';

import '../main.dart';

class ExpensesAndProfitMethods{
  Future<List<Map<String, dynamic>>?> getProfit(String from, String to) async {
    final Database db = await initializedDB();
    List<Map<String, dynamic>> maps;
    print(from);
    print(to);
    maps = await db.rawQuery( 'SELECT * FROM profit WHERE dateOfAction >= "$from" AND dateOfAction <= "$to"'
    );
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getExpenses(String from, String to) async {
    final Database db = await initializedDB();
    List<Map<String, dynamic>> maps;

    maps = await db.rawQuery( 'SELECT * FROM Costs WHERE dateOfAction >= "$from" AND dateOfAction <= "$to"'
    );
    // query('Costs',
    //   where: 'dateOfAction >= $from AND dateOfAction <= $to',
    // );
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }
}