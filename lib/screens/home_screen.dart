import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone1/provider/user_provider.dart';
import 'package:instagram_clone1/screens/add_post.dart';
import 'package:instagram_clone1/screens/feed_screen.dart';
import 'package:instagram_clone1/screens/profile_screen.dart';
import 'package:instagram_clone1/screens/search_screen.dart';
import 'package:instagram_clone1/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // initState에서 데이터 로딩을 시작합니다.
    Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationPageSelected(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider의 상태를 listen합니다.
    final userProvider = Provider.of<UserProvider>(context);

    // FutureBuilder 대신, Provider의 초기화 상태를 직접 확인합니다.
    return userProvider.isUserInitialized
        ? Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const FeedScreen(),
          const SearchScreen(),
          const AddPost(),
          const Text('activity'),
          ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: _page == 0
                  ? const Icon(
                CupertinoIcons.house_fill,
                color: blackColor,
              )
                  : const Icon(
                CupertinoIcons.house,
                color: secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: _page == 1
                  ? const Icon(
                CupertinoIcons.search,
                color: blackColor,
              )
                  : const Icon(
                Icons.search,
                color: secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: _page == 2
                  ? const Icon(
                CupertinoIcons.add_circled_solid,
                color: blackColor,
              )
                  : const Icon(
                CupertinoIcons.add_circled,
                color: secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? blackColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? blackColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor)
        ],
        onTap: navigationPageSelected,
      ),
    )
        : const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}