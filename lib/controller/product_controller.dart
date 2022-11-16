// VIEW -> Controller
// 요청만 함. 응답은 provider가 함
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// @Controller 느낌
final productController = Provider<ProductController>((ref) {
  return ProductController(ref);
});

class ProductController {
  final Ref _ref;
  ProductController(this._ref);

  //리프레시 할때 씀
  void findAll() {
    List<Product> productList = _ref.read(productHttpRepository).findAll();
    _ref.read(productListViewStore.notifier).onRefresh(productList);
  }

  // void insert(Product productReqDto) {
  //   Product productRespDto =
  //       _ref.read(productHttpRepository).insert(productReqDto);
  //   _ref.read(productListViewStore.notifier).addProduct(productRespDto);
  // }
}
