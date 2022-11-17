import 'dart:convert';

import 'package:data_app/domain/http_connector.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

// 창고에 넣음
final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository(ref);
});

class ProductHttpRepository {
  final Ref _ref;
  ProductHttpRepository(this._ref);

  List<Product> list = [];
  // 통신 + 파싱 해주는 메서드
  // Future<List<Product>> findAll() async {
  //   Response response = await _ref.read(httpConnector).get("/api/product");
  //   // body를 json으로 파싱
  //   // jsonDecode = json -> map 타입으로 변경
  //   // dynamic = 무슨 타입이 들어올지 모를때 써야함. ( 알아도 dynamic 써야 재활용 할수 있음 )
  //   Map<String, dynamic> body = jsonDecode(response.body);
  //   List<dynamic> dataList = body["data"];
  //   List<Product> productList =
  //       // dataList (map) 를  productList로 바꿈
  //       dataList.map((productMap) => Product.fromJson(productMap)).toList();
  //   return productList;
  // }

  Future<List<Product>> findAll() async {
    Response response = await _ref.read(httpConnector).get("/api/product");
    List<dynamic> dataList = jsonDecode(response.body)["data"];
    return dataList.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> findById(int id) async {
    Response response =
        await _ref.read(httpConnector).get("/api/product/${id}");
    Product product = jsonDecode(response.body)["data"];

    return product;
  }

  //fake data
  // List<Product> list = [
  //   Product(1, "바나나", 1000),
  //   Product(2, "딸기", 2000),
  //   Product(3, "참외", 3000),
  // ];
  //
  // Product findById(int id) {
  //   //http 통신코드
  //   Product product = list.singleWhere((product) => product.id == id);
  //   return product;
  // }
  //
  // // name,price만 받아냄.
  // Product insert(Product product) {
  //   //http 통신코드
  //   product.id = 4;
  //   list = [...list, product];
  //   return product;
  // }
  //
  // Product updateById(int id, Product productDto) {
  //   //http 통신코드
  //   list = list.map((product) {
  //     if (product.id == id) {
  //       product = productDto;
  //       return product;
  //     } else {
  //       return product;
  //     }
  //   }).toList();
  //   productDto.id = id;
  //   return productDto;
  // }
  //
  // int deleteById(int id) {
  //   //http 통신코드
  //   list = list.where((product) => product.id == id).toList();
  //   if (id == 4) {
  //     return -1;
  //   }
  //   return 1;
  // }
}
