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
                height: 160,
              ),
              Center(
                child: Text(
                  'Welcome Back in Food Deliver',
                  style: titleText,
                ),
              ),
              Image.asset("assets/images/logologin.png", height: 400,),
             
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
                child: GestureDetector(
                  child: Text(
                    "Sign Up with Google ",
                    style: textButton.copyWith(color: kWhiteColor),
                
                  ),
                   onTap: (){
                        authCont.signInWithGoogle();
                      },
                ),
           
              ),
               SizedBox(
                height: 10,
              ),
              
          
             
             
             
                   
             
              // LoginOption(),
            ],
          ),
        ),
      ),
    );
  }
}
