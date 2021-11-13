class CartResponseModel {
  bool status;
  List<CartItem> data;

  CartResponseModel({this.status, this.data});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<CartItem>();
      json['data'].forEach((v) {
        data.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  int productId;
  String productName;
  String productRegularPrice;
  String productsalePrice;
  String thumbNail;
  int qty;
  double lineTotal;
  double lineSubTotal;

  CartItem(
      {this.productId,
      this.productName,
      this.productRegularPrice,
      this.productsalePrice,
      this.thumbNail,
      this.qty,
      this.lineTotal,
      this.lineSubTotal});

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productRegularPrice = json['product_regular_price'];
    productsalePrice = json['product_sale_price'];
    thumbNail = json['thumbnail'];
    qty = json['qty'];
    lineSubTotal = double.parse(json['line_subtotal'].toString());
    lineTotal = double.parse(json['line_total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_regular_price'] = this.productRegularPrice;
    data['product_sale_price'] = this.productsalePrice;
    data['thumbnail'] = this.thumbNail;
    data['qty'] = this.qty;
    data['line_subtotal'] = this.lineSubTotal;
    data['line_total'] = this.lineTotal;

    return data;
  }
}
