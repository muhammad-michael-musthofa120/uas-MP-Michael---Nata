import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uas_klp_michael_nata/app/data/authController.dart';
// import 'package:app_task_management/app/utils/style/appColors.dart';



addEditTask({BuildContext? context, String? type, String? docId}) {
final authCon = Get.find<AuthController>();
  
  Get.bottomSheet(
    SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        margin: context!.isPhone
            ? EdgeInsets.zero
            : const EdgeInsets.only(left: 150, right: 150),
        height: Get.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Form(
            key: authCon.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [

              // untuk add dan edit sesuai dengan keadaan
                Text(
                  '$type create',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                    controller: authCon.namaMenuController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Deskripsi',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    //validasi jika kosong pada setiap inputan

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harus di Isi';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 12,
                ),
                 TextFormField(
                    controller: authCon.keterangan_tController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'keterangan pedas/sedang?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    //validasi jika kosong pada setiap inputan

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harus di Isi';
                      }
                      return null;
                    }),
                // dateTimepicker dari plugin dependencis
           
                ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: Get.width, height: 40),
                    child: ElevatedButton(
                        onPressed: () {
                          authCon.saveUpdateTask(
                            authCon.namaMenuController.text,
                            authCon.keterangan_tController.text,
                          
                            docId!,
                            type!,
                          );
                        },
                        //automatis ketika keadaannya bagaimanapun, ada edit dan delete 
                        child: Text(type!))),
                SizedBox(
                  height: 12,
                ),
              ],
            )),
      ),
    ),
  );
}
