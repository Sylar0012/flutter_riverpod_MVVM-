import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 창고에 넣음
final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository();
});

class ProductHttpRepository {
  //fake data
  List<Product> list = [
    Product(1, "바나나", 1000),
    Product(2, "딸기", 2000),
    Product(3, "참외", 3000),
  ];

  Product findById(int id) {
    //http 통신코드
    Product product = list.singleWhere((product) => product.id == id);
    return product;
  }

  List<Product> findAll() {
    return list;
  }

  // name,price만 받아냄.
  Product insert(Product product) {
    //http 통신코드
    product.id = 4;
    list = [...list, product];
    return product;
  }

  Product updateById(int id, Product productDto) {
    //http 통신코드
    list = list.map((product) {
      if (product.id == id) {
        product = productDto;
        return product;
      } else {
        return product;
      }
    }).toList();
    productDto.id = id;
    return productDto;
  }

  int deleteById(int id) {
    //http 통신코드
    list = list.where((product) => product.id == id).toList();
    return 1;
  }
}
