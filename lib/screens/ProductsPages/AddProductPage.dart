import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/ProductDataTextFieldProvider.dart';
import '../MainScreen/MainPageOfBanks.dart';

class AddProductPage extends StatelessWidget{
  final String? name;
  final String? count;
  final String? code;
  final String? price;
  final String? note;
  final String? id;

  const AddProductPage({
    super.key,
    this.note,
    this.id,
    this.name,
    this.count,
    this.code,
    this.price});
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
      title: const Text('تسجيل منتج'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<ProductDataTextFieldProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
            hintText: "اسم المنتج",
            errorText: validationService.nameOfProduct.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeNameOfProduct(vals);
            },
            inputType: TextInputType.number,
            oldData: name,
          ),
          TextFieldWidget(
            hintText: "عدد المنتجات",
            errorText: validationService.countOfProduct.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeCountOfProduct(vals);
            },
            inputType: TextInputType.number,
            oldData: count,
          ),
          TextFieldWidget(
            hintText: "كود المنتج",
            errorText: validationService.codeOfProduct.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeCodeOfProduct(vals);
            },
            inputType: TextInputType.number,
            oldData: code,
          ),
          TextFieldWidget(
            hintText: "سعر المنتج",
            errorText: validationService.priceOfProduct.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changePriceOfProduct(vals);
            },
            inputType: TextInputType.number,
            oldData: price,
          ),

          TextFieldWidget(
            hintText: "ملاحظه المنتج",
            errorText: validationService.noteOfProduct.error,
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeNoteOfProduct(vals);
            },
            inputType: TextInputType.number,
            oldData: note,
          ),

          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text: "اضافه",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {
              if (name!=null&&count!=null&&price!=null&&note!=null&&code!=null&&id!=null){
                validationService.editProductValid(id!, name!,count!, price!,  note!, code!);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainPage()), (route) => false);
              }else if (await validationService.dataOfProductIsValid){
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }


}