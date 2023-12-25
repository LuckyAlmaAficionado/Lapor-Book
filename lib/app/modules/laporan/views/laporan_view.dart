import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/custom_textfield.dart';
import '../controllers/laporan_controller.dart';

class LaporanView extends GetView<LaporanController> {
  const LaporanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.orange,
            padding: const EdgeInsets.all(10),
            child: SafeArea(
              child: Center(
                child: Text(
                  'Tambah Laporan',
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
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const Gap(50),
                  CustomTextField(
                    title: 'Judul Laporan',
                    controller: controller.judulLaporanC,
                    textKeyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    icons: false,
                    isCenter: true,
                  ),
                  const Gap(15),
                  CustomTextField(
                    title: 'Foto Pendukung',
                    controller: controller.pathFotoPendukungC,
                    textKeyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    icons: true,
                    iconsData: Icons.camera_alt_rounded,
                    isCenter: true,
                    onTap: () => controller.imagePickerFromCamera(),
                  ),
                  const Gap(15),
                  Text(
                    'Instansi',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 10,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      iconEnabledColor: Colors.orange,
                      dropdownColor: Colors.white,
                      items: controller.dropdownListValue
                          .map((e) => DropdownMenuItem(
                                child: Text(
                                  e,
                                  style: GoogleFonts.outfit(
                                    fontSize: 15,
                                  ),
                                ),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        print(value);
                        controller.instansiC = value!;
                      },
                      isExpanded: true,
                    ),
                  ),
                  const Gap(15),
                  Text(
                    'Deskripsi Lengkap',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                      ),
                      controller: controller.deskripsiLengkapC,
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange,
                      child: InkWell(
                        onTap: () => controller.addNewLaporan(
                          controller.judulLaporanC.text,
                          controller.instansiC,
                          controller.deskripsiLengkapC.text,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              'Kirim Laporan',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
