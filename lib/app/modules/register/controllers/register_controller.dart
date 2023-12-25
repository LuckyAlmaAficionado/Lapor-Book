import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_buku/app/constant/constant.dart';
import 'package:lapor_buku/app/models/akun.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController extends GetxController {
  late TextEditingController namaC;
  late TextEditingController emailC;
  late TextEditingController noHandphoneC;
  late TextEditingController passwordC;
  late TextEditingController confirmPasswordC;

  var isShowPass = true.obs;
  var isShowConfPass = true.obs;

  changeIsShowPassOrConfPass(bool paramOptions) {
    if (paramOptions) {
      isShowConfPass.value = !isShowConfPass.value;
      isShowConfPass.refresh();
    } else {
      isShowPass.value = !isShowPass.value;
      isShowPass.refresh();
    }
  }

  registerNewAccount(
    String nama,
    String email,
    String noHandphone,
    String password,
    String confPassword,
  ) {
    if (isAnyFieldEmpty(
      nama,
      email,
      noHandphone,
      password,
      confPassword,
    )) {
      Constant.snackbar('Oh Snap!', 'Isi semua field yang kosong', false);
      return;
    } else if (validatorEmail(email)) {
      Constant.snackbar('Oh Snap!', 'Format email salah', false);
      return;
    } else if (validatorPassAndConfPass(password, confPassword)) {
      Constant.snackbar(
          'Oh Snap!', 'Password dan Confirm Password tidak sama', false);
      return;
    } else {
      createNewAccountRealtimeDatabase(nama, email, noHandphone, password);
    }
  }

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  createNewAccountRealtimeDatabase(
    String nama,
    String email,
    String noHp,
    String password,
  ) async {
    try {
      CollectionReference akunCollection = _db.collection('akun');

      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = credential.user;
      await user?.updateDisplayName(nama);
      await user?.updateEmail(email);

      final docId = akunCollection.doc().id;

      Akun akun = Akun(
          uid: _auth.currentUser!.uid,
          docId: docId,
          nama: nama,
          noHP: noHp,
          email: email,
          role: 'user');

      await akunCollection.doc(docId).set(akun.toJson()).onError(
          (error, stackTrace) => print('Error writing document: $error'));
    } catch (e) {
      throw e;
    }
  }

  bool validatorPassAndConfPass(String password, String confPassword) {
    if (!password.contains(confPassword) || !confPassword.contains(password))
      return true;
    return false;
  }

  bool isAnyFieldEmpty(String nama, String email, String noHandphone,
      String password, String confPassword) {
    return (nama.isEmpty ||
        email.isEmpty ||
        noHandphone.isEmpty ||
        password.isEmpty ||
        confPassword.isEmpty);
  }

  validatorEmail(String email) {
    if (email.isEmail) return false;
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    namaC = TextEditingController();
    emailC = TextEditingController();
    noHandphoneC = TextEditingController();
    passwordC = TextEditingController();
    confirmPasswordC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namaC.dispose();
    emailC.dispose();
    noHandphoneC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
    super.onClose();
  }
}
