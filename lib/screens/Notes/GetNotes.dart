
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../core/widgets/NoteDisplay.dart';
import '../../domain/NotesProvider.dart';
import 'AddNote.dart';

class GetNotesPages extends StatefulWidget{
  const GetNotesPages({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GetNotesPages();
  }

}
class _GetNotesPages extends State<GetNotesPages> {

  @override
  void initState() {
    final service = Provider.of<NotesProvider>(context,listen: false);
    service.getNotesData();
    super.initState();
  }
@override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: appBarBody(context),
        body: bodyContainer(context),
        floatingActionButton:floatingButton(context)
    );
  }

  AppBar appBarBody (BuildContext context){
    return AppBar(
      title: const Text('الملاحظات'),
    );
  }



  Widget bodyContainer(BuildContext context){
    final validationService = Provider.of<NotesProvider>(context);
    return
    SingleChildScrollView(
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: validationService.notesDataList != null ?
                  ListView.builder(
                    shrinkWrap: true,

                    scrollDirection: Axis.vertical,

                    itemCount: validationService.notesDataList!.length,
                    itemBuilder: (_, int position) {
                      return NoteDisplay(
                            title: validationService.notesDataList![position]['title'],
                            note: validationService.notesDataList![position]['content'],
                            number:  '${position+1}',
                            id: validationService.notesDataList![position]['id'].toString(),
                          );
                    }

                ):
              Container(),
          )

      );
  }

  FloatingActionButton floatingButton(BuildContext context){
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const AddNotePage();
        }));
      },
      child: const Icon(Icons.add),
    );
  }

}