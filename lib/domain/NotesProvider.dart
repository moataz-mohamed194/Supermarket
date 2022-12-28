import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../data/NotesMethods.dart';
import '../data/model/ValidationItem.dart';

class NotesProvider extends ChangeNotifier{
  List<Map<String, dynamic>>? notesDataList = [];
  Future<void> getNotesData() async {
    notesDataList = await NotesMethods().getNotes();
    notifyListeners();
  }
  Future<void> deleteNote(int id) async {
    bool result = await NotesMethods().deleteNote(id);
    if (result==true){
      Toast.show('تم حذف الملاحظه',gravity: Toast.center, duration: Toast.lengthLong);

    }else{
      Toast.show('حدث مشكله اثناء الملاحظه',gravity: Toast.center, duration: Toast.lengthLong);

    }
  }

  ValidationItem titleData = ValidationItem(null, null);
  ValidationItem contentData = ValidationItem(null, null);
  ValidationItem get title => titleData;
  ValidationItem get content => contentData;
  void changeTitle(String value) {
    titleData = ValidationItem(value, null);
    notifyListeners();
  }

  void changeContent(String value) {
    contentData = ValidationItem(value, null);
    notifyListeners();
  }

  Future<bool> get dataOfNotesIsValid  async {
    String? result = await NotesMethods().addNotes(titleData.value.toString(),
        contentData.value.toString());
    if(result == null){
      Toast.show('تم اضافه الملاحظه',gravity: Toast.center, duration: Toast.lengthLong);
      return true;
    }else{
      Toast.show(result.toString(),gravity: Toast.center);
      return false;
    }
  }

  Future<bool> editNotesData (String title, String note, String id ) async {
    if(contentData.value != null && contentData.value != note){
      note = contentData.value!;
    }
    if (titleData.value != null && titleData.value != title){
      title = titleData.value!;
    }
    print(title);
    print(note);
    bool? result = await NotesMethods().updateNote(title, note, id);
    print(result);
    if(result == true){
      Toast.show('تم تعديل الملاحظه',gravity: Toast.center, duration: Toast.lengthLong);
      return true;
    }else{
      Toast.show('فشل التعديل',gravity: Toast.center);
      return false;
    }
  }

}