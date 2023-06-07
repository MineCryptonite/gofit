// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofit/constants/constants.dart';
import 'package:gofit/constants/routes.dart';
import 'package:gofit/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:gofit/screens/auth_ui/sign_up/sign_up.dart';
import 'package:gofit/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:gofit/widgets/primary_button/primary_button.dart';
import 'package:gofit/widgets/top_titles/top_titles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight + 12,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back_ios)),
              Center(
                child: Text(
                  "로그인",
                  style: const TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Pretendard',
                  ),
                ),
              ),
              const SizedBox(
                height: 46.0,
              ),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: "이메일",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "비밀번호",
                  hintStyle: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                  prefixIcon: const Icon(
                    Icons.password_sharp,
                  ),
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36.0,
              ),
              PrimaryButton(
                title: "로그인",
                onPressed: () async {
                  bool isValidated = loginValidation(email.text, password.text);
                  if (isValidated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .login(email.text, password.text, context);
                    if (isLogined) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: const CustomBottomBar(), context: context);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                      child: Text(
                    "계정이 없으신가요?",
                    style: TextStyle(fontSize: 14, fontFamily: 'Pretendard'),
                  )),
                  Center(
                    child: CupertinoButton(
                      onPressed: () {
                        Routes.instance
                            .push(widget: const SignUp(), context: context);
                      },
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontFamily: 'Pretendard'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
