
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermarket/screens/Registration/signup.dart';
import 'package:toast/toast.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/RegistrationTextFieldProvider.dart';
import '../MainScreen/MainPageOfBanks.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBody(context),
      body: bodyWidget(context),
    );
  }

  AppBar appBarBody(BuildContext context){
    ToastContext().init(context);
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.person_add),
          tooltip: 'Create Account',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const SignUpPage()), (route) => false);

            },
        ), //IconButton
      ],
      title: const Text('تسجيل الدخول'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<RegistrationTextFieldProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            ButtonWidget(
                height: 50,
                color: Theme.of(context).primaryColor,
                text: "تسجيل الدخول",
                borderColor: Theme.of(context).primaryColor,
                textColor:Theme.of(context).cardColor,
                onPressed: ()  async {
                  if (await validationService.signInIsValid){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const MainPage()), (route) => false);

                  }
                },
            )
          ],

      ),
    );
  }
}