import 'package:flutter/material.dart';

class MainDescription extends StatelessWidget {
  /// 2020.02.27 이승훈 개발
  /// '제발모발은 로그인이 필요한 서비스입니다' 텍스트 위젯화
  const MainDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "제발모발",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 23,
                  color: Colors.black45,
                  fontFamily: 'NanumGothic-Regular',
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "은",
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
          "로그인이 필요한",
          style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontFamily: 'NanumGothic-Regular',
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3,),
        const Text(
          "서비스입니다.",
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
