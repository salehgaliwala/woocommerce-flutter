import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/api_service.dart';
import 'package:flutter_woocomerce/model/customer.dart';
import 'package:flutter_woocomerce/utlils/form_helper.dart';
import 'package:flutter_woocomerce/utlils/progressHUD.dart';
import 'package:flutter_woocomerce/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  APIServices apiServices;
  CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  Color myYellowColor = Color(0xff1ffc826);
  Color myBlueColor = Color(0xff1b4573);

  @override
  void initState() {
    apiServices = new APIServices();
    model = new CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.myYellowColor,
        automaticallyImplyLeading: true,
        title: Text('Sign Up'),
      ),
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: _formUI(),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel('First Name'),
                FormHelper.textInput(
                  context,
                  model.firstName,
                  (value) => {
                    this.model.firstName = value,
                  },
                  onValidate: (String value) {
                    if (value.isEmpty) {
                      return 'please enter first Name';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel('Last Name'),
                FormHelper.textInput(
                  context,
                  model.lastName,
                  (value) => {
                    this.model.lastName = value,
                  },
                  onValidate: (String value) {
                    if (value.isEmpty) {
                      return 'please enter last Name';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel('Email'),
                FormHelper.textInput(
                  context,
                  model.email,
                  (String value) {
                    model.email = value;
                  },
                  onValidate: (String value) {
                    if (!value.contains('@') || !value.endsWith('.com')) {
                      return 'Please Enter a valid Email';
                    }
                    if (value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel('Password'),
                FormHelper.textInput(
                  context,
                  model.password,
                  (value) => {
                    this.model.password = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'please enter Password';
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Theme.of(context).accentColor.withOpacity(.4),
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FormHelper.saveButton(
                    'SignUp',
                    () async {
                      FocusScope.of(context).unfocus();
                      var validate = globalKey.currentState.validate();
                      if (!validate) {
                        return;
                      }
                      globalKey.currentState.save();
                      print(model.toJson());
                      setState(() {
                        isApiCallProcess = true;
                      });
                      var ret = await apiServices.createCustomer(model);
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (ret) {
                        FormHelper.showMessage(
                          context,
                          'Done',
                          'User has been Created successfully',
                          'OK',
                          () {
                            // Navigator.of(context).pop();
                            return Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                        );
                      } else {
                        FormHelper.showMessage(context, 'Error',
                            'Something went wrong, check your Data', 'OK', () {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
