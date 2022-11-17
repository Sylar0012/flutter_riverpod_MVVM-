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

  Future<Product> findById(int id) async {
    Response response =
        await _ref.read(httpConnector).get("/api/product/${id}");
    Product product = Product.fromJson(jsonDecode(response.body));
    return product;
  }

  Future<List<Product>> findAll() async {
    Response response = await _ref.read(httpConnector).get("/api/product");
    List<dynamic> dataList = jsonDecode(response.body)["data"];
    return dataList.map((e) => Product.fromJson(e)).toList();
  }

  // name, price
  Future<Product> insert(Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());

    Response response =
        await _ref.read(httpConnector).post("/api/product", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }

  Future<int> deleteById(int id) async {
    print("repository delete  111 : ${id}");
    Response response =
        await _ref.read(httpConnector).delete("/api/product/${id}");
    print("repository delete  222 :${response.body}");
    return jsonDecode(response.body)["code"];
  }

  Future<Product> updateById(int id, Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).put("/api/product/${id}", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }
}
