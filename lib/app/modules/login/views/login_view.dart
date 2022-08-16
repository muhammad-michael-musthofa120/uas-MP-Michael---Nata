import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_klp_michael_nata/app/data/authController.dart';

import '../../../../utils/style.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
final authCont = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'Welcome Back',
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'New to this app?',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                       authCont.signInWithGoogle();
                    },
                    child: Text(
                      'Sign Up',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // LogInForm(),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: kZambeziColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.08,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: kPrimaryColor),
                child: Text(
                  "Login",
                  style: textButton.copyWith(color: kWhiteColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Or log in with:',
                style: subTitle.copyWith(color: kBlackColor),
              ),
              SizedBox(
                height: 20,
              ),
              // LoginOption(),
            ],
          ),
        ),
      ),
    );
  }
}
