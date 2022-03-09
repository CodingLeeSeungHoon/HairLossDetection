import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/LoginedHome.dart';

class DiagnosisResultPage extends StatefulWidget {
  const DiagnosisResultPage({Key? key}) : super(key: key);

  @override
  _DiagnosisResultPageState createState() => _DiagnosisResultPageState();
}

class _DiagnosisResultPageState extends State<DiagnosisResultPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginedHome(),
                ));
              },
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                child: Text('1'),
              ),
            ),
          ),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }
}
