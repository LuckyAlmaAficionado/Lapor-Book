import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FireStorageC extends GetxController {
  sendImageToStorage(XFile image) async {
    try {
      // set file name
      String fileName = image.path.split('/').last;

      // set ref storage
      Reference storageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');

      // send image to firebase storage
      await storageRef.putFile(File(image.path));

      // get url download
      var urlDownload = await storageRef.getDownloadURL();
      return urlDownload;
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
