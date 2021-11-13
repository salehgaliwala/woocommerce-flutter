import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/widgets/widget_home_categories.dart';
import 'package:flutter_woocomerce/widgets/widget_home_products.dart';

import '../config.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            //imageCarousel(context),
            // WidgetCategories(),
            WidgetHomeProducts(
              labelName: "Our Products",
              tagId: Config.todayOffersTagId,
            ),
            //  WidgetHomeProducts(
            //  labelName: "Top Selling Products",
            //  tagId: Config.topSellingProductsTagId,
            //)
          ],
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Carousel(
        overlayShadow: false,
        borderRadius: true,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 4.0,
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://www.odobanprofessional.com/media/Header/Header-Discontinued.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://i.pinimg.com/originals/bb/8d/ca/bb8dca87bc56a86addd29716338226d4.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://www.helioswatchstore.com/sites/default/files/upto-50-off-banner.jpg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://www.shoescience.co.nz/media/y0dbzxyi/asics-glideride-30-off-banner-sep20.jpg"),
          ),
        ],
      ),
    );
  }
}
