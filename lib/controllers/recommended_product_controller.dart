import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("got products recc");
      _recommendedProductList = [];
      // here we need to build a "model" since we need data in list which we can get from JSON
      // once the data is converted in JSON, it will be easy to handle them
      _recommendedProductList
          .addAll(Product.fromJson(response.body).products); //Model Required
      _isLoaded = true;
      update();
    } else {
      print("could not get products recc");
    }
  }
}
