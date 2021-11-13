import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/model/order.dart';
import 'package:flutter_woocomerce/model/payment.method.dart';
import 'package:flutter_woocomerce/widgets/widget_order_success.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocomerce/provider/cart_provider.dart';

class PaymentMethodListItem extends StatelessWidget {
  PaymentMethod paymentMethod;
  PaymentMethodListItem({Key key, this.paymentMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        // print(this.paymentMethod.isrouteredirect);
        if (this.paymentMethod.isrouteredirect) {
          Navigator.of(context).pushNamed(this.paymentMethod.route);
        } else {
          // ignore: unnecessary_statements
          paymentMethod.onTap(context);
          // print(this.paymentMethod.isrouteredirect);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ]),
        child: Row(children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  image: AssetImage(paymentMethod.logo),
                  fit: BoxFit.fill,
                )),
          ),
          Flexible(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paymentMethod.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    paymentMethod.description,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
              SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_right,
                color: Theme.of(context).focusColor,
              )
            ],
          ))
        ]),
      ),
    );
  }
}
