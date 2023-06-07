import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
  final String title, subtitle;
  const TopTitles({super.key, required this.subtitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kToolbarHeight + 12,
        ),
        if (title == "로그인" || title == "회원가입")
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_ios)),
        const SizedBox(
          height: 12.0,
        ),
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pretendard',
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'Pretendard',
            ),
          ),
        ),
      ],
    );
  }
}
