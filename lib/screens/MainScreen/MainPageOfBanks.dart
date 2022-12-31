import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lazy_data_table/lazy_data_table.dart';
import 'package:toast/toast.dart';
import '../../core/widgets/textfield.dart';
import '../../core/widgets/button.dart';
import '../../domain/RegistrationTextFieldProvider.dart';
import '../../domain/SearchTextFieldProvider.dart';
import '../../domain/basket_provider.dart';
import '../AccruedExpenses/AddExpenses.dart';
import '../ExpensesAndProfit/ExpensesAndProfit.dart';
import '../Notes/GetNotes.dart';
import '../ProductsPages/AddProductPage.dart';
import '../ProductsPages/basket_page.dart';
import '../ProductsPages/product_details.dart';
import '../Received/GetReceived.dart';
import '../Registration/login.dart';
import '../profit/AddProfit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
        appBar: appBarBody(context),
        body: bodyContainer(context),
        floatingActionButton: floatingButton(context));
  }

  AppBar appBarBody(BuildContext context) {
    final logoutService = Provider.of<RegistrationTextFieldProvider>(context);
    return AppBar(
      actions: <Widget>[
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "المستلم",
          textColor: Theme.of(context).cardColor,
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return GetReceivedPages();
            }));
          },
        ),
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "السله",
          textColor: Theme.of(context).cardColor,
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BasketPage();
            }));
          },
        ),
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "معرفه الارباح",
          textColor: Theme.of(context).cardColor,
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ExpensesAndProfitPage();
            }));
          },
        ),
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "اضافه مصروفات",
          textColor: Theme.of(context).cardColor,
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddExpensesPage();
            }));
          },
        ),
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "ربح",
          textColor: Theme.of(context).cardColor,
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddProfitPage();
            }));
          },
        ),
        ButtonWidget(
          height: 50,
          color: Colors.transparent,
          text: "ملحوظات",
          textColor: Theme.of(context).cardColor,
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const GetNotesPages();
            }));
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
          onPressed: () async {
            if (await logoutService.checkIfLogOut) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false);
            }
          },
        ), //IconButton
      ],
      title: const Text('Welcome'),
    );
  }

  List header = ['اسم المنتج', 'العدد', 'السعر', 'اضافه للسله'];

  Widget bodyContainer(BuildContext context) {
    final validationService = Provider.of<SearchTextFieldProvider>(context);
    // validationService.cleanSearchData();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        scrollDirection: Axis.vertical,
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
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.25,
                child: ButtonWidget(
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  text: "بحث ب qr",
                  borderColor: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).cardColor,
                  onPressed: () async {
                    // await validationService.getSearchData();
                  },
                ),
              ),
              ButtonWidget(
                height: 50,
                color: Theme.of(context).primaryColor,
                text: "بحث",
                borderColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).cardColor,
                onPressed: () async {
                  await validationService.getSearchData();
                },
              )
            ],
          ),
          validationService.searchData != null?
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                width: 850,
                height: double.parse(
                    '${validationService.searchData!.length * 100}'.toString()),
                child: LazyDataTable(
                  rows: validationService.searchData!.length,
                  columns: 4,
                  tableDimensions: const LazyDataTableDimensions(
                    cellHeight: 50,
                    cellWidth: 200,
                  ),
                  topHeaderBuilder: (i) => Center(child: Text("${header[i]}")),
                  leftHeaderBuilder: (i) => Center(child: Text("${i + 1}")),
                  dataCellBuilder: (i, j) {
                    var data = validationService.searchData![i];
                    if (j == 0) {
                      return Center(
                          child:TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ProductDetails(data:data);
                              }));
                            },
                            child:Text("${data['name']}")
                          )
                      );
                    } else if (j == 1) {
                      return Center(child: Text("${data['count']}"));
                    } else if (j == 2) {
                      return Center(child: Text("${data['price']}"));
                    } else {
                      return IconButton(
                          onPressed: () {
                            Provider.of<BasketProvider>(context, listen: false).addToBasketData(data);
                          },
                          icon: const Icon(Icons.shopping_basket_outlined));
                    }
                  },
                  topLeftCornerWidget: const Center(
                    child: Text("م"),
                  ),
                ),
              ),
            ),
          ):
          Container()
        ],
      ),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
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
