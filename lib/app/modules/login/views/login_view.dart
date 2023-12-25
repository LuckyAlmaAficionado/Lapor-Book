import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(50),
            Text(
              'LOGIN',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const Gap(10),
            Text(
              'Create your profile to start your journey',
              style: GoogleFonts.outfit(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const Gap(50),
            CustomTextField(
              title: 'Email',
              controller: controller.emailC,
              textInputAction: TextInputAction.next,
              textKeyboardType: TextInputType.emailAddress,
              icons: false,
            ),
            const Gap(20),
            Obx(() => CustomTextField(
                  title: 'Password',
                  controller: controller.passwordC,
                  textKeyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  icons: true,
                  obsecureText: controller.isShowPass.value,
                  onTap: () {
                    controller.changeIsShowPass();
                  },
                )),
            const Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange,
                child: InkWell(
                  onTap: () => controller.signInUserWithEmailAndPassword(
                    controller.emailC.text,
                    controller.passwordC.text,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'LOGIN',
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
            const Gap(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.outfit(),
                ),
                const Gap(5),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.REGISTER),
                  child: Text(
                    "Register",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
