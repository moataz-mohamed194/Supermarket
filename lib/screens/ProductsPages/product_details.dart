import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermarket/screens/MainScreen/MainPageOfBanks.dart';

import '../../domain/ProductDataTextFieldProvider.dart';
import 'AddProductPage.dart';

class ProductDetails extends StatelessWidget{
  final Map<String, dynamic> data;

  const ProductDetails({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: appBarBody(context),
        body: bodyContainer(context),
    );
  }

  AppBar appBarBody (BuildContext context){
    return AppBar(
      title: const Text('المنتج'),
    );
  }



  Widget bodyContainer(BuildContext context){
    final service = Provider.of<ProductDataTextFieldProvider>(context);

    return
      SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 50,),
                      MaterialButton(
                          onPressed: () {
                            if (service.deleteProductValid(data['id']) == true){
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (_) => const MainPage()), (route) => false);
                            }
                          },
                          child:Text('حذف'),
                        color: Colors.red,
                      ),
                      SizedBox(width: 50,),
                      MaterialButton(
                          onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return AddProductPage(id:data['id'].toString(),
                                  name: data['name'].toString(),count:data['count'].toString(),
                                  price:data['price'].toString(),note:data['note'].toString(),
                                  code:data['code'].toString());
                            }));
                          },
                          child:Text("تعديل"),
                        color: Colors.green,
                      )
                    ],
                  ),
                  Text("اسم المنتج :${data['name']}",
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),
                  Text("عدد المنتج :${data['count']}",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  Text("سعر المنتج :${data['price']}",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  Text("ملحوظات المنتج :${data['note']}",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  Text("الرقم السري :${data['code']}",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  Container(
                    child: Text(data.toString()),
                  ),
                ],
              ),
            ),

          )

      );
  }


}