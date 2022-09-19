import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';

/// 2022.03.08 이승훈
/// 위치 기반 탈모 전문 병원 안내 페이지
/// Google Maps API 사용
class HospitalPage extends StatefulWidget {
  final JBMBMemberManager memberManager;

  const HospitalPage({Key? key, required this.memberManager})
      : super(key: key);

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  // Google Map Controller
  Completer<GoogleMapController>? _controller;

  // initiate my location, so nullable
  static LatLng? _initialPosition;

  // Marker Set want to write in Google Map
  final Set<Marker> _markers = {};
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserAndHospitalLocation();
  }

  void _getUserAndHospitalLocation() async {
    // accuracy is not worthy
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    var googlePlace = GooglePlace(env['SUPER_SECRET_API_KEY']!);

    int markerId = 1;
    int iterated = 0;

    List keywords = [
      "탈모",
      "피부과",
      "피부",
      "탈모전문",
      "모발",
      "모발이식",
      "두피",
      "헤어",
      "모든모",
      "모바른",
      "모아트",
      "모빈치",
      "닥터포헤어",
      "리즈모"
    ];
    keywords.forEach((key) async {
      NearBySearchResponse? result = await googlePlace.search.getNearBySearch(
          Location(lat: position.latitude, lng: position.longitude), 10000,
          keyword: key, language: "ko", type: "doctor");

      result?.results?.forEach((element) {
        String snippet = _makeSnippset(element);
        Marker mark = Marker(
          markerId: MarkerId(markerId.toString()),
          infoWindow: InfoWindow(
              title: element.name,
              snippet: snippet,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(element.name! + "을(를) 검색"),
                  action: SnackBarAction(
                    label: "Search",
                    onPressed: () {
                      _searchInGoogle(element.name!);
                    },
                  ),
                ));
              }),
          position: LatLng(element.geometry!.location!.lat!,
              element.geometry!.location!.lng!),);
        markerId += 1;
        _markers.add(mark);
      });

      iterated += 1;
      if (iterated == keywords.length) {
        setState(() {
          isLoading = false;
          print(_markers.length);
        });
      }
    });

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  _onMapCreated(GoogleMapController controller) {
    // connect controller with Member variable _controller
    setState(() {
      _controller?.complete(controller);
    });
  }

  /// Marker Place에 대한 정보 만드는 메소드
  String _makeSnippset(SearchResult searchResult) {
    String snippset = "";
    if (searchResult.vicinity != null) {
      snippset += searchResult.vicinity! + "\n";
    }
    if (searchResult.userRatingsTotal != null) {
      if (searchResult.userRatingsTotal != 0) {
        snippset += "평점 : " +
            searchResult.rating.toString() +
            "(" +
            searchResult.userRatingsTotal.toString() +
            "명 평가)\n";
      } else {
        snippset += "평점 없음\n";
      }
    }
    if (snippset == "") {
      snippset = "정보 없음";
    }
    return snippset;
  }

  _searchInGoogle(String searchQuery) async {
    searchQuery = searchQuery.replaceAll(" ", "+");
    String url = "http://www.google.com/search?q=" + searchQuery;
    String encodedUrl = Uri.encodeFull(url);
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("접속이 원활하지 않습니다."),)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery
        .of(context)
        .size
        .width;
    double phonePadding = MediaQuery
        .of(context)
        .padding
        .top;

    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    return Scaffold(
        key: _scaffoldKey,
        // sideDrawer
        endDrawer: SizedBox(
          width: phoneWidth * 0.55,
          child: LoginedNavigationDrawerWidget(
            memberManager: widget.memberManager,
          ),
        ),
        // 전체 화면 바탕색 지정
        backgroundColor: Colors.white,
        appBar: JBMBAppBarWithBackButton(
          onPressedMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
          onPressedCancel: () => Navigator.pop(context),
        ),
        body: isLoading == true
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.black45,
          ),
        )
            : Container(
          // 가운데 정렬
          alignment: AlignmentDirectional.center,
          // 패딩과 마진 값
          padding: EdgeInsets.all(phonePadding * 0.33),
          margin: EdgeInsets.all(phonePadding * 0.33),
          // 내부 위젯 레이아웃 세로 배치
          child: GoogleMap(
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _initialPosition!,
              zoom: 11.5,
            ),
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
        ));
  }
}
