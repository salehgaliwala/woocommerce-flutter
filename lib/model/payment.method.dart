import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocomerce/provider/cart_provider.dart';
import 'package:flutter_woocomerce/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/widgets/widget_order_success.dart';

class PaymentMethod {
  BuildContext _context;
  String id;
  String name;
  String description;
  String logo;
  String route;
  Function onTap;
  bool isrouteredirect;

  PaymentMethod(this.id, this.name, this.description, this.logo, this.route,
      this.onTap, this.isrouteredirect);
}

class PaymentMethosList {
  List<PaymentMethod> _paymentsList;
  List<PaymentMethod> _cashList;

  PaymentMethosList() {
    this._paymentsList = [
      new PaymentMethod("razorpay", "Razorpay", "Click to RazorPay",
          "asset/images/razorpay.png", "/RazorPay", () {}, false),
      new PaymentMethod("paypal", "Paypal", "Click to Paypal",
          "asset/images/paypal.png", "/Paypal", () {}, true),
    ];
    this._cashList = [
      new PaymentMethod(
          "cod",
          "Cash on delivery",
          "Click to pay with cash on delivery",
          "asset/images/cash.png",
          "/orderSuccess", (_context) {
        var orderProvider = Provider.of<CartProvider>(_context, listen: false);
        OrderModel orderModel = new OrderModel();
        orderModel.paymentMethod = 'COD';
        orderModel.paymentMethodTitle = 'Pay by invoice';
        orderModel.setpaid = true;
        orderModel.transactionId = getRandomString(10);
        orderProvider.processOrder(orderModel);
        Navigator.pushAndRemoveUntil(
            _context,
            MaterialPageRoute(builder: (context) => OrderSuccessWidget()),
            ModalRoute.withName('/OrderSuccess'));
      }, false),
    ];
  }

  List<PaymentMethod> get paymentsList => _paymentsList;
  List<PaymentMethod> get cashList => _cashList;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
