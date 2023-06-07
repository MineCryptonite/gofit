// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofit/constants/constants.dart';
import 'package:gofit/constants/routes.dart';
import 'package:gofit/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:gofit/main.dart';
import 'package:gofit/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:gofit/widgets/primary_button/primary_button.dart';
import 'package:gofit/widgets/top_titles/top_titles.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isShowPassword = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                  "회원가입",
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
                controller: name,
                decoration: const InputDecoration(
                  hintText: "이름",
                  prefixIcon: Icon(
                    Icons.person_outline,
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
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "이메일",
                  hintStyle: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "전화번호",
                  hintStyle: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                  prefixIcon: Icon(
                    Icons.phone_outlined,
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
                      child: const Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      )),
                ),
              ),
              const SizedBox(
                height: 36.0,
              ),
              PrimaryButton(
                title: "회원가입",
                onPressed: () async {
                  bool isVaildated = signUpValidation(
                      email.text, password.text, name.text, phone.text);
                  if (isVaildated) {
                    var timestamp = Timestamp.now();

                    bool isLogined = await FirebaseAuthHelper.instance.signUp(
                        name.text.trim(),
                        email.text.trim(),
                        password.text.trim(),
                        timestamp,
                        phone.text.trim(),
                        context);
                    if (isLogined) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: const MainApp(), context: context);
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
                    "계정이 있으신가요?",
                    style: TextStyle(fontSize: 14, fontFamily: 'Pretendard'),
                  )),
                  Center(
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "로그인",
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
