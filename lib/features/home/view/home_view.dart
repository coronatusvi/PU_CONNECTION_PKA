import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phenikaa_campus/constants/assets_constants.dart';
import 'package:phenikaa_campus/constants/ui_constant.dart';
import 'package:phenikaa_campus/features/home/view/widget/bottom_appbar_icon.dart';
import 'package:phenikaa_campus/features/tweet/views/create_tweet_view.dart';
import 'package:phenikaa_campus/theme/theme.dart';

import '../widgets/slide_.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appBar();

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  onCreateTweet() {
    Navigator.push(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _page == 0 ? appBar : null,
      drawer: const SideDrawer(),
      body: IndexedStack(index: _page, children: UIConstants.bottomTabBarPages),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _page,
          onTap: onPageChange,
          backgroundColor: Pallete.rhinoDark700,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AssetsConstants.homeOutlinedIcon,
                color: Pallete.yellow800,
              ),
              icon: SvgPicture.asset(
                AssetsConstants.homeOutlinedIcon,
                color: Pallete.whiteColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AssetsConstants.searchIcon,
                color: Pallete.yellow800,
              ),
              icon: BottomAppBarIcon(
                icon: SvgPicture.asset(
                  AssetsConstants.searchIcon,
                  color: Pallete.whiteColor,
                ),
                page: _page,
                right: 40,
                left: 0,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AssetsConstants.notifOutlinedIcon,
                color: Pallete.yellow800,
              ),
              icon: BottomAppBarIcon(
                icon: SvgPicture.asset(
                  AssetsConstants.notifOutlinedIcon,
                  color: Pallete.whiteColor,
                ),
                page: _page,
                right: 0,
                left: 40,
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AssetsConstants.profileIcon,
                color: Pallete.yellow800,
              ),
              icon: SvgPicture.asset(
                AssetsConstants.profileIcon,
                color: Pallete.whiteColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: _page == 0
          ? FloatingActionButton(
              onPressed: () {
                // Handle FloatingActionButton click
                Navigator.push(context, CreateTweetScreen.route());
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: Pallete.cardColor,
                ),
                child: const Icon(
                  Icons.add,
                  color: Pallete.whiteColor,
                ),
              ),
              shape: CircleBorder(),
            )
          : null,
      floatingActionButtonLocation:
          _page == 0 ? FloatingActionButtonLocation.centerDocked : null,
    );
  }
}
