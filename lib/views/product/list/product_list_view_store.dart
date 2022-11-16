import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  List<Product> products = ref.read(productHttpRepository).findAll();
  return ProductListViewStore(products);
});

class ProductListViewStore extends StateNotifier<List<Product>> {
  ProductListViewStore(super.state);

  void onRefresh(List<Product> products) {
    state = products;
  }
  // 같은 product타입이라 들어가짐. 나중에 Dto로 받을때 컨버팅 필요함

  void addProduct(Product productRespDto) {
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void changeProductPrice(Product productDto) {
    state = state.map((product) {
      if (product.id == productDto.id) {
        product = productDto;
        return product;
      } else {
        return product;
      }
    }).toList();
  }
}
