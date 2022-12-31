import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../domain/basket_provider.dart';

class BasketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BasketPage();
  }
}
class _BasketPage extends State<BasketPage> {
  @override
  void initState() {
    super.initState();
  }

  List header = ['اسم المنتج','العدد' , 'السعر', 'حذف من السله', 'زياده','نقص'];

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: appBarBody(context),
      body:   bodyContainer(context),
      floatingActionButton: floatingButton(context));


  }
  AppBar appBarBody(BuildContext context){
    ToastContext().init(context);
    return AppBar(
      title: const Text('السله'),
    );
  }

  Widget bodyContainer(BuildContext context) {
    ToastContext().init(context);
    final basketService = Provider.of<BasketProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          width: 1250,
          height: double.parse(
              '${basketService.basketData.length * 100}'.toString()),
          child: LazyDataTable(
            rows: basketService.basketData.length,
            columns: 6,
            tableDimensions: const LazyDataTableDimensions(
              cellHeight: 50,
              cellWidth: 200,
            ),
            topHeaderBuilder: (i) => Center(child: Text("${header[i]}")),
            leftHeaderBuilder: (i) => Center(child: Text("${i + 1}")),
            dataCellBuilder: (i, j) {
              var data = basketService.basketData[i];
              if (j == 0) {
                return Center(child: Text("${data['name']}"));
              } else if (j == 1) {
                return Center(child: Text("${data['countOfOrder']}"));
              } else if (j == 2) {
                return Center(child: Text("${data['price']}"));
              } else if (j == 3){
                return  IconButton(
                    onPressed: () {
                      basketService.removeFromBasketData(data);
                    },
                    icon: const Icon(Icons.close));
              }else if (j == 4){
                return  IconButton(
                    onPressed: () {
                      basketService.increaseFromBasketData(data);
                    },
                    icon: const Icon(Icons.add));
              }else {
                return  IconButton(
                    onPressed: () {
                      basketService.decreaseFromBasketData(data);

                    },
                    icon: const Icon(Icons.minimize));
              }
            },
            topLeftCornerWidget: const Center(
              child: Text("م"),
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Provider.of<BasketProvider>(context,listen: false).cleanBasketData();
      },
      child: const Icon(Icons.cleaning_services),
    );
  }

}