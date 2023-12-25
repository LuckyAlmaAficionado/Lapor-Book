// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.textKeyboardType,
    required this.textInputAction,
    required this.icons,
    this.isCenter = false,
    this.iconsData = Icons.remove_red_eye,
    this.obsecureText = false,
    this.onTap,
  });

  bool isCenter;
  final String title;
  final TextInputType textKeyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final IconData iconsData;
  final bool icons;
  bool obsecureText;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment:
            (isCenter) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(5),
          TextField(
            controller: controller,
            keyboardType: textKeyboardType,
            textInputAction: textInputAction,
            obscureText: obsecureText,
            style: GoogleFonts.outfit(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 10,
              ),
              suffixIcon: (icons)
                  ? GestureDetector(
                      onTap: onTap,
                      child: Icon(
                        iconsData,
                        color: Colors.orange,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
