import 'package:flutter/material.dart';

/// 2022.03.14 이승훈
/// 제발모발 로고와 우측 메뉴 탭을 가지고 있는 AppBar
/// BackButton이 없으므로, 메인 화면에 사용되는 AppBar
/// Home, LoginedHome에 사용.
class JBMBAppBar extends AppBar {
  JBMBAppBar({Key? key, required VoidCallback onPressedMenu})
      : super(
          key: key,
          title: const Text(
            "제발모발",
            style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontFamily: 'Gugi-Regular',
                fontWeight: FontWeight.bold),
          ),
          // AppBar 내 요소 가운데 정렬
          centerTitle: true,
          // AppBar 그림자 제거
          elevation: 0,
          // AppBar 바탕색 설정
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: onPressedMenu,
            )
          ],
        );
}

/// 2022.03.14 이승훈
/// 투명 AppBar, 왼쪽의 x 버튼이 존재하는 AppBar
/// Login, Join, Alert, Result Page
class JBMBTransparentAppbar extends AppBar {
  JBMBTransparentAppbar({Key? key, required VoidCallback onPressedCancel})
      : super(key: key,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading:
              IconButton(icon: Icon(Icons.cancel), onPressed: onPressedCancel),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        );
}

/// 2022.03.14 이승훈
/// 제발모발 로고만 중간에 존재하는 AppBar로, BackButton과 Menu가 없음.
/// Survey1~10, UploadImageGuide, UploadeImage Page
class JBMBAppBarWithOutMenu extends AppBar {
  JBMBAppBarWithOutMenu({Key? key}) : super(key: key,
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: const Text(
      "제발모발",
      style: TextStyle(
          fontSize: 23,
          color: Colors.black,
          fontFamily: 'Gugi-Regular',
          fontWeight: FontWeight.bold),
    ),
    // AppBar 내 요소 가운데 정렬
    centerTitle: true,
  );
}

/// 2022.03.14 이승훈
/// 제발모발 로고 + 백버튼 + Menu가 있는 AppBar로, 핵심 기능 페이지에 사용된다.
/// Shampoo, Hospital, Community Page
class JBMBAppBarWithBackButton extends AppBar {
  JBMBAppBarWithBackButton({Key? key, required VoidCallback onPressedMenu, required VoidCallback onPressedCancel}) : super(
    title: const Text(
      "제발모발",
      style: TextStyle(
          fontSize: 23,
          color: Colors.black,
          fontFamily: 'Gugi-Regular',
          fontWeight: FontWeight.bold),
    ),
    // AppBar 내 요소 가운데 정렬
    centerTitle: true,
    // AppBar 그림자 제거
    elevation: 0,
    // AppBar 바탕색 설정
    backgroundColor: Colors.white,
    leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: onPressedCancel,),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: onPressedMenu,
      )
    ],
  );
}
