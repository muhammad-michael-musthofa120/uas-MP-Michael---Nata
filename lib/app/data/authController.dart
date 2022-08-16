import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uas_klp_michael_nata/app/routes/app_pages.dart';


class AuthController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //read data
  List menu = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("user");

  UserCredential? _userCredential;
  //serach data m
  late TextEditingController searchFriendsController,
      titleController,
      namaMenuController,
      keterangan_tController;

  @override
  void onInit() {
    super.onInit();
    searchFriendsController = TextEditingController();
    namaMenuController = TextEditingController();
    keterangan_tController = TextEditingController();
  }
  

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchFriendsController.dispose();
    titleController.dispose();
    namaMenuController.dispose();
    keterangan_tController.dispose();
   
  }

  //read data

  Future getData() async {
    try {
      //to get data from a single/particular document alone.
      var temp = await collectionRef.doc("menu").get();

      // to get data from all documents sequentially
      

      return temp;
    } catch (e) {
      debugPrint("Error - $e");
      return e;
    }
  }


  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print(googleUser!.email);
    // Once signed in, return the UserCredential
    await auth
        .signInWithCredential(credential)
        .then((value) => _userCredential = value);

    print(googleUser.email);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => _userCredential = value);

    CollectionReference users = firestore.collection('users');

    final cekUser = await users.doc(googleUser.email).get();
    if (!cekUser.exists) {
      users.doc(googleUser.email).set({
        'uid': _userCredential!.user!.uid,
        'name': googleUser.displayName,
        'email': googleUser.email,
        'photo': googleUser.photoUrl,
        'createdAt': _userCredential!.user!.metadata.creationTime.toString(),
        'lastLoginAt':
            _userCredential!.user!.metadata.lastSignInTime.toString(),
        // 'list_cari' : [R, RE, REZ, REZA]
      }).then((value) async {
        String temp = '';
        try {
          for (var i = 0; 1 < googleUser.displayName!.length; i++) {
            temp = temp + googleUser.displayName![i];
            await users.doc(googleUser.email).set({
              'list_cari': FieldValue.arrayUnion([temp.toUpperCase()])
            }, SetOptions(merge: true));
          }
        } catch (e) {
          print(e);
        }
      });
    } else {
      users.doc(googleUser.email).update({
        'lastLoginAt':
            _userCredential!.user!.metadata.lastSignInTime.toString(),
      });
    }
    Get.offAllNamed(Routes.HOME);
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  //variabel
  var kataCari = [].obs;
  var hasilPencarian = [].obs;
  //vid15, data diperoleh dari inputan serach

  void addFriends(String _emailFriends) async {
    CollectionReference friends = firestore.collection('friends');

    //query data ke database
    final cekFriends = await friends.doc(auth.currentUser!.email).get();
    //cek data ada tidak
    if (cekFriends.data() == null) {
      await friends.doc(auth.currentUser!.email).set({
        'emailMe': auth.currentUser!.email,
        'emailFriends': [_emailFriends],
      }).whenComplete(
          () => Get.snackbar("Friends", "Friends Berhasil ditambahkan"));
    } else {
      await friends.doc(auth.currentUser!.email).set({
        'emailFriends': FieldValue.arrayUnion([_emailFriends]),
      }, SetOptions(merge: true)).whenComplete(
          () => Get.snackbar("Friends", "Friends Berhasil ditambahkan"));
    }
    kataCari.clear();
    hasilPencarian.clear();
    searchFriendsController.clear();
    Get.back();
  }

  void searchFriends(String keyword) async {
    CollectionReference users = firestore.collection('users');

    if (keyword.isNotEmpty) {
      final hasilQuery = await users
          .where('list_cari', arrayContains: keyword.toUpperCase())
          .get();

      if (hasilQuery.docs.isNotEmpty) {
        for (var i = 0; i < hasilQuery.docs.length; i++) {
          kataCari.add(hasilQuery.docs[i].data() as Map<String, dynamic>);
        }
      }

      if (kataCari.isNotEmpty) {
        hasilPencarian.value = [];

        kataCari.forEach((element) {
          print(element);
          hasilPencarian.add(element);
        });
        kataCari.clear();
      }
    } else {
      kataCari.value = [];
      hasilPencarian.value = [];
    }
    kataCari.refresh();
    hasilPencarian.refresh();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> StreamFriends() {
    return firestore
        .collection('friends')
        .doc(auth.currentUser!.email)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> StreamUsers(String email) {
    return firestore.collection('users').doc(email).snapshots();
  }
  //stream task

  Stream<DocumentSnapshot<Map<String, dynamic>>> StreamTask(String taskId) {
    return firestore.collection('booking').doc(taskId).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPeople() async {
    CollectionReference friendsCollec = firestore.collection('friends');

    final cekFriends = await friendsCollec.doc(auth.currentUser!.email).get();
    var listFriends =
        (cekFriends.data() as Map<String, dynamic>)['emailFriends'] as List;
    QuerySnapshot<Map<String, dynamic>> hasil = await firestore
        .collection('users')
        .where('email', whereNotIn: listFriends)
        .get();

    return hasil;
  }

  void saveUpdateTask(String? nama_menu, String? keterangan_t,
      String? docId, String? type) async {
    print(nama_menu);
    print(keterangan_t);
    print(docId);
    print(type);

    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    CollectionReference taskColl = firestore.collection('task');
    CollectionReference userColl = firestore.collection('users');
    var menuId = DateTime.now().toIso8601String();
    if (type == 'Add') {
      await taskColl.doc(menuId).set({
        'nama_menu': nama_menu,
        'keterangan_t': keterangan_t, 
        'status': '0',
       
        'task_detail': [],
        'asign_to': [auth.currentUser!.email],
        'created_by': auth.currentUser!.email,
      }).whenComplete(() async {
        await userColl.doc(auth.currentUser!.email).set({
          'task_id': FieldValue.arrayUnion([menuId])
        }, SetOptions(merge: true));
        Get.back();
        Get.snackbar('Task', 'successfuly $type');
      }).catchError((error) {
        Get.snackbar('Task', 'Error $type');
      });
    } else {
      await taskColl.doc(docId).update({
        'nama_menu': nama_menu,
      
      
      }).whenComplete(() async {
        // await userColl.doc(auth.currentUser!.email).set({
        //   'task_id': FieldValue.arrayUnion([taskId])
        // }, SetOptions(merge: true));
        Get.back();
        // $type = status add atau edit
        Get.snackbar('Task', 'successfuly $type');
      }).catchError((error) {
        Get.snackbar('Task', 'Error $type');
      });
    }
  }

  //delete task

  void deleteTask(String taskId) async {
    CollectionReference taskColl = firestore.collection('task');
    CollectionReference userColl = firestore.collection('users');

    await taskColl.doc(taskId).delete().whenComplete(() async {
      await userColl.doc(auth.currentUser!.email).set({
        'task_id': FieldValue.arrayRemove([taskId])
      }, SetOptions(merge: true));
      Get.back();
      Get.snackbar('Task', 'Sukses delete Task');
    });
  }
}
