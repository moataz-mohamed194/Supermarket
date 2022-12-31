
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/NotesProvider.dart';
import '../../domain/ReceivedProvider.dart';
import '../../screens/Notes/AddNote.dart';

class NoteDisplay extends StatelessWidget{
  final String id ;
  final String note;
  final String? received;
  final String number;
  final String title;

  const NoteDisplay({super.key,
    required this.id,
    required this.note,
    required this.title,
    required this.number, this.received});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      color: received == null?Colors.transparent:received == 'true'?Colors.green:Colors.transparent,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('$number.'),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Text(title.toString()),
                Text(note.toString())
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                received!=null?IconButton(
                    onPressed: ()=>_editReceivedMethod(id,context),
                    icon: const Icon(Icons.done)
                ):IconButton(
                    onPressed: ()=>_editNoteMethod(context),
                    icon: const Icon(Icons.edit)
                ),
                IconButton(
                  onPressed:()=> _deleteNoteMethod(id,context),
                  icon: const Icon(Icons.close),
                  color: Colors.red
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _deleteNoteMethod(String id,BuildContext context ){
    if (received==null) {
      final dataProvider = Provider.of<NotesProvider>(context, listen: false);
      dataProvider.deleteNote(int.parse(id));
      dataProvider.getNotesData();
    }else{
      final dataProvider = Provider.of<ReceivedProvider>(context, listen: false);
      dataProvider.deleteReceivedData(int.parse(id));
      dataProvider.getReceivedData();
    }
  }

  _editReceivedMethod(String id,BuildContext context ){
    final dataProvider = Provider.of<ReceivedProvider>(context, listen: false);
    dataProvider.editReceivedData(int.parse(id));
    dataProvider.getReceivedData();

  }

  _editNoteMethod(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNotePage( noteId: id,noteTitle: title, note:note);
    }));
  }
}