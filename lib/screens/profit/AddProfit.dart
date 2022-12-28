import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/ProfitProvider.dart';
import '../MainScreen/MainPageOfBanks.dart';

class AddProfitPage extends StatelessWidget{
  final String? profitId;
  final String? content;
  final String? price;
  final String? date;
  const AddProfitPage({super.key,
     this.profitId,
     this.price,
    this.content,
    this.date});
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
      title: profitId!=null&&content!=null&&price!=null&&date!=null?const Text('تعديل الربح'): const Text('تسجيل الربح'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<ProfitProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
            hintText: "عنوان ",
            errorText: validationService.contentData.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeContent(vals);
            },
            inputType: TextInputType.text,
            oldData: content,
          ),
          TextFieldWidget(
            hintText: "سعر ",
            errorText: validationService.priceData.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changePrice(vals);
            },
            inputType: TextInputType.number,
            oldData: price,
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
              initialValue:date,
              onChanged: (vals) {
                validationService.changeDate(vals);
              },
              onSaved: (val) => print(val),
            ),
          ),
          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text: profitId!=null&&content!=null&&price!=null&&date!=null?"تعديل":"اضافه",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {

              if (profitId!=null&&content!=null&&price!=null&&date!=null){
                validationService.editNotesData(price!, content!, profitId!, date!);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainPage()), (route) => false);
              }else if (await validationService.dataOfProfitIsValid){
                validationService.getProfitData();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }



}