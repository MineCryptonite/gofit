import 'package:flutter/material.dart';
import 'package:gofit/constants/assets_images.dart';
import 'package:gofit/constants/routes.dart';
import 'package:gofit/screens/auth_ui/login/login.dart';
import 'package:gofit/screens/auth_ui/sign_up/sign_up.dart';
import 'package:gofit/widgets/big_text.dart';
import 'package:gofit/widgets/primary_button/primary_button.dart';
import 'package:gofit/widgets/top_titles/top_titles.dart';

// import '../sign_up/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
              "안녕하세요!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontFamily: 'Pretendard',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "고핏에 온걸 환영합니다.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Pretendard',
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Center(
              child: Text(
                "시작하세요.",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20),
            PrimaryButton(
              title: "로그인",
              onPressed: () {
                Routes.instance.push(widget: const Login(), context: context);
              },
            ),
            const SizedBox(
              height: 18.0,
            ),
            PrimaryButton(
              title: "회원가입",
              onPressed: () {
                Routes.instance.push(widget: const SignUp(), context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
