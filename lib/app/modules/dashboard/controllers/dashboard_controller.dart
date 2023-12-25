import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapor_buku/app/models/laporan.dart';

import '../views/dashboard_view.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  var listLaporan = <Laporan>[].obs;

  var widgetOptions = <Widget>[
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
          child: Obx(() => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: Get.put(DashboardController()).listLaporan.length,
                itemBuilder: (context, index) {
                  var data =
                      // ignore: invalid_use_of_protected_member
                      Get.find<DashboardController>().listLaporan.value[index];
                  print(data);
                  return CustomTileDashboard(data: data);
                },
              )),
        ),
      ],
    ),
    Center(
      child: Text(
        'Coming Soon',
        style: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    Center(
      child: Text(
        'Coming Soon',
        style: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getLaporanByUid() async {
    listLaporan.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('laporan')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      data.forEach((element) {
        print(element);
        listLaporan.add(Laporan.fromJson(element));
      });

      listLaporan.refresh();
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
    getLaporanByUid();
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
