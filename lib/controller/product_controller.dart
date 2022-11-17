// VIEW -> Controller
// 요청만 함. 응답은 provider가 함
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/main.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// @Controller 느낌
final productController = Provider<ProductController>((ref) {
  return ProductController(ref);
});

class ProductController {
  final context = navigatorKey.currentContext!;
  final Ref _ref;
  ProductController(this._ref);

  /**
   * 컨트롤러 : 비지니스 로직 담당
   *  - 그림이랑 관련없이 어떠한 요청이 있을때 알맞게 전달해주는 역할.
   *  - 값이 변경되어 그림이 변경되도 컨트롤러가 해당 데이터를 전달 해줘야함.
   */

  //리프레시 할때 씀
  void findAll() async {
    List<Product> productList =
        await _ref.read(productHttpRepository).findAll();
    _ref.read(productListViewStore.notifier).onRefresh(productList);
  }

  void insert(Product productReqDto) async {
    print(productReqDto.name);
    Product productRespDto =
        await _ref.read(productHttpRepository).insert(productReqDto);
    print(productRespDto.name);
    _ref.read(productListViewStore.notifier).addProduct(productRespDto);
  }

  void deleteById(int id) async {
    print("cotroller 11 : ${id}");
    int code = await _ref.read(productHttpRepository).deleteById(id);
    print("cotroller 22 : ${id}");
    if (code == 1) {
      // findAll 해도 되는데 f5랑 같은 효과라 부하가 심함.
      _ref.read(productListViewStore.notifier).removeProduct(id);
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => MyAlertDialog(msg: "상품 삭제 실패"),
      );
    }
  }

  void updateById(int id, Product productReqDto) async {
    Product productRespDto =
        await _ref.read(productHttpRepository).updateById(id, productReqDto);
    _ref.read(productListViewStore.notifier).updateProduct(productRespDto);
  }
}
