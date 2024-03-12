import 'package:catbreeds/config/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:catbreeds/config/routes/router.dart' as router;
import 'package:catbreeds/config/texts/strings.dart';
import 'package:catbreeds/config/ui/themes.dart';

void main() async {
  await _initApp();
  runApp(const MyApp());
}

Future<void> _initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Env.init();
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppThemes.app,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: router.initRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}
