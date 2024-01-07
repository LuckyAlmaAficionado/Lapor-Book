// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapor_buku/app/models/laporan.dart';
import 'package:lapor_buku/app/modules/detail/controllers/detail_controller.dart';
import 'package:lapor_buku/app/routes/app_pages.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(DetailController()).alreadyLike.value = false;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 244, 162, 97),
        onPressed: () => Get.toNamed(Routes.LAPORAN),
        child: Icon(Icons.add),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child:
            Obx(() => controller.widgetOptions[controller.currentIndex.value]),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (value) {
              controller.changeIndexBottomNavBar(value);
            },
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 16,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: GoogleFonts.outfit(),
            unselectedLabelStyle: GoogleFonts.outfit(),
            backgroundColor: Color.fromARGB(255, 244, 162, 97),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Semua',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                label: 'Laporan Saya',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_3_outlined),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}

class CustomTileDashboard extends StatelessWidget {
  const CustomTileDashboard({
    super.key,
    required this.data,
  });

  final Laporan data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.offAllNamed(Routes.DETAIL, arguments: data.docId),
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Hero(
                tag: "${data.docId}image",
                child: Image.network(
                  data.gambar!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
            ),
            child: Text(
              data.judul,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 233, 196, 106),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(10)),
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      data.status.toUpperCase().split('.').last,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 162, 97),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(10)),
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      // DateFormat('d-MM-yyyy').format(data.tanggal),
                      data.like!.length.toString(),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
