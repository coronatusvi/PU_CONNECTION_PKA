import 'package:boxy/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../common/loading_page.dart';
import '../../../constants/assets_constants.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../../user_profile/view/user_profile_view.dart';

class SettingProfileView extends ConsumerStatefulWidget {
  const SettingProfileView({super.key});

  @override
  ConsumerState<SettingProfileView> createState() => _SettingProfileViewState();
}

class _SettingProfileViewState extends ConsumerState<SettingProfileView> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider);
    const posi1 = 100.0;
    return switch (currentUser) {
      AsyncData(value: final currentUser?) ||
      AsyncLoading(value: final currentUser?) =>
        Scaffold(
          body: Stack(
            children: [
              Positioned.fill(child: Image.asset(AssetsConstants.darkBlur)),
              Positioned.fill(
                child: SafeArea(
                  top: false,
                  minimum: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: Pallete.cardColor,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: const SizedBox(
                            height: 300, width: double.maxFinite),
                      ),
                      Expanded(
                        child: OverflowPadding(
                          padding: const EdgeInsets.only(top: -30, bottom: -30),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Pallete.rhinoDark700,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: OverflowPadding(
                                    padding: const EdgeInsets.only(
                                      top: -posi1,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const ShapeDecoration(
                                        color: Pallete.rhinoDark800,
                                        shape: CircleBorder(),
                                      ),
                                      constraints: BoxConstraints.tight(
                                          const Size.square(160)),
                                      child: Stack(
                                        fit: StackFit.loose,
                                        children: [
                                          CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  currentUser.profilePic),
                                              radius: 80),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const ShapeDecoration(
                                                color: Pallete.rhinoDark800,
                                                shape: CircleBorder(),
                                              ),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Pallete.yellow800,
                                                radius: 25,
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.camera_alt,
                                                    color: Pallete.rhinoDark800,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 31),
                                  child: Center(
                                    child: Text(
                                      ' ${currentUser.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 28),
                                    ),
                                  ),
                                ),
                                const Gap(24),
                                Divider(
                                  // color: Pallete.rhinoDark600,
                                  thickness: 1,
                                  indent: 24,
                                  endIndent: 24,
                                ),
                                const Gap(5),
                                Expanded(
                                  child: ListView(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            UserProfileView.route(currentUser),
                                          );
                                        },
                                        child: ListTile(
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Pallete.subTextColor,
                                          ),
                                          leading: CircleAvatar(
                                            backgroundColor: Pallete.whiteColor,
                                            radius: 26,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Pallete.rhinoDark700,
                                              radius: 25,
                                              child: SvgPicture.asset(
                                                AssetsConstants.profileIcon,
                                                colorFilter: ColorFilter.mode(
                                                  Pallete.yellow800,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            'Trang cá nhân',
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {},
                                        child: ListTile(
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Pallete.subTextColor,
                                          ),
                                          leading: CircleAvatar(
                                            backgroundColor: Pallete.whiteColor,
                                            radius: 26,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Pallete.rhinoDark700,
                                              radius: 25,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        AssetsConstants
                                                            .eduLogo),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            currentUser.educationId != 'no'
                                                ? 'Lịch học'
                                                : 'Liên kết tài khoản QLDT',
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () => {
                                          ref
                                              .read(authControllerProvider
                                                  .notifier)
                                              .logout(context),
                                        },
                                        child: ListTile(
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Pallete.subTextColor,
                                          ),
                                          leading: CircleAvatar(
                                            backgroundColor: Pallete.whiteColor,
                                            radius: 26,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Pallete.rhinoDark700,
                                              radius: 25,
                                              child: SvgPicture.asset(
                                                AssetsConstants.logoutIcon,
                                                colorFilter: ColorFilter.mode(
                                                  Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            'Đăng xuất',
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      _ => const Loader()
    };
  }
}
