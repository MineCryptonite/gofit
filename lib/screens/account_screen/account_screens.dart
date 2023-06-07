import 'package:flutter/material.dart';
import 'package:gofit/constants/routes.dart';
import 'package:gofit/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:gofit/screens/about_us/about_us.dart';
import 'package:gofit/screens/change_password/change_password.dart';
import 'package:gofit/screens/edit_profile/edit_profile.dart';
import 'package:gofit/screens/favourite_screen/favourite_screen.dart';
import 'package:gofit/screens/order_screen/order_screen.dart';
import 'package:gofit/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "계정",
          style: TextStyle(color: Colors.black, fontFamily: 'Pretendard'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                appProvider.getUserInformation.photo_url == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 120,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                            appProvider.getUserInformation.photo_url!),
                        radius: 60,
                      ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  appProvider.getUserInformation.display_name,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard'),
                ),
                Text(appProvider.getUserInformation.email,
                    style: TextStyle(fontFamily: 'Pretendard')),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  width: 130,
                  child: PrimaryButton(
                    title: "정보 수정",
                    onPressed: () {
                      Routes.instance
                          .push(widget: const EditProfile(), context: context);
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // ListTile(
                //   onTap: () {
                //     ㅈ
                //   },
                //   leading: const Icon(Icons.shopping_bag_outlined),
                //   title: const Text("나의 예약들",
                //       style: TextStyle(fontFamily: 'Pretendard')),
                // ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(
                        widget: const FavouriteScreen(), context: context);
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("찜",
                      style: TextStyle(fontFamily: 'Pretendard')),
                ),
                /*ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const AboutUs(), context: context);
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),*/
                // ListTile(
                //   onTap: () {
                //     Routes.instance
                //         .push(widget: const ChangePassword(), context: context);
                //   },
                //   leading: const Icon(Icons.change_circle_outlined),
                //   title: const Text("비밀번호 초기화",
                //       style: TextStyle(fontFamily: 'Pretendard')),
                // ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();

                    setState(() {});
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("로그아웃",
                      style: TextStyle(fontFamily: 'Pretendard')),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                // const Text("Version 1.0.0",
                //     style: TextStyle(fontFamily: 'Pretendard')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
