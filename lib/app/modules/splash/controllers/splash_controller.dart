import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  Future<bool> checkUserIsLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser);
      return true;
    } else {
      return false;
    }
  }

  Future splashScreenView() async {
    await Future.delayed(const Duration(seconds: 3));
    if (await checkUserIsLogin()) {
      Get.toNamed(Routes.DASHBOARD);
    } else {
      Get.toNamed(Routes.LOGIN);
    }
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
