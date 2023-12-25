import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapor_buku/app/models/laporan.dart';
import 'package:lapor_buku/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:lapor_buku/app/modules/detail/views/detail_view.dart';

class DetailController extends GetxController {
  var docId = ''.obs;
  TextEditingController komentarC = TextEditingController();
  Rx<Status> statusLaporan = Status.Done.obs;
  Rx<Status> tempStatusLaporan = Status.Done.obs;
  var listKomentar = <Komentar>[].obs;

  setDocIdFromArgument(String pArgument) {
    docId.value = pArgument;
  }

  tambahKomentar(String docId) {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        title: 'Tambah Komentar',
        titleStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        content: Column(
          children: [
            TextField(
              style: GoogleFonts.outfit(
                fontSize: 16,
              ),
              controller: komentarC,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              )),
            ),
            const Gap(15),
            Material(
              color: Color.fromARGB(255, 244, 162, 97),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () => addKomentar(komentarC.text, docId),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Center(
                    child: Text(
                      'Kirim Komentar',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Laporan> initDataLaporan(String pArgument) async {
    setDocIdFromArgument(pArgument);

    try {
      Laporan? laporan;
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('laporan')
          .where('docId', isEqualTo: docId.value)
          .get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((e) => e.data()).toList();

      data.forEach((element) {
        laporan = Laporan.fromJson(element);
      });

      if (laporan!.komentar != null) {
        listKomentar.value = laporan!.komentar!;
      }
      statusLaporan.value = convertStringToEnum(laporan!.status);
      tempStatusLaporan.value = statusLaporan.value;
      return laporan!;
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Status convertStringToEnum(String statusString) {
    Status? status;
    switch (statusString) {
      case 'Status.Process':
        status = Status.Process;
        break;
      case 'Status.Posted':
        status = Status.Posted;
        break;
      case 'Status.Done':
        status = Status.Done;
        break;
      default:
        break;
    }

    return status!;
  }

  dialogStatusLaporan(Status status, String docId) {
    statusLaporan.value = status;
    Get.defaultDialog(
      onWillPop: () async {
        tempStatusLaporan.value = statusLaporan.value;
        return true;
      },
      titlePadding: const EdgeInsets.only(top: 15),
      title: "Judul Laporan",
      titleStyle: GoogleFonts.outfit(
        fontWeight: FontWeight.w600,
      ),
      content: Obx(
        () => Column(
          children: [
            ListTile(
              title: Text(
                'Process',
                style: GoogleFonts.outfit(),
              ),
              leading: Radio<Status>(
                value: Status.Process,
                groupValue: tempStatusLaporan.value,
                onChanged: (value) {
                  tempStatusLaporan.value = value!;
                },
              ),
            ),
            ListTile(
              title: Text(
                'Posted',
                style: GoogleFonts.outfit(),
              ),
              leading: Radio<Status>(
                value: Status.Posted,
                groupValue: tempStatusLaporan.value,
                onChanged: (value) {
                  tempStatusLaporan.value = value!;
                },
              ),
            ),
            ListTile(
              title: Text(
                'Done',
                style: GoogleFonts.outfit(),
              ),
              leading: Radio<Status>(
                value: Status.Done,
                groupValue: tempStatusLaporan.value,
                onChanged: (value) {
                  tempStatusLaporan.value = value!;
                },
              ),
            ),
            const Gap(20),
            CustomButtonDetailLaporan(
              title: 'Simpan Status',
              onTap: () => changeStatusLaporan(tempStatusLaporan.value, docId),
            )
          ],
        ),
      ),
    );
  }

  var _auth = FirebaseAuth.instance;

  addKomentar(String komentar, String docId) async {
    final laporan = _firestore.collection('laporan').doc(docId);
    // ignore: invalid_use_of_protected_member
    listKomentar.value
        .add(Komentar(nama: _auth.currentUser!.displayName!, isi: komentar));

    laporan.update({
      // ignore: invalid_use_of_protected_member
      "komentar": listKomentar.value.map((e) => e.toJson()).toList(),
    }).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (error) => print('Error updating document $error'),
    );

    komentarC.text = '';
    listKomentar.refresh();
    Get.back();
  }

  changeStatusLaporan(Status pStatusLaporan, String docId) async {
    final laporan = _firestore.collection('laporan').doc(docId);

    statusLaporan.value = pStatusLaporan;

    laporan.update({
      "status": statusLaporan.toString(),
    }).then(
      (value) => print('DoucmentSnapshot successfully updated!'),
      onError: (error) => print('Error updateing document $error'),
    );

    Get.put(DashboardController()).getLaporanByUid();
    Get.back();
  }

  final count = 0.obs;
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

  void increment() => count.value++;
}
