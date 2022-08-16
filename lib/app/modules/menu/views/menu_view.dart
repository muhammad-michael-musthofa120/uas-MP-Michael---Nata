// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_klp_michael_nata/app/data/authController.dart';
import 'package:uas_klp_michael_nata/app/data/firebaseStore.dart';
import 'package:uas_klp_michael_nata/utils/prosesTaskAdd.dart';

import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuController> {
  List datamenu = [];
   final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Demo"),
      ),
      body: FutureBuilder(
        future: FireStoreDataBase().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            datamenu = snapshot.data as List;
            return buildItems(datamenu);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildItems(datamenu) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: datamenu.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            height: Get.height * 0.2,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  datamenu[index]["nama_menu"],
                  style: TextStyle(
                    color: Color.fromARGB(255, 222, 222, 222),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  datamenu[index]["keterangan"],
                  style: TextStyle(
                    color: Color.fromARGB(255, 222, 222, 222),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Container(
                  height: 120,
                  child: Image.network(
                    datamenu[index]["gambar"],
                  ),
                ),
                onTap: () {
                  Get.defaultDialog(
                                  title: datamenu[index]["nama_menu"],
                                  
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //update

                                     Column(
                                     children: [
                                     Text( datamenu[index]["keterangan"]),
                                     SizedBox(height: 20,),
                                     Container(
                                     padding: EdgeInsets.all(12),
                                     decoration: BoxDecoration(
                                     color: Colors.blue,
                                     borderRadius: BorderRadius.circular(10)),
                                     child: Text("pesan"),

                                     ),
                                     
                                     ],
                                     
                                     ),
                                     
                                 
                                      
                                    ],
                                  ),
                                  
                                  
                                  );
                            
                },
              ),
            ),
          ),
        );
      });
}
