import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProductListPage"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text(
            "바나나",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("1000"),
        ),
      ),
    );
  }
}
