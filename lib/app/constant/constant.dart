import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Constant extends GetxController {
  static final String REALTIME_DATABASE =
      'https://laporbook-9362d-default-rtdb.asia-southeast1.firebasedatabase.app/';

  static final String AKUN = 'akun.json';

  static final String LAPORAN = 'laporan.json';

  static snackbar(String title, String text, bool isSuccess) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: (isSuccess) ? Colors.green.shade400 : Colors.red,
      title: title,
      titleStyle: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
    );
  }
}
