import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/pages/cart_page.dart';
import 'package:flutter_woocomerce/pages/checkout_base.dart';
import 'package:flutter_woocomerce/pages/home_page.dart';
import 'package:flutter_woocomerce/pages/login_page.dart';
import 'package:flutter_woocomerce/pages/product_details.dart';
import 'package:flutter_woocomerce/pages/product_page.dart';
import 'package:flutter_woocomerce/pages/signup_page.dart';
import 'package:flutter_woocomerce/provider/product_provider.dart';
import 'package:flutter_woocomerce/shared_services.dart';
import 'package:flutter_woocomerce/pages/base_page.dart';
import 'package:flutter_woocomerce/provider/loader_provider.dart';
import 'package:flutter_woocomerce/provider/cart_provider.dart';
import 'package:flutter_woocomerce/pages/verify_address.dart';
import 'package:flutter_woocomerce/widgets/widget_order_success.dart';

import 'package:provider/provider.dart';
import 'pages/login_page.dart';

Widget _defaultHome = new Login();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedin();
  if (_result) {
    _defaultHome = new HomePage();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Color myYellowColor = Color(0xff1ffc826);
  Color myBlueColor = Color(0xff1b4573);
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: ProductPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoaderProvider(),
          child: BasePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
          child: ProductDetails(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
          child: CartPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
          child: CheckoutBasePage(),
        ),
      ],
      child: MaterialApp(
        title: 'Brasabeer App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0,
            foregroundColor: Colors.white,
          ),
          brightness: Brightness.light,
          accentColor: this.myBlueColor,
          dividerColor: this.myBlueColor,
          focusColor: this.myBlueColor,
          hintColor: this.myBlueColor,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 22.0, color: this.myBlueColor),
            headline2: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: this.myBlueColor,
            ),
            headline3: TextStyle(fontSize: 20.0, color: this.myBlueColor),
            headline4: TextStyle(fontSize: 18.0, color: this.myBlueColor),
            subtitle1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.3),
            caption: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
                height: 1.3),
            bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: this.myBlueColor,
            ),
          ),
        ),
        //  home: HomePage(),
        home: Login(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new HomePage(),
          '/login': (BuildContext context) => new Login(),
        },
      ),
    );
  }
}
