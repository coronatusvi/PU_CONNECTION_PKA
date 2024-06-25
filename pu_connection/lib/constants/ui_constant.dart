import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../features/explore/view/explore_view.dart';
import '../features/messenger/views/list_messages_view.dart';
import '../features/setting_profile/view/setting_profile_view.dart';
import '../features/tweet/views/list_posts_view.dart';
import '../theme/pallete.dart';
import 'assets_constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false, // Loại bỏ Button back
      title: SvgPicture.asset(
        AssetsConstants.phenikaaLogo,
        height: 40,
        colorFilter:
            const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    // const Text("Feed Screen"),
    const NewPostsList(),
    const ExploreView(),
    const ListMessagesView(),
    const SettingProfileView(),
  ];
}
