import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sekolah_project/app/modules/dashboard/views/dashboard_view.dart';
import 'package:sekolah_project/app/utils/api.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
 
  final _getConnect = GetConnect();
  final authToken = GetStorage();
  final client = http.Client();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }

  void loginNow() async { //fungsi _loginNow() dengan deklarasi kata kunci async
    final response = await _getConnect.post(BaseUrl.auth, { //membuat variabel response yang dideklarasikan dengan kata kunci final, menggunakan fungsi _getConnect.post() untuk melakukan permintaan HTTP POST ke endpoint yang diberikan dalam konstanta BaseUrl.auth, dan mengirimkan email dan password yang dimasukkan pengguna dalam teks emailController dan passwordController. Respons HTTP disimpan dalam variabel response.
      'email': emailController.text, //mengirim email dari input emailController
      'password': passwordController.text, //mengirim password dari input passwordController
    });

    if (response.body['success'] == true) { //struktur if-else untuk menentukan tindakan yang harus diambil berdasarkan respons yang diterima dari permintaan HTTP. Jika nilai kunci success dalam response.body adalah true, maka aplikasi menulis token akses yang diperoleh dari respons ke penyimpanan lokal menggunakan authToken.write().
      authToken.write('token', response.body['access_token']); //menyimpan token akses ke penyimpanan lokal dengan menggunakan authToken.write()
      authToken.write('full_name', response.body['full_name']);
      Get.offAll(() => const DashboardView());
    } else { //Jika tidak, aplikasi menampilkan pesan kesalahan menggunakan Get.snackbar()
      Get.snackbar(
        'Error', //parameter pesan yang ditampilkan dalam snackbar
        response.body['message'].toString(), //mengambil pesan kesalahan dari nilai kunci message dalam response.body
        icon: const Icon(Icons.error), //ikon yang ditampilkan pada snackbar
        backgroundColor: Colors.red, //warna latar belakang snackbar
        colorText: Colors.white, //warna teks pada snackbar
        forwardAnimationCurve: Curves.bounceIn, //kurva animasi pada snackbar
        margin: const EdgeInsets.only( //mengatur margin pada snackbar
          top: 10,
          left: 5,
          right: 5,
        ),
      );
    }
  }

  // void loginNow() async {
  //   try {
  //     final response = await client.post(
  //         Uri.https('demo-elearning.smkassalaambandung.sch.id', 'api/login'),
  //         body: {
  //           'email': emailController.text,
  //           'password': passwordController.text,
  //         });

  //     if (response.statusCode == 200) {
  //       final jsonResponse = jsonDecode(response.body);
  //       if (jsonResponse['success'] == true) {
  //         authToken.write('token', jsonResponse['access_token']);
  //         // authToken.write('full_name', response.body['full_name']);
  //         Get.offAll(() => DashboardView());
  //       } else {
  //         Get.snackbar(
  //           'Error',
  //           jsonResponse['message'].toString(),
  //           icon: const Icon(Icons.error),
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //           forwardAnimationCurve: Curves.bounceIn,
  //           margin: const EdgeInsets.only(
  //             top: 10,
  //             left: 5,
  //             right: 5,
  //           ),
  //         );
  //       }
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Failed to login. Please try again.',
  //         icon: const Icon(Icons.error),
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         forwardAnimationCurve: Curves.bounceIn,
  //         margin: const EdgeInsets.only(
  //           top: 10,
  //           left: 5,
  //           right: 5,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Get.snackbar(
  //       'Error',
  //       'Failed to login. Please check your internet connection and try again.',
  //       icon: const Icon(Icons.error),
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       forwardAnimationCurve: Curves.bounceIn,
  //       margin: const EdgeInsets.only(
  //         top: 10,
  //         left: 5,
  //         right: 5,
  //       ),
  //     );
  //   } finally {
  //     client.close();
  //   }
  // }
}

