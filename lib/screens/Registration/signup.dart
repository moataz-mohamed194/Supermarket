
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/RegistrationTextFieldProvider.dart';
import 'login.dart';

class SignUpPage extends StatelessWidget{
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: appBarBody(context),
      body: bodyWidget(context),
    );
  }

  AppBar appBarBody(BuildContext context){
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.login),
          tooltip: 'Login Account',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);

          },
        ), //IconButton
      ],
      title: const Text('انشاء الحساب'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<RegistrationTextFieldProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextFieldWidget(
            hintText: "اسم المستخدم",
            errorText: validationService.name.error,
            textIcon: const Icon(Icons.person),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeName(vals);
            },
            inputType: TextInputType.text,
          ),
          TextFieldWidget(
            hintText: "حساب المستخدم",
            errorText: validationService.email.error,
            textIcon: const Icon(Icons.alternate_email),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeEmail(vals);
            },
            inputType: TextInputType.emailAddress,
          ),
          TextFieldWidget(
            hintText: "كلمه السر",
            errorText: validationService.password.error,
            textIcon: const Icon(Icons.lock),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changePassword(vals);
            },
            inputType: TextInputType.text,
          ),
          TextFieldWidget(
            hintText: "اعاده كلمه السر",
            errorText: validationService.repeatPassword.error,
            textIcon: const Icon(Icons.lock),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeRepeatPassword(vals);
            },
            inputType: TextInputType.text,
          ),
          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text: "انشاء الحساب",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {
              if (await validationService.signUpIsValid){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
              }
            },
          )
        ],

      ),
    );
  }
}