
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/textfield.dart';
import '../../core/widgets/button.dart';
import '../../domain/RegistrationTextFieldProvider.dart';
import '../../domain/SearchTextFieldProvider.dart';
import '../AccruedExpenses/AddExpenses.dart';
import '../ExpensesAndProfit/ExpensesAndProfit.dart';
import '../Notes/GetNotes.dart';
import '../ProductsPages/AddProductPage.dart';
import '../Registration/login.dart';
import '../profit/AddProfit.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }

}
class _MainPage extends State<MainPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBody(context),
      body: bodyContainer(context),
      floatingActionButton:floatingButton(context)
    );
  }

  AppBar appBarBody (BuildContext context){
    final logoutService = Provider.of<RegistrationTextFieldProvider>(context);
    return AppBar(
      actions: <Widget>[
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "معرفه الارباح",
          textColor:Theme.of(context).cardColor,
          onPressed: ()  async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ExpensesAndProfitPage();
            }));
          },
        ),
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "اضافه مصروفات",
          textColor:Theme.of(context).cardColor,
          onPressed: ()  async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddExpensesPage();
            }));
          },
        ),
        ButtonWidget(
        height: 50,
        color: Colors.transparent,
        text: "QR scan",
        textColor:Theme.of(context).cardColor,
        onPressed: ()  async {
        },
      ),
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "ربح",
          textColor:Theme.of(context).cardColor,
          onPressed: ()  async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddProfitPage();
            }));
          },
        ),
        ButtonWidget(
                      height: 50,
                      color: Colors.transparent,
                      text: "ملحوظات",
                      textColor:Theme.of(context).cardColor,
                      onPressed: ()  async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return GetNotesPages();
                        }));
                      },
                    ),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
          onPressed: () async {
            if (await logoutService.checkIfLogOut){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);

            }
          },
        ), //IconButton
      ],
      title: const Text('Welcome'),
    );
  }



  Widget bodyContainer(BuildContext context){
    final validationService = Provider.of<SearchTextFieldProvider>(context);
    int count = 0;
    return Center(
      child: Column(
        children: [
          Column(
            children: [
              TextFieldWidget(
                hintText: "اسم المنتج",
                errorText: validationService.name.error,
                // textIcon: const Icon(Icons.alternate_email),
                cursorColor: Colors.black,
                borderSideColor: Theme.of(context).primaryColor,
                textStyleColor: Colors.black,
                textChange: (vals) {
                  validationService.changeName(vals);
                },
                inputType: TextInputType.emailAddress,
              ),
              TextFieldWidget(
                hintText: "كود المنتج",
                errorText: validationService.code.error,
                // textIcon: const Icon(Icons.alternate_email),
                cursorColor: Colors.black,
                borderSideColor: Theme.of(context).primaryColor,
                textStyleColor: Colors.black,
                textChange: (vals) {
                  validationService.changeName(vals);
                },
                inputType: TextInputType.text,
              ),
              TextFieldWidget(
                hintText: "اقل للسعر",
                errorText: validationService.minPrice.error,
                // textIcon: const Icon(Icons.alternate_email),
                cursorColor: Colors.black,
                borderSideColor: Theme.of(context).primaryColor,
                textStyleColor: Colors.black,
                textChange: (vals) {
                  validationService.changeMinPrice(vals);
                },
                inputType: TextInputType.text,
              ),
              TextFieldWidget(
                hintText: "اعلي سعر",
                errorText: validationService.maxPrice.error,
                // textIcon: const Icon(Icons.alternate_email),
                cursorColor: Colors.black,
                borderSideColor: Theme.of(context).primaryColor,
                textStyleColor: Colors.black,
                textChange: (vals) {
                  validationService.changeMaxPrice(vals);
                },
                inputType: TextInputType.text,
              ),
              ButtonWidget(
                height: 50,
                color: Theme.of(context).primaryColor,
                text: "بحث",
                borderColor: Theme.of(context).primaryColor,
                textColor:Theme.of(context).cardColor,
                onPressed: ()  async {
                  await validationService.getSearchData();
                },
              )

            ],
          ),
          validationService.searchData!.isNotEmpty? Column(
             children: [
               Container(
                        height: 80,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Text(
                                'السعر',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              )
                            ),
                            DataColumn(
                                label: Text(
                                'العدد',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                            )),
                            DataColumn(
                                label: Text(
                                'اسم المنتج',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                            )),
                            DataColumn(

                                label: Text(
                                '           م',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                            )),
                          ],
                          rows: validationService.searchData!.map((e) {
                            return DataRow(
                                cells: [
                                  DataCell(Text(e['price'].toString())),
                                  DataCell(Text(e['count'].toString())),
                                  DataCell(Text(e['name'].toString())),
                                  DataCell(Text("             ${++count}")),
                                ]
                            );
                          }).toList()
                        )
                      ),
              ],
                  ):Container()
            //     }
            // ),

        ],
      ),
    );
  }

  FloatingActionButton floatingButton(BuildContext context){
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddProductPage();
        }));
      },
      child: const Icon(Icons.add),
    );
  }

}