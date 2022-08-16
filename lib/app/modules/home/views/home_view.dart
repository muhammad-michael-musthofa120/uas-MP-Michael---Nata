import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_klp_michael_nata/utils/navbar.dart';

import '../../../../utils/style.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  
  get kZambeziColor => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    drawer: Navbar(),
      appBar: AppBar(
       
      ),
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                child: Text(
                  'Delivery Food Kita',
                  style: titleText,
                ),
              ),
              Image.asset("assets/images/logologin.png", height: 400,),
             
              SizedBox(
                height: 20,
              ),
             SizedBox(
                height: 10,
              ),
              Center(
                      child: Text(
                        'Lezat hemat dan Akurat',
                        style: subTitle,
                      ),
                    ),
              
             
              SizedBox(
                height: 10,
              ),
              // LogInForm(),
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
