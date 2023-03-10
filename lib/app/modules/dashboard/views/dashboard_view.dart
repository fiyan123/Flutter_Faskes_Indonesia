// import 'dart:js';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:sekolah_project/app/data/covid_response.dart';
import 'package:sekolah_project/app/data/entertainment_response.dart';
import 'package:sekolah_project/app/data/faskes_bogor_response.dart';
import 'package:sekolah_project/app/data/faskes_ciamis_response.dart';
import 'package:sekolah_project/app/data/faskes_kota_bandung_response.dart';
import 'package:sekolah_project/app/data/faskes_kota_bogor_response.dart';
import 'package:sekolah_project/app/data/headline_response.dart';
import 'package:sekolah_project/app/data/sports_response.dart';
import 'package:sekolah_project/app/data/technology_response.dart';
import 'package:sekolah_project/app/modules/home/views/home_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();
    final auth = GetStorage();
    return SafeArea(
      child: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: Column(
              children: [
                ListTile(
                  title: Text("Hallo", textAlign: TextAlign.end),
                  subtitle: Text(
                    // auth.read('full_name').toString(),
                    "Muhammad Sofyan",
                    textAlign: TextAlign.end,
                  ),

                  trailing: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 50.0,
                    height: 50.0,
                    child: ClipOval(
                      child: Image.asset("assets/images/edub.jpg"),
                    ),
                  ),
                ),

                const Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: "Faskes Vaksinasi Kab.Bandung"),
                      Tab(text: "Faskes Vaksinasi Kota Bandung"),
                      Tab(text: "Faskes Vaksinasi Kab.Bogor"),
                      Tab(text: "Faskes Vaksinasi Kota Bogor"),
                      Tab(text: "Faskes Vaksinasi Kab.Ciamis"),
                      // Tab(text: "Headline"),
                      // Tab(text: "Teknologi"),
                      Tab(text: "Olahraga"),
                      // Tab(text: "Hiburan"),
                      Tab(text: "Profile Me"),
                    ],
                  ),
                ),
              ],
            ), 
          ),

          body: TabBarView(
            children: [
              // Properti children digunakan untuk menentukan konten yang akan ditampilkan pada masing-masing tab.
              covid(controller, scrollController),
              kotaBandung(controller, scrollController),
              covidBogor(controller, scrollController),
              kotaBogor(controller, scrollController),
              kabCiamis(controller, scrollController),
              // headline(controller, scrollController),
              // teknologi(controller, scrollController),
              olahraga(controller, scrollController),
              // entertainment(controller, scrollController),
              profile(),
            ],
          ),

          // Logout
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await auth.erase();
              Get.offAll(() => const HomeView());
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.refresh_outlined),
          ),
        )
      ), 
    );  
  }


// Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
FutureBuilder<covidResponse> covid(DashboardController controller, ScrollController scrollController) {
  return FutureBuilder<covidResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getCovid(),
    builder: (context, snapshot) {
      print(snapshot.data);
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
    
      //da data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }

      // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
      return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Tampilan untuk setiap item headline dalam ListView.Builder
          return Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 260,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Container(
                        child: Container(
                          width: 900,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ListBody(
                                children: [
                                  Center(
                                    child: Text(
                                      snapshot.data!.data![index].nama.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kode Faskes : ${snapshot.data!.data![index].kode}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kota / Kabupaten : ${snapshot.data!.data![index].kota}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Provinsi : ${snapshot.data!.data![index].provinsi}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Jenis Faskes : ${snapshot.data!.data![index].jenisFaskes}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No Telepon : ${snapshot.data!.data![index].telp}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Status Faskes : ${snapshot.data!.data![index].status}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Alamat Faskes : ${snapshot.data!.data![index].alamat}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
FutureBuilder<kotaBandungResponse> kotaBandung(DashboardController controller, ScrollController scrollController) {
  return FutureBuilder<kotaBandungResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getKotaBandung(),
    builder: (context, snapshot) {
      print(snapshot.data);
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
    
      //da data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }

      // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
      return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Tampilan untuk setiap item headline dalam ListView.Builder
          return Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 260,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Container(
                        child: Container(
                          width: 900,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ListBody(
                                children: [
                                  Center(
                                    child: Text(
                                      snapshot.data!.data![index].nama.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kode Faskes : ${snapshot.data!.data![index].kode}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kota / Kabupaten : ${snapshot.data!.data![index].kota}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Provinsi : ${snapshot.data!.data![index].provinsi}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Jenis Faskes : ${snapshot.data!.data![index].jenisFaskes}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No Telepon : ${snapshot.data!.data![index].telp}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Status Faskes : ${snapshot.data!.data![index].status}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Alamat Faskes : ${snapshot.data!.data![index].alamat}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
FutureBuilder<faskesBogorResponse> covidBogor(DashboardController controller, ScrollController scrollController) {
  return FutureBuilder<faskesBogorResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getFaskesBogor(),
    builder: (context, snapshot) {
      print(snapshot.data);
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
    
      //da data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }

      // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
      return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Tampilan untuk setiap item headline dalam ListView.Builder
          return Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 260,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Container(
                        child: Container(
                          width: 900,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ListBody(
                                children: [
                                  Center(
                                    child: Text(
                                      snapshot.data!.data![index].nama.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kode Faskes : ${snapshot.data!.data![index].kode}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kota / Kabupaten : ${snapshot.data!.data![index].kota}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Provinsi : ${snapshot.data!.data![index].provinsi}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Jenis Faskes : ${snapshot.data!.data![index].jenisFaskes}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No Telepon : ${snapshot.data!.data![index].telp}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Status Faskes : ${snapshot.data!.data![index].status}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Alamat Faskes : ${snapshot.data!.data![index].alamat}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
FutureBuilder<kotaBogorResponse> kotaBogor(DashboardController controller, ScrollController scrollController) {
  return FutureBuilder<kotaBogorResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getFaskesKotaBogor(),
    builder: (context, snapshot) {
      print(snapshot.data);
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
    
      //da data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }

      // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
      return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Tampilan untuk setiap item headline dalam ListView.Builder
          return Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 260,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                     Container(
                        child: Container(
                          width: 900,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ListBody(
                                children: [
                                  Center(
                                    child: Text(
                                      snapshot.data!.data![index].nama.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kode Faskes : ${snapshot.data!.data![index].kode}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kota / Kabupaten : ${snapshot.data!.data![index].kota}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Provinsi : ${snapshot.data!.data![index].provinsi}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Jenis Faskes : ${snapshot.data!.data![index].jenisFaskes}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No Telepon : ${snapshot.data!.data![index].telp}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Status Faskes : ${snapshot.data!.data![index].status}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Alamat Faskes : ${snapshot.data!.data![index].alamat}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
FutureBuilder<kabCiamisResponse> kabCiamis(DashboardController controller, ScrollController scrollController) {
  return FutureBuilder<kabCiamisResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getFaskesCiamis(),
    builder: (context, snapshot) {
      print(snapshot.data);
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
    
      //da data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }

      // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
      return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Tampilan untuk setiap item headline dalam ListView.Builder
          return Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 260,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Container(
                        child: Container(
                          width: 900,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ListBody(
                                children: [
                                  Center(
                                    child: Text(
                                      snapshot.data!.data![index].nama.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kode Faskes : ${snapshot.data!.data![index].kode}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kota / Kabupaten : ${snapshot.data!.data![index].kota}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Provinsi : ${snapshot.data!.data![index].provinsi}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Jenis Faskes : ${snapshot.data!.data![index].jenisFaskes}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No Telepon : ${snapshot.data!.data![index].telp}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Status Faskes : ${snapshot.data!.data![index].status}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Alamat Faskes : ${snapshot.data!.data![index].alamat}'.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
// FutureBuilder<headlineResponse> headline(DashboardController controller, ScrollController scrollController) {
//   return FutureBuilder<headlineResponse>(
//     // Mendapatkan future data headline dari controller
//     future: controller.getHeadline(),
//     builder: (context, snapshot) {
//       // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: Lottie.network(
//             // Menggunakan animasi Lottie untuk tampilan loading
//             'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
//             repeat: true,
//             width: MediaQuery.of(context).size.width / 1,
//           ),
//         );
//       }
//       // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
//       if (!snapshot.hasData) {
//         return const Center(child: Text("Tidak ada data"));
//       }

//       // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
//       return ListView.builder(
//         itemCount: snapshot.data!.data!.length,
//         controller: scrollController,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           // Tampilan untuk setiap item headline dalam ListView.Builder
//           return Container(
//             padding: const EdgeInsets.only(
//               top: 5,
//               left: 8,
//               right: 8,
//               bottom: 5,
//             ),
//             height: 110,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Image.network(
//                     snapshot.data!.data![index].urlToImage.toString(),
//                     height: 130,
//                     width: 130,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
//                       Text(
//                         snapshot.data!.data![index].title.toString(),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                       ),
//                       const SizedBox(
//                         height: 2,
//                       ),
//                       // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Author : ${snapshot.data!.data![index].author}'),
//                           Text('Sumber :${snapshot.data!.data![index].name}'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// FutureBuilder<technologyResponse> teknologi(DashboardController controller, ScrollController scrollController) {
//   return FutureBuilder<technologyResponse>(
//     // Mendapatkan future data headline dari controller
//     future: controller.getTechnology(),
//     builder: (context, snapshot) {
//       // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: Lottie.network(
//             // Menggunakan animasi Lottie untuk tampilan loading
//             'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
//             repeat: true,
//             width: MediaQuery.of(context).size.width / 1,
//           ),
//         );
//       }
//       // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
//       if (!snapshot.hasData) {
//         return const Center(child: Text("Tidak ada data"));
//       }

//       // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
//       return ListView.builder(
//         itemCount: snapshot.data!.data!.length,
//         controller: scrollController,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           // Tampilan untuk setiap item headline dalam ListView.Builder
//           return Container(
//             padding: const EdgeInsets.only(
//               top: 5,
//               left: 8,
//               right: 8,
//               bottom: 5,
//             ),
//             height: 110,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Image.network(
//                     snapshot.data!.data![index].urlToImage.toString(),
//                     height: 130,
//                     width: 130,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
//                       Text(
//                         snapshot.data!.data![index].title.toString(),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                       ),
//                       const SizedBox(
//                         height: 2,
//                       ),
//                       // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Author : ${snapshot.data!.data![index].author}'),
//                           Text('Sumber :${snapshot.data!.data![index].name}'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }


FutureBuilder<sportsResponse> olahraga(DashboardController controller, ScrollController scrollController) {
  return FutureBuilder<sportsResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getSports(),
    builder: (context, snapshot) {
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
      // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }

      // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
      return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Tampilan untuk setiap item headline dalam ListView.Builder
          return Container(
            padding: const EdgeInsets.only(
              top: 5,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    snapshot.data!.data![index].urlToImage.toString(),
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Text(
                        snapshot.data!.data![index].title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Author : ${snapshot.data!.data![index].author}'),
                          Text('Sumber :${snapshot.data!.data![index].name}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// FutureBuilder<entertainmentResponse> entertainment(DashboardController controller, ScrollController scrollController) {
//   return FutureBuilder<entertainmentResponse>(
//     // Mendapatkan future data headline dari controller
//     future: controller.getEntertainment(),
//     builder: (context, snapshot) {
//       // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: Lottie.network(
//             // Menggunakan animasi Lottie untuk tampilan loading
//             'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
//             repeat: true,
//             width: MediaQuery.of(context).size.width / 1,
//           ),
//         );
//       }
//       // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
//       if (!snapshot.hasData) {
//         return const Center(child: Text("Tidak ada data"));
//       }

//       // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
//       return ListView.builder(
//         itemCount: snapshot.data!.data!.length,
//         controller: scrollController,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           // Tampilan untuk setiap item headline dalam ListView.Builder
//           return Container(
//             padding: const EdgeInsets.only(
//               top: 5,
//               left: 8,
//               right: 8,
//               bottom: 5,
//             ),
//             height: 110,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Image.network(
//                     snapshot.data!.data![index].urlToImage.toString(),
//                     height: 130,
//                     width: 130,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
//                       Text(
//                         snapshot.data!.data![index].title.toString(),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                       ),
//                       const SizedBox(
//                         height: 2,
//                       ),
//                       // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Author : ${snapshot.data!.data![index].author}'),
//                           Text('Sumber :${snapshot.data!.data![index].name}'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }

profile() {
    final auth = GetStorage();
    return Scaffold(
        body: ListView(physics: BouncingScrollPhysics(), children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    'assets/images/edub.jpg',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Nama',
            ),
            const SizedBox(height: 10),
            Text(
              // auth.read('full_name').toString(),
              "Muhammad Sofyan"
            ),
            // const SizedBox(height: 16),
            Divider(),
            Text(
              'Email',
            ),
            const SizedBox(height: 10),
            Text('sofyan_208@smkassalaambandung.sch.id'),
            // auth.read('email'),
            Divider(),
            Text(
              'Deskripsi',
            ),
            const SizedBox(height: 10),
            Text(
                'Halo Saya Sofyan, Saya Tinggal Dibandung, Saat Ini Saya Bersekolah Di Smk Assalaam Bandung, Dengan Jurusan Rekayasa Perangkat Lunak'),
            Divider(),
          ])),
        const SizedBox(height: 60),
        Center(child: Text('Ikuti Saya')),
        SizedBox(
          height: 20,
        ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/25/25231.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ClipOval(
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/2048px-Facebook_f_logo_%282019%29.svg.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              ClipOval(
                child: Image.network(
                  'https://png.pngtree.com/png-vector/20221018/ourmid/pngtree-instagram-icon-png-image_6315974.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      )
    ]));
  }
}
