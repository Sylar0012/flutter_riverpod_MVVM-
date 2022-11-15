// VIEW -> Controller
// 요청만 함. 응답은 provider가 함
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/views/product/list/product_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productController = Provider((_) {
  return ProductController();
});

class ProductController {
  ProductHttpRepository repo = ProductHttpRepository();

  void findAll() {
    List<Product> productList = repo.findAll();
  }
}
