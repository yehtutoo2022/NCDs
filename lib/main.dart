import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ncd_myanmar/Page/Diseases/cervical_cancer_page.dart';
import 'package:ncd_myanmar/Page/home_page.dart';
import 'package:ncd_myanmar/home_bottom_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Page/Diseases/cancer_page.dart';
import 'Page/Diseases/diabetes_page.dart';
import 'Page/Diseases/heart_disease_page.dart';
import 'Page/Diseases/hypertension_page.dart';
import 'Page/Diseases/stroke_page.dart';
import 'model/favorite_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Locales.init(['en', 'my']);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoriteDataModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        title: 'NCDs',
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        home: const HomeMenu(),
        routes: {
          '/hypertension': (context) => HypertensionScreen(),
          '/dm': (context) => DiabetesScreen(),
          '/heart_disease': (context) => HeartDiseaseScreen(),
          '/stroke': (context) => StrokeScreen(),
          '/cancer': (context) => CancerScreen(),
          '/cervical-cancer': (context) => CervicalCancerScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
