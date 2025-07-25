import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_streaming/app/data/api/api_const.dart';
import 'package:my_streaming/app/data/di/inject.dart';
import 'package:my_streaming/app/data/local/favorite.dart';

import 'app/modules/splash.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init(ApiConst.baseUrl);

  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteMovieEntityAdapter());
  await Hive.openBox<List>('favorites');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  String _initialRoute = Routes.DASHBOARD;

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  void _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 4));

    setState(() {
      _isLoading = false;
      _initialRoute = Routes.DASHBOARD;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      );
    }
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: "Application",
        initialRoute: _initialRoute,
        getPages: AppPages.routes,
      ),
    );
  }
}
