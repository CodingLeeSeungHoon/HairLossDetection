import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:simple_s3/simple_s3.dart';
import 'JBMBAppRoundImage.dart';

class JBMBUploadedImageWidget extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;

  const JBMBUploadedImageWidget({
    Key? key,
    required this.onFileChanged,
  });

  @override
  _JBMBUploadedImageWidgetState createState() => _JBMBUploadedImageWidgetState();
}

class _JBMBUploadedImageWidgetState extends State<JBMBUploadedImageWidget> {
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading)
          Center(
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
          )),
        if (!isLoading && imageUrl == null)
          const Icon(
            Icons.image,
            size: 300,
            color: Colors.black45,
          ),
        if (!isLoading && imageUrl != null)
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _selectPhoto(),
            child: JBMBAppRoundImage.url(
              imageUrl!,
              width: 300,
              height: 300,
            ),
          ),
        if (!isLoading)
          InkWell(
              onTap: () => _selectPhoto(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  imageUrl != null ? '사진 변경' : '사진 업로드',
                  style: const TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              )),
      ],
    );
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('카메라 촬영'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_album),
                      title: const Text('앨범에서 찾기'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                )));
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
        debugLog: true);

    // 'https://jbmbbucket.s3.amazonaws.com/' + fileName

    setState(() {
      imageUrl = file.path;
      isLoading = false;
    });

    widget.onFileChanged(file.path);
  }
}
