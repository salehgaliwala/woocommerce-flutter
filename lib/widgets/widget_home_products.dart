import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/model/product.dart';
import 'package:flutter_woocomerce/pages/product_details.dart';
import 'dart:developer';

import '../api_service.dart';

class WidgetHomeProducts extends StatefulWidget {
  WidgetHomeProducts({Key key, this.labelName, this.tagId}) : super(key: key);
  String labelName;
  String tagId;

  @override
  _WidgetHomeProductsState createState() => _WidgetHomeProductsState();
}

class _WidgetHomeProductsState extends State<WidgetHomeProducts> {
  APIServices apiServices;
  Color myYellowColor = const Color(0xff1ffc826);
  Color myBlueColor = const Color(0xff1b4573);
  @override
  void initState() {
    apiServices = APIServices();
    super.initState();
    log('data:' + this.widget.tagId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  this.widget.labelName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4, right: 4),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: this.myBlueColor),
                  ),
                ),
              ),
            ],
          ),
          _productsList(),
        ],
      ),
    );
  }

  Widget _productsList() {
    return FutureBuilder(
      future: apiServices.getProducts(tagName: this.widget.tagId),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Product>> model,
      ) {
        if (model.hasData) {
          return _buildList(model.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<Product> items) {
    return Container(
      height: 400,
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(
                            product: data,
                          )));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  child: Image.network(
                    data.images[0].src,
                    height: 300,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 5),
                        blurRadius: 15,
                      )
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  child: Text(
                    data.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  child: Text(
                    '\$${data.salePrice}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
