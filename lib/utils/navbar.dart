import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_klp_michael_nata/app/data/authController.dart';

import '../app/routes/app_pages.dart';

class Navbar extends StatelessWidget {
   final authCon = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(authCon.auth.currentUser!.displayName!,),
            accountEmail: Text(   authCon.auth.currentUser!.email!,),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                   authCon.auth.currentUser!.photoURL!,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: () => Get.toNamed(Routes.HOME)),
          ListTile(
              leading: Icon(Icons.book),
              title: Text("Menu"),
              onTap: (){},
                    
                  ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Pesananmu"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Kembali"),
             onTap: () => authCon.logout(),
          )
        ],
      ),
    );
  }
}
