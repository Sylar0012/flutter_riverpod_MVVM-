import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  return ProductListViewStore([], ref)..initViewModel();
});

class ProductListViewStore extends StateNotifier<List<Product>> {
  Ref _ref;
  ProductListViewStore(super.state, this._ref);

  void initViewModel() async {
    List<Product> products = await _ref.read(productHttpRepository).findAll();
    state = products;
  }

  void onRefresh(List<Product> products) {
    state = products;
  }
  // 같은 product타입이라 들어가짐. 나중에 Dto로 받을때 컨버팅 필요함

  void one(int id) {
    state = state.where((product) => product.id == id).toList();
  }

  void addProduct(Product productRespDto) {
    print(productRespDto.name);
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void updateProduct(Product productDto) {
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
