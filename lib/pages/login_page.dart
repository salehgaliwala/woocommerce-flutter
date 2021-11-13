import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/pages/home_page.dart';
import 'package:flutter_woocomerce/pages/signup_page.dart';
import 'package:flutter_woocomerce/utlils/form_helper.dart';
import 'package:flutter_woocomerce/utlils/progressHUD.dart';
import '../api_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  APIServices apiServices;

  String username;
  String password;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Color myYellowColor = Color(0xff1ffc826);
  Color myBlueColor = Color(0xff1b4573);
  @override
  void initState() {
    apiServices = APIServices();
    super.initState();
  }

  Widget _uiScreen() {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(children: [
        Container(
          padding: EdgeInsets.only(top: 100, right: 10, left: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://brasabeer.com/wp-content/uploads/2021/11/Brasa_Logo_RGB-small.png'),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 40, right: 10, left: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Form(
              key: globalKey,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: this.myBlueColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (!value.contains('@') || !value.endsWith('.com')) {
                          return 'Please Enter a valid Email';
                        }
                        if (value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: this.myBlueColor,
                        ),
                      ),
                      onChanged: (value) => username = value,
                    ),
                    TextFormField(
                      obscureText: hidePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        if (value.length < 6) {
                          return 'Password is Too Short';
                        }
                        return null;
                      },
                      onChanged: (value) => password = value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: this.myBlueColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child:
                          Text('Login', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        var validate = globalKey.currentState.validate();
                        if (!validate) {
                          return;
                        }
                        setState(() {
                          isApiCallProcess = true;
                        });
                        var response =
                            await APIServices.loginCustomer(username, password);
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (response) {
                          globalKey.currentState.reset();
                          FormHelper.showMessage(
                              context, 'Done', 'Logged In Successfully', 'Ok',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (HomePage()),
                              ),
                            );
                          });
                        } else {
                          FormHelper.showMessage(
                              context, 'Error!!', 'Email/Password wrong', 'Ok',
                              () {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      color: this.myBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Align(
                      child: GestureDetector(
                        child: Text(
                          'Don\'t have account sign up',
                          style:
                              TextStyle(color: this.myBlueColor, fontSize: 16),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (SignupPage()),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: this.myYellowColor,
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        child: _uiScreen(),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
