import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/model/product.dart';
import 'package:flutter_woocomerce/pages/base_page.dart';
import 'package:flutter_woocomerce/widgets/widget_product_details.dart';

class ProductDetails extends BasePage {
  ProductDetails({Key key, this.product}) : super(key: key);
  Product product;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends BasePageState<ProductDetails> {
  @override
  Widget PageUI() {
    return ProductDetailsWidget(
      data: this.widget.product,
    );
  }
}
