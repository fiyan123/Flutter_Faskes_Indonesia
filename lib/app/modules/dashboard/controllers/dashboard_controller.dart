import 'dart:convert';

import 'package:get/get.dart';
import 'package:sekolah_project/app/data/covid_response.dart';
import 'package:sekolah_project/app/data/entertainment_response.dart';
import 'package:sekolah_project/app/data/faskes_bogor_response.dart';
import 'package:sekolah_project/app/data/faskes_ciamis_response.dart';
import 'package:sekolah_project/app/data/faskes_kota_bandung_response.dart';
import 'package:sekolah_project/app/data/faskes_kota_bogor_response.dart';
import 'package:sekolah_project/app/data/headline_response.dart';
import 'package:sekolah_project/app/data/sports_response.dart';
import 'package:sekolah_project/app/data/technology_response.dart';
import 'package:sekolah_project/app/utils/api.dart';

class DashboardController extends GetxController {

  final _getConnect = GetConnect();

  Future<headlineResponse> getHeadline() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.headline);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return headlineResponse.fromJson(jsonDecode(response.body));
  }

  Future<technologyResponse> getTechnology() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.technology);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return technologyResponse.fromJson(jsonDecode(response.body));
  }

  Future<sportsResponse> getSports() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.sports);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return sportsResponse.fromJson(jsonDecode(response.body));
  }

  Future<entertainmentResponse> getEntertainment() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.entertainment);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return entertainmentResponse.fromJson(jsonDecode(response.body));
  }

  Future<covidResponse> getCovid() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.covid);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return covidResponse.fromJson((response.body));
  }

  Future<kotaBandungResponse> getKotaBandung() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.kotaBandung);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return kotaBandungResponse.fromJson((response.body));
  }

  Future<faskesBogorResponse> getFaskesBogor() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.covidBogor);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return faskesBogorResponse.fromJson((response.body));
  }

  Future<kotaBogorResponse> getFaskesKotaBogor() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.kotaBogor);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return kotaBogorResponse.fromJson((response.body));
  }

  Future<kabCiamisResponse> getFaskesCiamis() async {
    //memanggil fungsi getConnect untuk melakukan request ke BaseUrl.headline
    final response = await _getConnect.get(BaseUrl.kabCiamis);
    //mengembalikan data response dalam bentuk HeadlineResponse setelah di-decode dari JSON
    return kabCiamisResponse.fromJson((response.body));
  }

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
    super.onClose();
  }
  
}
