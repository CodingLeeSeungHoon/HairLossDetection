import 'package:flutter/material.dart';

/// 2020.03.07 이승훈 개발
class LoginedMainDescription extends StatelessWidget {
  const LoginedMainDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "민들레",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 23,
                  color: Colors.black45,
                  fontFamily: 'NanumGothic-Regular',
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " 님,",
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontFamily: 'NanumGothic-Regular',
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(height: 3,),
        const Text(
          "제발모발에 오신 것을",
          style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontFamily: 'NanumGothic-Regular',
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3,),
        const Text(
          "환영합니다.",
          style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontFamily: 'NanumGothic-Regular',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
