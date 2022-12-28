
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import '../core/StrogeData/hive.dart';
import '../main.dart';

class Registration {
  Future<String?> createAccount(String name, String emailAddress, String password)async{
    try{
      final Database db = await initializedDB();

      await db.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO User(name , email , password) VALUES("$name", "$emailAddress", "$password")');
      });
      return null;
    }catch(e) {
      return e.toString();
    }
  }
//
  Future logOutAccount()async{
    try{
      var tasksBox = await Hive.openBox<Person>('user');
      tasksBox.get(0)!.logged = false;
      tasksBox.get(0)!.save();
      
      return true;
    }catch(e){
      return false;
    }
  }
//
  Future<String?> signInAccount(String emailAddress, String password)async{
    final Database db = await initializedDB();

    List<Map> list = await db.rawQuery('SELECT * FROM User WHERE email="$emailAddress" AND password="$password"');
    print(list);
    if (list.isEmpty || list.length>1){
      return 'check your data';
    }else{
      print(list);
      var addData = await Hive.openBox<Person>('user');
      var person = Person()
        ..pk = list.first['id'].toString()
        ..logged = true
        ..name = list.first['name'].toString();
      try{
      addData.putAt(0, person);
      }catch(e){
        addData.add(person);
      }
      print(person.name);
      // tasksBox.get(0)!.save();

      return null;
    }
  }
//
}