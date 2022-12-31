
import 'package:sqflite/sqflite.dart';
import '../main.dart';

class ReceivedMethods{

   Future<List<Map<String, dynamic>>?> getReceived() async {
     final Database db = await initializedDB();
     List<Map<String, dynamic>> maps;
      maps = await db.query('Received',
          orderBy:'received');
      if (maps.length > 0) {
        return maps;
      }
      return null;
  }

   Future<String?> addReceived(String content, String date) async {
     final Database db = await initializedDB();

     try{
       print(date);
       await db.transaction((txn) async {
         int id1 = await txn.rawInsert(
             'INSERT INTO Received(content, dateOfAction, received) VALUES("$content", "$date", false)');
         return null;
       });
       return null;
     }catch(e){
       print(e);
       return 'فشل اضافه';
     }
   }

   Future<bool> deleteReceived(int id) async {
     try {
       final Database db = await initializedDB();
       await db.delete(
         'Received',
         where: 'id = $id',
       );
       return true;
     }catch(e){
       return false;
     }
   }



   Future<bool> editReceived(int id) async {
     try {
       final Database db = await initializedDB();
       await db.update(
         'Received',
         {
           'received': 'true'
         },
         where: 'id = $id',
       );
       return true;
     }catch(e){
       return false;
     }
   }
}