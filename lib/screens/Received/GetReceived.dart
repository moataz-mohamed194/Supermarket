
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../core/widgets/NoteDisplay.dart';
import '../../domain/ReceivedProvider.dart';
import 'AddReceived.dart';

class GetReceivedPages extends StatefulWidget{
  const GetReceivedPages({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GetReceivedPages();
  }

}
class _GetReceivedPages extends State<GetReceivedPages> {

  @override
  void initState() {
    final service = Provider.of<ReceivedProvider>(context,listen: false);
    service.getReceivedData();
    super.initState();
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
      title: const Text('الاستلام'),
    );
  }



  Widget bodyContainer(BuildContext context){
    final validationService = Provider.of<ReceivedProvider>(context);
    return
    SingleChildScrollView(
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: validationService.receivedDataList != null ?
                  ListView.builder(
                    shrinkWrap: true,

                    scrollDirection: Axis.vertical,

                    itemCount: validationService.receivedDataList!.length,
                    itemBuilder: (_, int position) {
                      return NoteDisplay(
                            title: validationService.receivedDataList![position]['dateOfAction'],
                            note: validationService.receivedDataList![position]['content'],
                            received: validationService.receivedDataList![position]['received'].toString(),
                            number:  '${position+1}',
                            id: validationService.receivedDataList![position]['id'].toString(),
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
          return AddReceivedPage();
        }));
      },
      child: const Icon(Icons.add),
    );
  }

}