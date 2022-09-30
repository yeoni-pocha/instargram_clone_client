import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instargram_clone/src/binding/init_bindings.dart';
import 'package:instargram_clone/src/models/instagram_user.dart';
import 'package:instargram_clone/src/repository/user_repository.dart';

class AuthController extends GetxController {

  static AuthController get to => Get.find();

  Rx<IUser> user = IUser().obs;

  Future<IUser?> loginUser(String uid) async {
    // DB 조회
    var userData =  await UserRepository.loginUserByUid(uid);
    if(userData!=null) {
      user(userData);
      InitBinding.additionalBinding();
    }
    return userData;
  }

  Future<void> signup(IUser signupUser, XFile? thumbnail) async {
    if(thumbnail == null) {
      _submitSignup(signupUser);
    } else {
      var task = uploadXFile(thumbnail, '${signupUser.uid}/profile.${thumbnail.path.split('.').last}');
      task.snapshotEvents.listen((event) async {
        if(event.bytesTransferred == event.totalBytes && event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updateUserData = signupUser.copyWith(thumbnail: downloadUrl);
          _submitSignup(updateUserData);
        }
      });
    }
  }

  UploadTask uploadXFile(XFile file, String filename) {
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path}
    );
    return ref.putFile(f, metadata);
  }

  void _submitSignup(IUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if(result) {
      loginUser(signupUser.uid!);
    }
  }

}