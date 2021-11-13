import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/api_service.dart';
import 'package:flutter_woocomerce/model/cart_response_model.dart';
import 'package:flutter_woocomerce/model/cart_request_model.dart';
import 'package:flutter_woocomerce/model/customer_detail_model.dart';
import 'package:flutter_woocomerce/model/order.dart';

class CartProvider with ChangeNotifier {
  APIServices _apiService;
  List<CartItem> _cartItems;
  CustomerDetailModel _customerDetailModel;
  OrderModel _orderModel;
  bool _isOrderCreated = false;

  List<CartItem> get cartItems => _cartItems;
  double get totalRecords => _cartItems.length.toDouble();
  double get totalAmount => _cartItems != null
      ? _cartItems
          .map<double>((e) => e.lineSubTotal)
          .reduce((value, element) => value + element)
      : 0;
  CustomerDetailModel get customerDetailModel => _customerDetailModel;
  OrderModel get orderModel => _orderModel;
  bool get isOrderCreated => _isOrderCreated;
  CartProvider() {
    _apiService = new APIServices();
    _cartItems = new List<CartItem>();
  }

  void resetStreams() {
    _apiService = new APIServices();
    _cartItems = new List<CartItem>();
  }

  void addToCart(
    CartProducts product,
    Function onCallBack,
  ) async {
    CartRequestModel requestModel = new CartRequestModel();
    requestModel.products = new List<CartProducts>();

    if (_cartItems == null) resetStreams();

    _cartItems.forEach((element) {
      requestModel.products.add(new CartProducts(
          productId: element.productId, quantity: element.qty));
    });

    var isProductExist = requestModel.products.firstWhere(
      (prd) => prd.productId == product.productId,
      orElse: () => null,
    );

    if (isProductExist != null) {
      requestModel.products.remove(isProductExist);
    }
    requestModel.products.add(product);

    await _apiService.addtoCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel.data != null) {
        _cartItems = [];
        _cartItems.addAll(cartResponseModel.data);
        //print(cartResponseModel);
      }
      onCallBack(requestModel);
      notifyListeners();
    });
  }

  fetchCartItems() async {
    if (_cartItems == null) resetStreams();
    await _apiService.getCartItems().then((cartResponseModel) {
      if (cartResponseModel.data != null) {
        _cartItems.addAll(cartResponseModel.data);
      }
    });
    notifyListeners();
  }

  void updateQty(int productId, int qty) {
    var isProductExist = _cartItems.firstWhere(
      (prd) => prd.productId == productId,
      orElse: () => null,
    );

    if (isProductExist != null) {
      isProductExist.qty = qty;
    }
  }

  void removeCart(productId, Function onCallBack) async {
    var isProductExist = _cartItems.firstWhere(
      (prd) => prd.productId == productId,
      orElse: () => null,
    );
    print(isProductExist.productId);
    if (isProductExist != null) {
      _cartItems.remove(isProductExist);
    }

    CartRequestModel requestModel = new CartRequestModel();
    requestModel.products = new List<CartProducts>();
    if (_cartItems == null) resetStreams();
    print(_cartItems);
    _cartItems.forEach((element) {
      requestModel.products.add(new CartProducts(
          productId: element.productId, quantity: element.qty));
    });
    print(requestModel.products);
    await _apiService.addtoCart(requestModel).then((cartResponseModel) {
      print(cartResponseModel.data);
      if (cartResponseModel.data != null) {
        _cartItems = [];
        _cartItems.addAll(cartResponseModel.data);
        //print(cartResponseModel);
      }
      //  onCallBack(requestModel);
      notifyListeners();
    });
  }

  fetchShippingDetails() async {
    if (_customerDetailModel == null) {
      _customerDetailModel = new CustomerDetailModel();
    }
    _customerDetailModel = await _apiService.customerDetails();
    notifyListeners();
  }

  updateShippingDetails(model) async {
    if (_customerDetailModel == null) {
      _customerDetailModel = new CustomerDetailModel();
    }
    _customerDetailModel = model;
    notifyListeners();
  }

  processOrder(OrderModel orderModel) {
    this._orderModel = orderModel;
    notifyListeners();
  }

  void createOrder() async {
    if (_orderModel.shipping == null) {
      _orderModel.shipping = new Shipping();
    }
    print("Checking Customer Model");
    print(this.customerDetailModel.shipping.firstName);
    if (this.customerDetailModel.shipping != null) {
      _orderModel.shipping = this._customerDetailModel.shipping;
    }

    if (orderModel.lineItems == null) {
      // ignore: deprecated_member_use
      _orderModel.lineItems = new List<LineItems>();

      _cartItems.forEach((v) {
        _orderModel.lineItems
            .add(new LineItems(prouctId: v.productId, quantity: v.qty));
      });
      await _apiService.createOrder(orderModel).then((value) {
        if (value) {
          _isOrderCreated = true;
          notifyListeners();
        }
      });
    }
  }
}
