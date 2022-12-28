
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/ExpensesProvider.dart';
import '../MainScreen/MainPageOfBanks.dart';

class AddExpensesPage extends StatelessWidget{
  final String? expensesId;
  final String? content;
  final String? price;
  final String? date;
  const AddExpensesPage({super.key,
     this.expensesId,
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
      title: expensesId!=null&&content!=null&&price!=null&&date!=null?const Text('تعديل مصروفات'): const Text('تسجيل مصروفات'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<ExpensesProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
            hintText: "عنوان المصروفات",
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
            hintText: "سعر المصروفات",
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
              dateMask: 'dd-MM-yyyy',
              firstDate: DateTime(2000),

              errorFormatText: validationService.dateData.error,
              dateHintText:'التاريخ' ,
              lastDate: DateTime(2100),
              initialValue:date.toString(),
              onChanged: (vals) {
                validationService.changeDate(vals);
              },
            ),
          ),
          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text: expensesId!=null&&content!=null&&price!=null&&date!=null?"تعديل":"اضافه",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {
              if (expensesId!=null&&content!=null&&price!=null&&date!=null){
                validationService.editNotesData(price!, content!, expensesId!, date!);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainPage()), (route) => false);
              }else if (await validationService.dataOfExpensesIsValid){
                validationService.getExpensesData();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }



}