import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phenikaa_campus/features/user_profile/widget/follow_count.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

import '../../../constants/assets_constants.dart';
import '../../../models/user_models.dart';

class UserProfile extends ConsumerWidget {
  final UserModel user;
  UserProfile({
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var heightStatusBar = MediaQuery.of(context).viewPadding.top;
    var size = MediaQuery.of(context).size;
    final expandedHeight = 300.0;
    final collapsedHeight = 60.0;
    double containerHeight;
    if (Platform.isAndroid) {
      containerHeight = expandedHeight - collapsedHeight - heightStatusBar;
    } else {
      containerHeight = expandedHeight - collapsedHeight;
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: expandedHeight,
          collapsedHeight: collapsedHeight,
          floating: true,
          pinned: true,
          snap: true,
          title: Text('Nguyen Phi Hung',
              style: TextStyle(fontSize: 20, color: Pallete.rhinoDark800)),
          backgroundColor: Pallete.rhinoDark700,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: size.width * 0.08),
            centerTitle: true,
            collapseMode: CollapseMode.pin,
            background: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: user.bannerPic.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                            gradient: Pallete.cardColor,
                          ))
                        : Image.network(
                            user.bannerPic,
                            fit: BoxFit.fitWidth,
                          ),
                    height: containerHeight,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     colorFilter:
                    //         ColorFilter.mode(Colors.black54, BlendMode.darken),
                    //     image: NetworkImage(user.bannerPic),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ),
                ),
                Positioned(
                  bottom: collapsedHeight,
                  left: size.width * 0.08,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: ShapeDecoration(
                      color: Pallete.rhinoDark600,
                      shape: CircleBorder(),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                      radius: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        for (int i = 0; i < 10; i++)
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              color: i % 2 == 0 ? Pallete.rhinoDark700 : Pallete.rhinoDark700,
            ),
          )
      ],
    );
  }
}
