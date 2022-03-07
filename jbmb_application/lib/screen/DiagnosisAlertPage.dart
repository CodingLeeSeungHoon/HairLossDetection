import 'package:flutter/material.dart';

import '../widget/JBMBBigLogo.dart';

class DiagnosisAlertPage extends StatelessWidget {
  const DiagnosisAlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.pop(context);
            });
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
            child: Column(
              children: [
                SizedBox(
                  height: phoneHeight * 0.073,
                ),
                // TODO : LOGO Image Resolution
                const JBMBBigLogo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
