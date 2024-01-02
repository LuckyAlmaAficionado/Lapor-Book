import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/laporan.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.setDocIdFromArgument(Get.arguments);
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 244, 162, 97),
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                child: Center(
                  child: Text(
                    'Detail Laporan',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: FutureBuilder(
                  future: controller.initDataLaporan(Get.arguments),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      Laporan data = snapshot.data!;

                      return Column(
                        children: [
                          const Gap(20),
                          Text(
                            data.judul,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Gap(20),
                          Container(
                            width: Get.width,
                            height: 170,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: Hero(
                              tag: 'dash',
                              child: Image.network(
                                data.gambar!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 244, 162, 97),
                                      ),
                                      color: Color.fromARGB(255, 42, 157, 143),
                                    ),
                                    child: Center(
                                      child: Obx(() => Text(
                                            controller.statusLaporan.value
                                                .toString()
                                                .split('.')
                                                .last,
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 244, 162, 97),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        data.instansi,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.outfit(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 40,
                              ),
                              const Gap(20),
                              Column(
                                children: [
                                  Text(
                                    'Nama Pelapor',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    data.nama,
                                    style: GoogleFonts.outfit(),
                                  ),
                                ],
                              ),
                              const Gap(70),
                            ],
                          ),
                          const Gap(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                                size: 40,
                              ),
                              const Gap(20),
                              Column(
                                children: [
                                  Text(
                                    'Tanggal Laporan',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('d MMMM yyyy')
                                        .format(data.tanggal),
                                    style: GoogleFonts.outfit(),
                                  ),
                                ],
                              ),
                              const Gap(30),
                              GestureDetector(
                                onTap: () => data.maps,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.add_location,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    Text(
                                      'Kordinat',
                                      style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(40),
                          Text(
                            'Deskripsi Laporan',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              data.deskripsi!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(),
                            ),
                          ),
                          const Gap(25),
                          CustomButtonDetailLaporan(
                            title: 'Ubah Status',
                            onTap: () => controller.dialogStatusLaporan(
                                controller.convertStringToEnum(data.status),
                                data.docId),
                          ),
                          const Gap(15),
                          CustomButtonDetailLaporan(
                            title: 'Tambah Komentar',
                            onTap: () => controller.tambahKomentar(data.docId),
                          ),
                          const Gap(40),
                          Text(
                            'List Komentar',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() => (controller.listKomentar.length == 0)
                              ? Container(
                                  height: Get.height * 0.2,
                                  child: Center(
                                    child: Text(
                                      "Tidak Ada Komentar",
                                      style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: Get.height * 0.8,
                                  child: ListView.builder(
                                    itemCount: controller.listKomentar.length,
                                    padding: const EdgeInsets.all(20.0),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        TileKomentarDetail(
                                            komentar:
                                                controller.listKomentar[index],
                                            index: index),
                                  ),
                                ))
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TileKomentarDetail extends StatelessWidget {
  const TileKomentarDetail({
    super.key,
    required this.komentar,
    required this.index,
  });

  final Komentar komentar;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 244, 162, 97),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            komentar.nama,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const Gap(10),
          Text(
            komentar.isi,
            style: GoogleFonts.outfit(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButtonDetailLaporan extends StatelessWidget {
  const CustomButtonDetailLaporan({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Material(
        color: Color.fromARGB(255, 244, 162, 97),
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
