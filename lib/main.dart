// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tagxiuser/functions/functions.dart';
import 'package:tagxiuser/functions/notifications.dart';
import 'pages/loadingPage/loadingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();

  // FlutterError.onError = (errorDetails) {
  //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  //   };
  //   //Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //     return true;
  //   };
  final navigatorKey = GlobalKey<NavigatorState>();

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  checkInternetConnection();
  initMessaging();
  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;
    return GestureDetector(
        onTap: () {
          //remove keyboard on touching anywhere on the screen.
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Tospi User',
            theme: ThemeData(),
            home: const LoadingPage()));
  }
}


