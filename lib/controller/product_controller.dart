// VIEW -> Controller
// 요청만 함. 응답은 provider가 함
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';

class ProductController {
  ProductHttpRepository repo = ProductHttpRepository();

  void findAll() {
    List<Product> productList = repo.findAll();
  }
}
