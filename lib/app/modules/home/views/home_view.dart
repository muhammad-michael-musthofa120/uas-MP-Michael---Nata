import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_klp_michael_nata/utils/navbar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    drawer: Navbar(),
      appBar: AppBar(
       
      ),
      body: Center(
        
      ),
    );
  }
}
