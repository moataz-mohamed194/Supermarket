import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/NotesProvider.dart';

class AddNotePage extends StatelessWidget{
  final String? noteId;
  final String? noteTitle;
  final String? note;
  const AddNotePage({super.key,
     this.noteId,
     this.note,
     this.noteTitle});
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: appBarBody(context),
        body:bodyWidget(context)
    );
  }



  AppBar appBarBody(BuildContext context){
    return AppBar(
      title: noteTitle!=null&&noteId!=null&&note!=null?const Text('تعديل ملاحظه'): const Text('تسجيل ملاحظه'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<NotesProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
            hintText: "عنوان الملاحظه",
            errorText: validationService.titleData.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeTitle(vals);
            },
            inputType: TextInputType.text,
            oldData: noteTitle,
          ),
          TextFieldWidget(
            hintText: "الملاحظه",
            errorText: validationService.contentData.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeContent(vals);
            },
            inputType: TextInputType.text,
            oldData: note,
          ),

          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text: noteTitle!=null&&noteId!=null&&note!=null?"تعديل":"اضافه",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {
              if (noteTitle!=null&&noteId!=null&&note!=null){
                validationService.editNotesData(noteTitle!, note!, noteId!);
                validationService.getNotesData();
                Navigator.pop(context);
              }else if (await validationService.dataOfNotesIsValid){
                validationService.getNotesData();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }



}