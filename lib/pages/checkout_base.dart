import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/utlils/widget_checkpoints.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocomerce/provider/loader_provider.dart';
import 'package:flutter_woocomerce/utlils/progressHUD.dart';

class CheckoutBasePage extends StatefulWidget {
  CheckoutBasePage({Key key}) : super(key: key);

  @override
  CheckoutBasePageState createState() => CheckoutBasePageState();
}

class CheckoutBasePageState<T extends CheckoutBasePage> extends State<T> {
  int currentPage = 0;
  bool showBackbutton = true;
  Color myYellowColor = const Color(0xff1ffc826);
  Color myBlueColor = const Color(0xff1b4573);
  void initState() {
    super.initState();
    print('CheckoutBasePage:initState()');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
      return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: loaderModel.isApiCallProcess,
          opacity: 0.3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CheckPoints(
                  checkTill: currentPage,
                  checkPoints: ["Shipping", "Payments", "Order"],
                  checkPointFilledColor: Colors.green,
                ),
                Divider(
                  color: Colors.grey,
                ),
                pageUI(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: this.myYellowColor,
      automaticallyImplyLeading: showBackbutton,
      title: Text(
        "checkout",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[],
    );
  }

  Widget pageUI() {
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
