import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_woocomerce/pages/verify_address.dart';
import 'package:flutter_woocomerce/provider/loader_provider.dart';
import 'package:flutter_woocomerce/utlils/progressHUD.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocomerce/model/cart_response_model.dart';
import 'package:flutter_woocomerce/widgets/widget_cart_product.dart';
import 'package:flutter_woocomerce/provider/cart_provider.dart';
import 'package:flutter_woocomerce/provider/loader_provider.dart';
import 'package:flutter_woocomerce/widgets/widget_order_success.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Color myYellowColor = const Color(0xff1ffc826);
  Color myBlueColor = const Color(0xff1b4573);
  @override
  void initState() {
    super.initState();
    var cartItemsList = Provider.of<CartProvider>(context, listen: false);
    cartItemsList.resetStreams();
    cartItemsList.fetchCartItems();
  }

  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loadermodel, child) {
      return Scaffold(
        body: ProgressHUD(
          child: _cartItemsList(),
          inAsyncCall: loadermodel.isApiCallProcess,
          opacity: 0.3,
        ),
      );
    });
    /*CartItem data = new CartItem();
    data.productId = 1;
    data.productName = "Beer Bottles";
    data.productRegularPrice = "20";
    data.productsalePrice = "30.50";
    data.thumbNail =
        'https://brasabeer.com/wp-content/uploads/2021/07/corona-premier_180x-1.webp';

    return CartProduct(data: data);*/
  }

  Widget _cartItemsList() {
    return new Consumer<CartProvider>(
        // ignore: missing_return
        builder: (context, cartItemsList, child) {
      if (cartItemsList.cartItems != null &&
          cartItemsList.cartItems.length > 0) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cartItemsList.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartProduct(data: cartItemsList.cartItems[index]);
                    }),
                Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Text(
                                  "Total: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                new Text(
                                  "\$${cartItemsList.totalAmount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            FlatButton(
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyAddress()))
                              },
                              color: this.myBlueColor,
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Text(
                                    "Checkout",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )))
              ],
            )
          ],
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "There are not products in cart",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
      }
    });
  }
}
