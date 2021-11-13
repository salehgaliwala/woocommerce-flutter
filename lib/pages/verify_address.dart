import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/model/customer.dart';
import 'package:flutter_woocomerce/model/customer_detail_model.dart';
import 'package:flutter_woocomerce/pages/checkout_base.dart';
import 'package:flutter_woocomerce/pages/payment_screen.dart';
import 'package:flutter_woocomerce/provider/cart_provider.dart';
import 'package:flutter_woocomerce/utlils/form_helper.dart';
import 'package:provider/provider.dart';

class VerifyAddress extends CheckoutBasePage {
  @override
  _VerifyAddressState createState() => _VerifyAddressState();
}

class _VerifyAddressState extends CheckoutBasePageState<VerifyAddress> {
  @override
  final _formKey = GlobalKey<FormState>();
  CustomerDetailModel customerm = new CustomerDetailModel();
  Color myYellowColor = const Color(0xff1ffc826);
  Color myBlueColor = const Color(0xff1b4573);

  void initState() {
    super.initState();
    currentPage = 0;
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.fetchShippingDetails();
  }

  void saveForm(model) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.updateShippingDetails(model);
  }

  @override
  Widget pageUI() {
    return Consumer<CartProvider>(builder: (context, customerModel, child) {
      //print(customerModel.customerDetailModel.id);
      if (customerModel.customerDetailModel.id != null) {
        return formUI(customerModel.customerDetailModel);
      }
      return formUI(customerModel.customerDetailModel);
      // return Center(
      // child: CircularProgressIndicator(),

      // return formUI(customerModel.customerDetailModel);
      //  );
    });
  }

  Widget formUI(CustomerDetailModel model) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("First Name"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("Last Name"),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.textInput(
                        context,
                        model.shipping.firstName,
                        (value) => {
                          model.shipping.firstName = value,
                        },
                        onValidate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter first Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child:
                            // FormHelper.fieldLabelValue(context, model.lastName),

                            FormHelper.textInput(
                          context,
                          model.shipping.lastName,
                          (value) => {
                            model.shipping.lastName = value,
                          },
                          onValidate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter Last Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                FormHelper.fieldLabel("Address"),
                FormHelper.textInput(
                  context,
                  model.shipping.address1,
                  (value) => {
                    model.shipping.address1 = value,
                  },
                  onValidate: (String value) {
                    if (value.isEmpty) {
                      return 'please enter Address';
                    }
                    return null;
                  },
                ),
                // FormHelper.fieldLabelValue(context, model.shipping.address1),
                FormHelper.fieldLabel("Apartment , Suites etc"),
                FormHelper.textInput(
                  context,
                  model.shipping.address2,
                  (value) => {
                    model.shipping.address2 = value,
                  },
                  onValidate: (String value) {
                    if (value.isEmpty) {
                      return 'Apartment , Suites etc';
                    }
                    return null;
                  },
                ),
                // FormHelper.fieldLabelValue(context, model.shipping.address2),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("City"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("State"),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: // FormHelper.fieldLabelValue(
                          //context, model.shipping.city),
                          FormHelper.textInput(
                        context,
                        model.shipping.city,
                        (value) => {
                          model.shipping.city = value,
                        },
                        onValidate: (String value) {
                          if (value.isEmpty) {
                            return 'City';
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: //FormHelper.fieldLabelValue(
                            //context, model.shipping.state),
                            FormHelper.textInput(
                          context,
                          model.shipping.state,
                          (value) => {
                            model.shipping.state = value,
                          },
                          onValidate: (String value) {
                            if (value.isEmpty) {
                              return 'State';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("Postcode"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("Country"),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: //FormHelper.fieldLabelValue(
                          //context, model.shipping.postcode),
                          FormHelper.textInput(
                        context,
                        model.shipping.postcode,
                        (value) => {
                          model.shipping.postcode = value,
                        },
                        onValidate: (String value) {
                          if (value.isEmpty) {
                            return 'Postcode';
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: // FormHelper.fieldLabelValue(
                            // context, model.shipping.country),
                            FormHelper.textInput(
                          context,
                          model.shipping.country,
                          (value) => {
                            model.shipping.country = value,
                          },
                          onValidate: (String value) {
                            if (value.isEmpty) {
                              return 'Country';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //new Center(
                //  child: FormHelper.saveButton("NEXT", () {
                //Navigator.push(context,
                //  MaterialPageRoute(builder: (context) => PaymentScreen()));
                //})),
                RaisedButton(
                  color: this.myBlueColor,
                  onPressed: () {
                    //print("Test");
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      // print(model.shipping.firstName);
                      saveForm(model);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen()));
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
