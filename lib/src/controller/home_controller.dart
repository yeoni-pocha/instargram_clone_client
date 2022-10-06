import 'package:get/get.dart';
import 'package:instargram_clone/src/models/post.dart';
import 'package:instargram_clone/src/repository/post_repository.dart';

class HomeController extends GetxController {

  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFeedList();
  }

  void _loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    print( '### > ${feedList.length}' );
    postList.addAll(feedList);
  }

}