import 'customer_detail_model.dart';

class OrderModel {
  int customerId;
  String paymentMethod;
  String paymentMethodTitle;
  bool setpaid;
  String transactionId;
  List<LineItems> lineItems;

  int orderId;
  int orderNumber;
  String status;
  DateTime orderDate;
  Shipping shipping;

  OrderModel(
      {this.customerId,
      this.paymentMethod,
      this.paymentMethodTitle,
      this.setpaid,
      this.transactionId,
      this.lineItems,
      this.orderId,
      this.orderNumber,
      this.status,
      this.orderDate});

  OrderModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    orderId = json['id'];
    status = json['status'];
    orderNumber = json['order_key'];
    orderDate = DateTime.parse(json['date_created']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = customerId;
    data['payment_method'] = paymentMethod;
    data['payment_method_title'] = paymentMethodTitle;
    data['set_paid'] = setpaid;
    data['transaction_id'] = transactionId;
    data['shipping'] = shipping.toJson();
    if (lineItems != null) {
      data['line_items'] = lineItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItems {
  int prouctId;
  int quantity;

  LineItems({this.prouctId, this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.prouctId;
    data['quantity'] = this.quantity;

    return data;
  }
}
