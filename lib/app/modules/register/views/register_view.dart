import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_textfield.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: Get.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(50),
              Text(
                'REGISTER',
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
                  title: 'Nama',
                  controller: controller.namaC,
                  textKeyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  icons: false),
              const Gap(10),
              CustomTextField(
                  title: 'Email',
                  controller: controller.emailC,
                  textKeyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  icons: false),
              const Gap(10),
              CustomTextField(
                  title: 'No Handphone',
                  controller: controller.noHandphoneC,
                  textKeyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  icons: false),
              const Gap(10),
              Obx(() => CustomTextField(
                  title: 'Password',
                  controller: controller.passwordC,
                  textKeyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  obsecureText: controller.isShowPass.value,
                  onTap: () {
                    controller.changeIsShowPassOrConfPass(false);
                  },
                  icons: true)),
              const Gap(10),
              Obx(() => CustomTextField(
                  title: 'Confirmation Password',
                  controller: controller.confirmPasswordC,
                  textKeyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  obsecureText: controller.isShowConfPass.value,
                  onTap: () {
                    controller.changeIsShowPassOrConfPass(true);
                  },
                  icons: true)),
              const Gap(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                  child: InkWell(
                    onTap: () => controller.registerNewAccount(
                      controller.namaC.text,
                      controller.emailC.text,
                      controller.noHandphoneC.text,
                      controller.passwordC.text,
                      controller.confirmPasswordC.text,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          'Register',
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
                    "Already have an account?",
                    style: GoogleFonts.outfit(),
                  ),
                  const Gap(5),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.LOGIN),
                    child: Text(
                      "Login",
                      style: GoogleFonts.outfit(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    ));
  }
}
