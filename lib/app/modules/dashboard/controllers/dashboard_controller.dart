import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapor_buku/app/models/akun.dart';
import 'package:lapor_buku/app/models/laporan.dart';

import '../../../routes/app_pages.dart';
import '../../detail/views/detail_view.dart';
import '../views/dashboard_view.dart';

class DashboardController extends GetxController {
  // INFO: RXLIST
  var listLaporan = <Laporan>[].obs;
  var allLaporan = <Laporan>[].obs;
  var akun = <Akun>[].obs;

  var currentIndex = 0.obs;
  static var isLoading = false.obs;

  // INFO: Firebase settings
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Widget> widgetOptions = [
    // Semua laporan
    Column(
      children: [
        Container(
          color: Color.fromARGB(255, 244, 162, 97),
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Center(
              child: Text(
                'Lapor Book',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Obx(
            () => (isLoading.value)
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: Get.put(DashboardController()).allLaporan.length,
                    itemBuilder: (context, index) {
                      var data =
                          // ignore: invalid_use_of_protected_member
                          Get.find<DashboardController>().allLaporan[index];

                      return CustomTileDashboard(data: data);
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        )
      ],
    ),

    // Laporan saya
    Column(
      children: [
        Container(
          color: Color.fromARGB(255, 244, 162, 97),
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Center(
              child: Text(
                'Lapor Book',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Obx(
            () => (isLoading.value)
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 3,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        Get.put(DashboardController()).listLaporan.length,
                    itemBuilder: (context, index) {
                      var data =
                          // ignore: invalid_use_of_protected_member
                          Get.find<DashboardController>().listLaporan[index];

                      return CustomTileDashboard(data: data);
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        )
      ],
    ),

    // Profile
    Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Get.put(DashboardController()).akun[0].nama,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                    color: Color.fromARGB(255, 244, 162, 97),
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              Text(
                Get.put(DashboardController()).akun[0].role,
                style: GoogleFonts.outfit(
                  color: Color.fromARGB(255, 244, 162, 97),
                  fontSize: 25,
                ),
              ),
              const Gap(20),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: Get.put(DashboardController()).akun[0].noHP,
                ),
              ),
              const Gap(10),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: Get.put(DashboardController()).akun[0].email,
                ),
              ),
              const Gap(20),
              CustomButtonDetailLaporan(
                  title: 'LOGOUT',
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Get.offAllNamed(Routes.LOGIN);
                  })
            ],
          ),
        ))
  ];

  // Get laporan by uid
  getLaporanByUid() async {
    listLaporan.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('laporan')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .get();

      List<Map<String, dynamic>> data =
          await querySnapshot.docs.map((doc) => doc.data()).toList();

      data.forEach((element) {
        listLaporan.add(Laporan.fromJson(element));
      });

      isLoading.value = true;
      isLoading.refresh();
      listLaporan.refresh();
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  // Get all laporan from firestore
  getAllLaporan() async {
    allLaporan.clear();
    try {
      var documents = await _firestore.collection('laporan').get();

      List<Map<String, dynamic>> data =
          await documents.docs.map((e) => e.data()).toList();

      for (Map<String, dynamic> value in data) {
        allLaporan.add(Laporan.fromJson(value));
      }

      isLoading.value = true;
      isLoading.refresh();
      allLaporan.refresh();
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future initDataPengguna() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('akun')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((e) => e.data()).toList();

      print("Data nya nih bos ${data[0]}");
      akun.add(Akun.fromJson(data[0]));

      print(akun);
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  changeIndexBottomNavBar(int paramValue) {
    currentIndex.value = paramValue;
    currentIndex.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    initDataPengguna();
    getLaporanByUid();
    getAllLaporan();
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
