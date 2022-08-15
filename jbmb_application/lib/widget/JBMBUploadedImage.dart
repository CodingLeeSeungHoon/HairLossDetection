import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:simple_s3/simple_s3.dart';
import '../service/JBMBDiagnoseManager.dart';
import '../service/JBMBMemberManager.dart';
import 'JBMBAppRoundImage.dart';

class JBMBUploadedImageWidget extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;
  final String? userID;
  final int? diagnosisID;

  const JBMBUploadedImageWidget(
      {Key? key,
      required this.onFileChanged,
      required this.userID,
      required this.diagnosisID});

  @override
  _JBMBUploadedImageWidgetState createState() =>
      _JBMBUploadedImageWidgetState();
}

class _JBMBUploadedImageWidgetState extends State<JBMBUploadedImageWidget> {
  final ImagePicker _picker = ImagePicker();
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int isSelfMode = 1;
  bool isLoading = false;
  bool stateCamera = false;
  String? imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    startCamera(isSelfMode);
    super.initState();
  }

  /// initializing camera
  void startCamera(int isSelfMode) async {
    cameras = await availableCameras();
    // camera[1] == camera rear mode, camera[0] == camera front mode
    cameraController = CameraController(
        cameras[isSelfMode], ResolutionPreset.high,
        enableAudio: false);

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      log(e);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (isLoading)
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: const [
              CircularProgressIndicator(
                color: Colors.black45,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "서버에 저장 중..",
                style: TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),

      /// 로딩이 아닌 상태 + 아직 이미지를 업로드 하지 않은 상태
      if (!isLoading && imageUrl == null && !stateCamera) ...[
        const Icon(
          Icons.image,
          size: 300,
          color: Colors.black45,
        ),
        JBMBOutlinedButton(
          buttonText: "카메라 촬영",
          iconData: Icons.camera_alt_outlined,
          onPressed: () {
            setState(() {
              stateCamera = true;
            });
            // _pickImage(ImageSource.camera);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        JBMBOutlinedButton(
          buttonText: "앨범에서 찾기",
          iconData: Icons.image,
          onPressed: () {
            _pickImage(ImageSource.gallery);
          },
        ),
      ],

      /// camera 상태
      if (!isLoading && imageUrl == null && stateCamera) ...[
        if (cameraController.value.isInitialized)
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              /// 촬영 프리뷰 화면
              getPreviewScreen(),

              /// 화면 Flip 버튼
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelfMode = isSelfMode == 0 ? 1 : 0;
                    startCamera(isSelfMode);
                  });
                },
                child: getCameraButton(Alignment.bottomLeft,
                    const Icon(Icons.flip_camera_ios_outlined)),
              ),

              /// 촬영 버튼
              GestureDetector(
                onTap: () {
                  cameraController.takePicture().then((XFile? file) {
                    if (mounted) {
                      if (file != null) {
                        String path = file.path;
                        setState(() {
                          stateCamera = false;
                        });
                        _takePhoto(path);
                      }
                    }
                  });
                },
                child: getCameraButton(
                    Alignment.bottomRight, const Icon(Icons.camera)),
              ),
            ],
          ),
      ],

      /// 로딩이 아닌 상태 + 이미지를 업로드 한 상태
      if (!isLoading && imageUrl != null && !stateCamera) ...[
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
          child: JBMBAppRoundImage.url(
            imageUrl!,
            width: 300,
            height: 300,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        JBMBOutlinedButton(
          buttonText: "재촬영",
          iconData: Icons.camera_alt_outlined,
          onPressed: () {
            setState(() {
              widget.onFileChanged('');
              imageUrl = null;
              stateCamera = true;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        JBMBOutlinedButton(
          buttonText: "앨범에서 찾기",
          iconData: Icons.image,
          onPressed: () {
            widget.onFileChanged('');
            imageUrl = null;
            _pickImage(ImageSource.gallery);
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ]);
  }

  Widget getPreviewScreen() {
    return Container(
      alignment: Alignment.center,
      width: 292.5,
      height: 520,
      child: CameraPreview(cameraController),
    );
  }

  Widget getCameraButton(Alignment alignment, Icon icon) {
    return Align(
      alignment: alignment,
      child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: icon),
    );
  }

  Future _takePhoto(String path) async {
    // 이미지 편집
    var file = await ImageCropper().cropImage(
        sourcePath: path,
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: '편집',
            toolbarColor: Colors.grey,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: '편집',
        ));
    if (file == null) {
      return;
    }

    file = await compressImage(file.path, 35);

    // 이미지 업로드
    await _uploadFile(file);
  }

  /// 이미지 선택 혹은 촬영 - 편집 - 업로드가 모두 포함된 메소드
  Future _pickImage(ImageSource source) async {
    // 이미지 선택 혹은 촬영
    final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (pickedFile == null) {
      return;
    }

    // 이미지 편집
    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: '편집',
            toolbarColor: Colors.grey,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: '편집',
        ));
    if (file == null) {
      return;
    }

    file = await compressImage(file.path, 35);

    // 이미지 업로드
    await _uploadFile(file);
  }

  /// 이미지 압축하는 메소드
  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result!;
  }

  /// 이미지 파일을 S3에 업로드하는 메소드
  Future _uploadFile(File file) async {
    setState(() {
      isLoading = true;
    });

    SimpleS3 _simpleS3 = SimpleS3();
    String result = await _simpleS3.uploadFile(file, 'jbmbbucket',
        "us-east-1:39989318-c9e2-4070-bd62-d0a52df01d88", AWSRegions.usEast1,
        debugLog: true,
        fileName:
            widget.userID! + "_" + widget.diagnosisID.toString() + ".jpg");

    log(widget.userID! + "_" + widget.diagnosisID.toString() + ".jpg");
    // 'https://jbmbbucket.s3.amazonaws.com/' + fileName

    setState(() {
      imageUrl = file.path;
      isLoading = false;
    });

    // changed
    widget.onFileChanged('https://jbmbbucket.s3.amazonaws.com/' +
        widget.userID! +
        "_" +
        widget.diagnosisID.toString() +
        ".jpg");
  }
}
