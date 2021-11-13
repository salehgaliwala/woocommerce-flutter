import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/model/payment.method.dart';
import 'package:flutter_woocomerce/pages/base_page.dart';
import 'package:flutter_woocomerce/pages/checkout_base.dart';
import 'package:flutter_woocomerce/widgets/widget_payment_method.dart';

class PaymentScreen extends CheckoutBasePage {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends CheckoutBasePageState<PaymentScreen> {
  PaymentMethosList list;
  @override
  void initstate() {
    super.initState();
    this.currentPage = 2;
  }

  @override
  Widget pageUI() {
    list = new PaymentMethosList();
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 15),
        list.paymentsList.length > 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    Icons.payment,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text("Payment Option",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4),
                  subtitle: Text("Select your preferred payment mode"),
                ),
              )
            : SizedBox(height: 0),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return PaymentMethodListItem(
                paymentMethod: list.cashList.elementAt(index));
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemCount: list.cashList.length,
        ),
        SizedBox(height: 15),
        /* list.paymentsList.length > 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    Icons.payment,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text("Cash Payment Option",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4),
                  subtitle: Text("Select your preferred payment mode"),
                ),
              )
            : SizedBox(height: 0),
        SizedBox(
          height: 10,
        ),*/
        /*   ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return PaymentMethodListItem(
                paymentMethod: list.paymentsList.elementAt(index));
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemCount: list.paymentsList.length,
        ),
        SizedBox(height: 15),*/
      ],
    ));
  }
}
