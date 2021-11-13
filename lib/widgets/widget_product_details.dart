import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/model/cart_request_model.dart';
import 'package:flutter_woocomerce/model/product.dart';
import 'package:flutter_woocomerce/pages/cart_page.dart';
import 'package:flutter_woocomerce/utlils/custom_stepper.dart';
import 'package:flutter_woocomerce/utlils/expand_text.dart';
import 'package:flutter_woocomerce/widgets/widget_related_products.dart';
import 'package:flutter_woocomerce/utlils/form_helper.dart';
import 'package:flutter_woocomerce/provider/cart_provider.dart';
import 'package:flutter_woocomerce/provider/loader_provider.dart';
import 'package:provider/provider.dart';
import '../api_service.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key key, this.data}) : super(key: key);
  Product data;
  final CarouselController _controller = CarouselController();
  int qyt = 0;
  APIServices apiServices;
  CartProducts cartProducts = new CartProducts();
  Color myYellowColor = const Color(0xff1ffc826);
  Color myBlueColor = const Color(0xff1b4573);
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                productImages(data.images, context),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: data.calculateDiscount() > 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.green),
                      child: Text(
                        '${data.calculateDiscount()}% OFF',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data.attributes != null && data.attributes.length > 0
                        ? (data.attributes[0].options.join("-").toString() +
                            "" +
                            data.attributes[0].name)
                        : ""),
                    Text(
                      '\$${data.salePrice}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStepper(
                        lowerLimit: 1,
                        upperLimit: 20,
                        stepValue: 1,
                        iconSize: 22.0,
                        value: this.qyt,
                        onChanged: (value) {
                          print(value);
                          this.qyt = value;
                          cartProducts.quantity = value;
                        }),
                    FlatButton(
                      onPressed: () async {
                        //Provider.of<LoaderProvider>(context, listen: false)
                        //   .setLoadingStatus(true);
                        var cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        cartProducts.productId = data.id;
                        cartProvider.addToCart(cartProducts, (val) {
                          //  Provider.of<LoaderProvider>(context, listen: false)
                          //    .setLoadingStatus(false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        });

                        /*var response =
                            await APIServices.addCart(data.id, this.qyt);
                        if (response) {
                          FormHelper.showMessage(
                              context, 'Done', 'Product Added to cart', 'Ok',
                              () {
                            Navigator.of(context).pop();
                          });
                        } else {
                          FormHelper.showMessage(
                              context, 'Error!!', 'Error Try again', 'Ok', () {
                            Navigator.of(context).pop();
                          });
                        }*/
                      },
                      child: Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: this.myBlueColor,
                      padding: EdgeInsets.all(15),
                      shape: StadiumBorder(),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ExpandText(
                  labelHeader: "Product Details",
                  shortDec: data.shortDescription,
                  dec: data.description,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                WidgetRelatedProducts(
                  labelName: "Related Products",
                  products: this.data.relatedIds,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productImages(List<Images> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: Image.network(
                      images[index].src,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1.0,
              ),
              carouselController: _controller,
            ),
          ),
          Positioned(
            top: 100,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                _controller.previousPage();
              },
            ),
          ),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width - 80,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _controller.nextPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
