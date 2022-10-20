import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      // here we need to build a "model" since we need data in list which we can get from JSON
      // once the data is converted in JSON, it will be easy to handle them
      _popularProductList
          .addAll(Product.fromJson(response.body).products); //Model Required
      _isLoaded = true;
      update();
    } else {}
  }

  //increment or decrement items
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar("There are no items!!", "",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > 20) {
      Get.snackbar("Maximum limit is 20", "",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else
      return quantity;
  }

  void initProduct(
    ProductModel product,
    CartController cart,
  ) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //get from storage in _inCartItems

    print("exist or not $exist");
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    debugPrint("QUantity in the cart is $_inCartItems");
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      debugPrint("id : ${value.id}, quantity : ${value.quantity}");
    });

    update();
  }

  int get totalItems => _cart.totalItems;

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
