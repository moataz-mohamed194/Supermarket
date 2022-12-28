import 'package:sqflite/sqflite.dart';
import 'package:supermarket/data/model/Notes.dart';

import '../main.dart';

class NotesMethods{

  Future<List<Map<String, dynamic>>?> getNotes() async {
    final Database db = await initializedDB();
    List<Map<String, dynamic>> maps;

      maps = await db.query('Note',orderBy:'-id');
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }
  Future<bool> deleteNote(int id) async {
    try {
      final Database db = await initializedDB();
      await db.delete(
        'Note',
        where: 'id = $id',
      );
      return true;
    }catch(e){
      return false;
    }
  }

  Future<String?> addNotes(String title, String content) async {
    final Database db = await initializedDB();

    try{
      await db.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO Note(title, content) VALUES("$title", "$content")');
        return null;
      });
      return null;
    }catch(e){
      print(e);
      return 'فشل اضافه الملاحظه';
    }
  }

  Future<bool> updateNote(String title, String note, String id) async {

    try {
      final Database db = await initializedDB();

      // Update the given Dog.
      await db.update(
        'Note',
        {
          'title': '$title',
          'content': '$note',
        },
        where: 'id = $id',
      );
      return true;
    }catch(e){
      return false;
    }
  }
}