import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instargram_clone/src/components/image_data.dart';
import 'package:instargram_clone/src/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Obx(
          () => Scaffold(
            appBar: AppBar(),
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                Container(child: Center(child: Text('HOME'))),
                Container(child: Center(child: Text('SEARCH'))),
                Container(child: Center(child: Text('UPLOAD'))),
                Container(child: Center(child: Text('ACTIVITE'))),
                Container(child: Center(child: Text('MYPAGE'))),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              currentIndex: controller.pageIndex.value,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home'
                ),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.searchOff),
                    activeIcon: ImageData(IconsPath.searchOn),
                    label: 'search'
                ),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.uploadIcon),
                    label: 'upload'
                ),
                BottomNavigationBarItem(
                    icon: ImageData(IconsPath.activeOff),
                    activeIcon: ImageData(IconsPath.activeOn),
                    label: 'active'
                ),
                BottomNavigationBarItem(
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey
                      )
                    ),
                    label: 'home'
                )
              ],
            ),
          ),
        )
    );
  }
}
