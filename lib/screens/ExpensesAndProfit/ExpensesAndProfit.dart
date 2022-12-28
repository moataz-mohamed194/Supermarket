import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../core/widgets/button.dart';
import '../../domain/ExpensesAndProfitProvider.dart';
import '../AccruedExpenses/AddExpenses.dart';
import '../profit/AddProfit.dart';

class ExpensesAndProfitPage extends StatelessWidget {
  const ExpensesAndProfitPage({super.key});

  //   @override
//   State<StatefulWidget> createState() {
//     return _ExpensesAndProfitPage();
//   }
// }
//
// class _ExpensesAndProfitPage extends State<ExpensesAndProfitPage> {
// @override
//   void dispose() {
//     super.dispose();
//     final validationService = Provider.of<ExpensesAndProfitProvider>(context,listen: false);
//     validationService.totalOfSold=0;
//     validationService.totalOfProfit=0;
//     validationService.totalOfExpenses=0;
//
// }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: appBarBody(context),
        body: bodyContainer(context),
    );
  }
  AppBar appBarBody(BuildContext context){
    return AppBar(
      title: const Text('الارباح'),
    );
  }


  Widget bodyContainer(BuildContext context){
    final validationService = Provider.of<ExpensesAndProfitProvider>(context);
    int count1 = 0;
    int count2 = 0;
    double widthOf3 = MediaQuery.of(context).size.width/13;
    double widthOf4 = MediaQuery.of(context).size.width/20;
    return Center(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width-80,
                child: Row(
                  children: [
                    Expanded(
                      child: DateTimePicker(
                        textAlign: TextAlign.right,
                        type: DateTimePickerType.date,
                        dateMask: 'dd/MM/yyyy',
                        firstDate: DateTime(2000),
                        errorFormatText: validationService.toDateData.error,
                        dateHintText:'الي' ,
                        lastDate: DateTime(2100),
                        onChanged: (vals) {
                          validationService.changeToDate(vals);
                        },
                      ),
                    ),
                    const SizedBox(width: 40,),
                    Expanded(
                      child:DateTimePicker(
                        textAlign: TextAlign.right,
                        type: DateTimePickerType.date,
                        dateMask: 'dd/MM/yyyy',
                        firstDate: DateTime(2000),
                        errorFormatText: validationService.fromDateData.error,
                        dateHintText:'من' ,
                        lastDate: DateTime(2100),
                        onChanged: (vals) {
                          validationService.changeFromDate(vals);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ButtonWidget(
                height: 50,
                color: Theme.of(context).primaryColor,
                text: "بحث",
                borderColor: Theme.of(context).primaryColor,
                textColor:Theme.of(context).cardColor,
                onPressed: ()  async {
                  await validationService.getProfitAndExpenses();
                },
              )

            ],
          ),
          Container(
            child:validationService.totalOfExpenses != 0?
            Column(
              children: [
                const Text('المصروفات',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black ,
                    fontWeight: FontWeight.bold,
                  ),),
                 DataTable(
                        columns:  [
                          DataColumn(
                              label: Container(
                                width: widthOf3,
                                alignment: Alignment.center,
                                child: const Text(
                                    'حذف',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                ),
                              )
                          ),
                          DataColumn(
                              label: Container(
                                width: widthOf3,
                                alignment: Alignment.center,
                                child: const Text(
                                    'تعديل',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                ),
                              )
                          ),
                          DataColumn(
                              label: Container(
                                width: widthOf3,
                                alignment: Alignment.center,
                                child: const Text(
                                    'التاريخ',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                ),
                              )
                          ),
                          DataColumn(
                              label: Container(
                                width: widthOf3,
                                alignment: Alignment.center,
                                child: const Text(
                                    'السعر',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                ),
                              )
                          ),

                          DataColumn(
                              label: Container(
                                width: widthOf3,
                                alignment: Alignment.center,
                                child: const Text(
                                    'اسم ',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                ),
                              )),

                          DataColumn(
                              label: Container(
                                alignment: Alignment.center,
                                width: widthOf3,
                                child: const Text(
                                    'م',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                ),
                              )),
                        ],
                        rows: validationService.expensesDataList!.map((e) {
                          return DataRow(
                              cells: [
                                DataCell(
                                    Container(
                                        alignment: Alignment.center,
                                        child: IconButton(
                                            onPressed:() {
                                              validationService.deleteExpenses(e['id']);
                                            },
                                            icon: const Icon(Icons.close),
                                            color: Colors.red
                                        ),
                                    )
                                ),
                                DataCell(
                                    Container(
                                        alignment: Alignment.center,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return AddExpensesPage(
                                                    expensesId: e['id'].toString(),
                                                    content: e['content'].toString(),
                                                    price: e['price'].toString(),
                                                    date: e['dateOfAction'].toString()
                                                );
                                              }));
                                            },
                                            icon: const Icon(Icons.edit)
                                        )
                                    )
                                ),
                                DataCell(
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(e['dateOfAction'].toString())
                                    )
                                ),
                                DataCell(
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(e['price'].toString())
                                    )
                                ),
                                DataCell(
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(e['content'].toString()
                                        )
                                    )
                                ),
                                DataCell(
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text("${++count1}")
                                    )
                                ),
                              ]
                          );
                        }).toList()
                    ),
                Text('الاجمالي : ${validationService.totalOfExpenses}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black ,
                    fontWeight: FontWeight.bold,
                  ),)
              ],
            ):
            Container()
          ),
          Container(
            child:validationService.totalOfSold != 0?
            Column(
              children: [
                const Text('المبيعات',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black ,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(
                  child: DataTable(
                      columns:  [
                        DataColumn(
                            label: Container(
                              width: widthOf3,
                              alignment: Alignment.center,
                              child: const Text(
                                  'حذف',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            )
                        ),
                        DataColumn(
                            label: Container(
                              width: widthOf3,
                              alignment: Alignment.center,
                              child: const Text(
                                  'تعديل',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            )
                        ),
                        DataColumn(
                            label: Container(
                              width: widthOf4,
                              alignment: Alignment.center,
                              child: const Text(
                                  'التاريخ',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            )
                        ),
                        DataColumn(
                            label: Container(
                              width: widthOf4,
                              alignment: Alignment.center,
                              child: const Text(
                                  'السعر',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            )
                        ),
                        DataColumn(
                            label: Container(
                              width: widthOf4,
                              alignment: Alignment.center,
                              child: const Text(
                                  'العدد',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            )
                        ),
                        DataColumn(
                            label: Container(
                              width: widthOf4,
                              alignment: Alignment.center,
                              child: const Text(
                                  'اسم ',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            )),
                        DataColumn(
                            label: Container(
                              width: widthOf4,
                              alignment: Alignment.center,
                              child: const Text(
                                  'م',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            )),
                      ],
                      rows: validationService.profitDataList!.map((e) {
                        return DataRow(
                            cells: [
                              DataCell(
                                  Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        onPressed:() {
                                          validationService.deleteProfit(e['id']);
                                        },
                                        icon: const Icon(Icons.close),
                                        color: Colors.red
                                    ),
                                  )
                              ),
                              DataCell(
                                  Container(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return AddProfitPage(
                                                  profitId: e['id'].toString(),
                                                  content: e['content'].toString(),
                                                  price: e['price'].toString(),
                                                  date: e['dateOfAction'].toString()
                                              );
                                            }));
                                          },
                                          icon: const Icon(Icons.edit)
                                      )
                                  )
                              ),
                              DataCell(
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(e['dateOfAction'].toString())
                                  )
                              ),
                              DataCell(
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(e['price'].toString())
                                  )
                              ),
                              DataCell(
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(e['count'].toString())
                                  )
                              ),
                              DataCell(
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(e['content'].toString())
                                  )
                              ),
                              DataCell(
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text("${++count2}")
                                  )
                              ),
                            ]
                        );
                      }).toList()
                  )
                ),
                Text('الاجمالي : ${validationService.totalOfSold}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black ,
                    fontWeight: FontWeight.bold,
                  ),)
              ],
            ):
            Container(),
          ),
          Container(
            alignment: Alignment.center,
            child: validationService.totalOfProfit != 0?
            Text('صافي الربح : ${validationService.totalOfProfit}',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black ,
                fontWeight: FontWeight.bold,
              ),):
            Container(),
          )
        ],
      ),
    );
  }

}