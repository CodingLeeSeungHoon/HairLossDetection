import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen/Home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;


Future main() async {
  await DotEnv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
      value) {
    runApp(const JBMBApplication());
  });
}

class JBMBApplication extends StatelessWidget {
  const JBMBApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '제발모발',
      themeMode: ThemeMode.system,
      home: Home(),
      builder: (context, child) =>
          MediaQuery(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: child!,
            ),
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          ),);
  }
}
