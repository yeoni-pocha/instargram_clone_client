import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instargram_clone/src/components/message_popup.dart';
import 'package:instargram_clone/src/controller/auth_controller.dart';
import 'package:instargram_clone/src/models/post.dart';
import 'package:instargram_clone/src/pages/upload/upload_description.dart';
import 'package:instargram_clone/src/repository/post_repository.dart';
import 'package:instargram_clone/src/utils/data_util.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class UploadController extends GetxController {

  var albums = <AssetPathEntity>[];
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  RxString headerTitle = ''.obs;
  Rx<AssetEntity> selectedImage = AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  File? filteredImage;
  TextEditingController textEditingController = TextEditingController();
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      PhotoManager.setIgnorePermissionCheck(true);
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        // todo 요것때매 이미지 못불러옴!!
        // filterOption: FilterOptionGroup(
        //     imageOption: const FilterOption(sizeConstraint: SizeConstraint(minHeight: 100, maxWidth: 100)),
        //     orders: [
        //       const OrderOption(type: OrderOptionType.createDate, asc: false)
        //     ]
        // )
      );
      _loadData();
    } else {
      // 권한 요청
    }
  }

  void _loadData() async {
    changeAlbum(albums.first);
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(0, 30);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    var imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(()=> UploadDescription());
    }
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unfocusKeyboard();
    String filename = DataUtil.makeFilePath();
    var task = uploadFile(filteredImage!, '${ AuthController.to.user.value.uid}/f${filename}');
    if(task != null) {
      task.snapshotEvents.listen((event) async {
        if(event.bytesTransferred == event.totalBytes && event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatePost = post!.copyWith(
              thumbnail: downloadUrl,
              description: textEditingController.text
          );
          _submitPost(updatePost);
        }
      });
    }
  }

  UploadTask uploadFile(File file, String filename) {
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path}
    );
    return ref.putFile(f, metadata);
  }

  void _submitPost(Post updatePost) async {
    await PostRepository.updatePost(updatePost);
    showDialog(context: Get.context!, builder:
        (context) => MessagePopup(
            title: '포스트',
            message: '포스팅이 완료 되었습니다.',
            okCallback: () {
              Get.until((route) => Get.currentRoute == '/');
            },
            cancelCallback: Get.back
        )
    );
  }

}