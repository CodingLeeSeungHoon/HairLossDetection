import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'JBMBAppRoundImage.dart';

class JBMBUploadedImage extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;

  const JBMBUploadedImage({
    Key? key,
    required this.onFileChanged,
  });

  @override
  _JBMBUploadedImageState createState() => _JBMBUploadedImageState();
}

class _JBMBUploadedImageState extends State<JBMBUploadedImage> {
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl == null)
          const Icon(
            Icons.image,
            size: 300,
            color: Colors.black45,
          ),
        if (imageUrl != null)
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
        InkWell(
            onTap: () => _selectPhoto(),
            child: Padding(
              padding: EdgeInsets.all(8.0),
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
                      leading: Icon(Icons.camera),
                      title: Text('카메라 촬영'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_album),
                      title: Text('앨범에서 찾기'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                )));
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
    if (pickedFile == null) {
      return;
    }

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

    await _uploadFile(file.path);
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result!;
  }

  Future _uploadFile(String path) async {
    /// final ref = storage.FirebaseStorage.instance.ref().child('images').child('${DateTime.now().toIso8601String() + p.basename(path)}');
    /// final result = await ref.putFile(File(path));
    /// final fileUrl = await result.ref.getDownloadURL();

    /// setState(() {
    ///  imageUrl = fileUrl;
    /// });

    /// widget.onFileChanged(fileUrl);
    setState(() {
      imageUrl = path;
    });
    widget.onFileChanged(path);
  }
}
