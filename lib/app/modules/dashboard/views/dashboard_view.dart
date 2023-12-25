// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lapor_buku/app/models/laporan.dart';
import 'package:lapor_buku/app/routes/app_pages.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 244, 162, 97),
        onPressed: () => Get.toNamed(Routes.LAPORAN),
        child: Icon(Icons.add),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Obx(() {
          // Gunakan widgetOptions sebagai observable list di dalam Obx
          return controller.widgetOptions.value[controller.currentIndex.value];
        }),
        // child:
        // controller.widgetOptions.elementAt(controller.currentIndex.value),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (value) {
              controller.changeIndexBottomNavBar(value);
            },
            selectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 16,
            unselectedItemColor: Colors.white,
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
      onTap: () => Get.toNamed(Routes.DETAIL, arguments: data.docId),
      child: Container(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: 100,
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
                child: Image.network(
                  data.gambar!,
                  fit: BoxFit.fill,
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
                        DateFormat('d-MM-yyyy').format(data.tanggal),
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
      ),
      // child: Container(
      //   margin: const EdgeInsets.symmetric(vertical: 20),
      //   height: 100,
      //   width: Get.width,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(10),
      //     boxShadow: [
      //       BoxShadow(
      //         offset: Offset(4, 0),
      //         color: Colors.grey.shade200,
      //         spreadRadius: 3,
      //         blurRadius: 3,
      //       )
      //     ],
      //   ),
      //   child: Column(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(10),
      //             topRight: Radius.circular(10),
      //           ),
      //           border: Border.all(
      //             width: 1,
      //             color: Colors.black,
      //           ),
      //         ),
      //         height: 100,
      //         width: Get.width,
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(10),
      //             topRight: Radius.circular(10),
      //           ),
      //           child: Image.network(
      //             data.gambar.toString(),
      //             fit: BoxFit.fill,
      //           ),
      //         ),
      //       ),
      //       Container(
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             width: 1,
      //             color: Colors.black,
      //           ),
      //         ),
      //         height: 50,
      //         width: Get.width,
      //         child: Center(
      //           child: Text(
      //             data.judul.toUpperCase(),
      //             style: GoogleFonts.outfit(
      //               fontWeight: FontWeight.w600,
      //             ),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       ),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: Material(
      //               color: Color.fromARGB(255, 233, 196, 106),
      //               borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(10),
      //               ),
      //               child: InkWell(
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.only(
      //                       bottomLeft: Radius.circular(10),
      //                     ),
      //                     border: Border.all(
      //                       width: 1,
      //                       color: Colors.black,
      //                     ),
      //                   ),
      //                   width: Get.width,
      //                   padding: const EdgeInsets.all(15),
      //                   child: Text(
      //                     data.status.toUpperCase().split('.').last,
      //                     style: GoogleFonts.outfit(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                     textAlign: TextAlign.center,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Expanded(
      //             child: Material(
      //               color: Color.fromARGB(255, 244, 162, 97),
      //               borderRadius: BorderRadius.only(
      //                 bottomRight: Radius.circular(10),
      //               ),
      //               child: InkWell(
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.only(
      //                       bottomRight: Radius.circular(10),
      //                     ),
      //                     border: Border.all(
      //                       width: 1,
      //                       color: Colors.black,
      //                     ),
      //                   ),
      //                   width: Get.width,
      //                   padding: const EdgeInsets.all(15),
      //                   child: Text(
      //                     DateFormat('d-MM-yyyy').format(data.tanggal),
      //                     style: GoogleFonts.outfit(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                     textAlign: TextAlign.center,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
