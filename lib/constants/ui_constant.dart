import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phenikaa_campus/constants/assets_constants.dart';
import 'package:phenikaa_campus/features/explore/view/explore_view.dart';
import 'package:phenikaa_campus/features/tweet/views/list_posts_view.dart';
import 'package:phenikaa_campus/features/tweet/widgets/tweet_list.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

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
    // const Text("Search Screen"),
    const ExploreView(),
    // const UserProfileView(),
    const Text("Notification Screen"),
  ];
}
