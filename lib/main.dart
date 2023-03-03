import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_contacts_messages/presentation/screens/splash.dart';

import 'core/utils/colors_utils.dart';
import 'core/utils/fonts_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const ProviderScope(
      child: MyApp(
        key: Key('myApp'),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: ColorsUtils.kPrimaryColor,
          fontFamily: FontUtils.almarai,
        ),
        home:  const Splash(
            key: Key(''),
        ),
      ),
    );
  }
}
