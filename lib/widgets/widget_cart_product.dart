import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_woocomerce/model/cart_response_model.dart';
import 'package:flutter_woocomerce/provider/cart_provider.dart';
import 'package:flutter_woocomerce/provider/loader_provider.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatelessWidget {
  CartItem data;
  CartProduct({this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: makeListTitle(context),
        ));
  }

  ListTile makeListTitle(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        leading: Container(
          width: 50,
          height: 150,
          alignment: Alignment.center,
          child: Image.network(
            data.thumbNail,
            height: 150,
          ),
        ),
        title: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              data.productName,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
        subtitle: Padding(
            padding: EdgeInsets.all(5),
            child: Wrap(direction: Axis.vertical, children: [
              Text(
                "\$${data.productRegularPrice.toString()}",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Qty: " + "${data.qty.toString()}",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ])),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Colors.black,
          highlightColor: Colors.red,
          hoverColor: Colors.green,
          focusColor: Colors.purple,
          splashColor: Colors.yellow,
          disabledColor: Colors.amber,
          iconSize: 24,
          onPressed: () async {
            // Provider.of<LoaderProvider>(context, listen: false)
            //  .setLoadingStatus(true);
            var cartProvider =
                Provider.of<CartProvider>(context, listen: false);
            var productId = data.productId;
            cartProvider.removeCart(productId, (val) {
              //  Provider.of<LoaderProvider>(context, listen: false)
              //     .setLoadingStatus(false);
            });
          },
        ),
      );
}
