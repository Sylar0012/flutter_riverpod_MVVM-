import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ProductListPage가 build 될때 watch로 VM 보고있음
    // VM는 처음 시작할때 repo에 붙어서 findall State 한 상황.
    final pm = ref.watch(productListViewStore);
    final pc = ref.read(productController);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //pc.insert(Product(4, "호박", 2000));
          showCupertinoDialog(
            context: context,
            builder: (context) => MyAlertDialog(msg: "상품 추가 성공"),
          );
        },
      ),
      appBar: AppBar(
        title: Text("ProductListPage"),
      ),
      body: ListView.builder(
        itemCount: pm.length,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(pm[index].id),
          onTap: () {
            //pc.deleteById(pm[index].id);
          },
          onLongPress: () {
            //pc.changePrice(pm[index].id);
          },
          leading: Icon(Icons.account_balance_wallet),
          title: Text(
            "${pm[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${pm[index].price}"),
        ),
      ),
    );
  }
}
