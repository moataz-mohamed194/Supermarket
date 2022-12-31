import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/ReceivedProvider.dart';

class AddReceivedPage extends StatelessWidget{

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
      title:  const Text('تسجيل الاستلام'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<ReceivedProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextFieldWidget(
            hintText: "المستلم",
            errorText: validationService.contentData.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeContent(vals);
            },
            inputType: TextInputType.text,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 1.25,
            child: DateTimePicker(
              textAlign: TextAlign.right,
              type: DateTimePickerType.date,
              dateMask: 'dd/MM/yyyy',
              firstDate: DateTime(2000),
              errorFormatText: validationService.dateData.error,
              dateHintText:'التاريخ' ,
              lastDate: DateTime(2100),
              onChanged: (vals) {
                validationService.changeDate(vals);
              },
              onSaved: (val) => print(val),
            ),
          ),
          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text: "اضافه",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {
              if (await validationService.dataOfReceivedIsValid){
                validationService.getReceivedData();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}