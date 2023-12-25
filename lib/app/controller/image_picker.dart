import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends GetxController {
  // pick image and return
  static Future<XFile?> pickImageFrom(ImageSource source) async {
    final imagePick = await ImagePicker().pickImage(source: source);
    return imagePick;
  }
}
