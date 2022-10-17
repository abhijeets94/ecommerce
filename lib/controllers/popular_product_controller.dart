import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      // here we need to build a "model" since we need data in list which we can get from JSON
      // once the data is converted in JSON, it will be easy to handle them
      // _popularProductList.addAll(); //Model Required
      update();
    } else {}
  }
}
