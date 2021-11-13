import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_woocomerce/model/order.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocomerce/pages/checkout_base.dart';
import 'package:flutter_woocomerce/provider/cart_provider.dart';

class OrderSuccessWidget extends CheckoutBasePage {
  @override
  _OrderSuccessWidgetState createState() => _OrderSuccessWidgetState();
}

class _OrderSuccessWidgetState
    extends CheckoutBasePageState<OrderSuccessWidget> {
  @override
  void initState() {
    this.currentPage = 2;
    this.showBackbutton = false;
    var orderProvider = Provider.of<CartProvider>(context, listen: false);
    orderProvider.createOrder();
    super.initState();
  }

  @override
  Widget pageUI() {
    return Consumer<CartProvider>(builder: (context, orderModel, child) {
      if (orderModel.isOrderCreated) {
        return Center(
          child: Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.green.withOpacity(1),
                              Colors.green.withOpacity(0.2),
                            ],
                          )),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 90,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    "Your order has been successfully submitted!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                  color: Colors.red,
                  padding: EdgeInsets.all(10.0),
                )
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Text(
              "There is something. No order was created",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        );
      }
      //return Center(
      //child: CircularProgressIndicator(),
      //);
    });
  }
}
