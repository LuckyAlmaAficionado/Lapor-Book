import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lapor_buku/app/constant/constant.dart';
import 'package:lapor_buku/app/controller/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lapor_buku/app/controller/locator.dart';
import 'package:lapor_buku/app/controller/storage.dart';
import 'package:lapor_buku/app/models/laporan.dart';
import 'package:lapor_buku/app/routes/app_pages.dart';

class LaporanController extends GetxController {
  late TextEditingController judulLaporanC;
  late TextEditingController pathFotoPendukungC;
  late TextEditingController deskripsiLengkapC;
  late String instansiC;
  XFile? pickImage;

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> dropdownListValue = [
    "Instansi Perusahaan One",
    "Instansi Perusahaan Two",
    "Instansi Perusahaan Three",
    "Instansi Perusahaan Four",
    "Instansi Perusahaan Five",
  ];
  var dropdownValue = ''.obs;

  imagePickerFromCamera() async {
    pickImage = await CustomImagePicker.pickImageFrom(ImageSource.camera);
    pathFotoPendukungC.text = pickImage!.path.split('/').last;
  }

  addNewLaporan(String pJudul, String pInstansi, String pDeskripsi) async {
    try {
      Constant.snackbar('Loading', "Jangan keluar dari halaman", true);
      CollectionReference ref = _db.collection('laporan');

      final docId = ref.doc().id;

      String currentLocation = await GeolocatorC.getCurrentLocation()
          .then((value) => '${value.latitude},${value.longitude}');

      String maps = 'https://www.google.com/maps/place/$currentLocation';
      var storage = Get.put(FireStorageC());

      String urlImage = await storage.sendImageToStorage(pickImage!);

      Laporan laporan = Laporan(
        uid: _auth.currentUser!.uid,
        docId: docId,
        judul: pJudul,
        instansi: pInstansi,
        nama: _auth.currentUser!.displayName!,
        status: Status.Process.toString(),
        tanggal: DateTime.now(),
        maps: maps,
        deskripsi: pDeskripsi,
        gambar: urlImage,
      );

      await ref.doc(docId).set(laporan.toJson()).onError(
          (error, stackTrace) => print('Error writing document: $error'));

      Get.back();
      Get.offAllNamed(Routes.DASHBOARD);
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  changeDropdownValue(String paramValue) {
    dropdownValue.value = paramValue;
    dropdownValue.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    judulLaporanC = TextEditingController();
    deskripsiLengkapC = TextEditingController();
    pathFotoPendukungC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pathFotoPendukungC.dispose();
    deskripsiLengkapC.dispose();
    judulLaporanC.dispose();
    super.onClose();
  }
}
