import 'package:tourismappofficial/ad_state.dart';
import 'package:tourismappofficial/pages/FavouritePage.dart';
import 'package:tourismappofficial/pages/HistoryofCyprus.dart';
import 'package:tourismappofficial/pages/TheCityPage.dart';
import 'package:tourismappofficial/pages/Welcome_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/services.dart';
import 'provider/Provider_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourismappofficial/pages/City_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, ]);
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);

  runApp(MultiProvider(
    providers: [
      Provider.value(value: adState),
      ChangeNotifierProvider<Data>(create: (context) => Data()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => WelcomePage(),
        '/CityPage': (context) => CityPage(),
        '/TheCityPage': (context) => TheCityPage(),
        '/FavouritePage': (context) => FavouritePage(),
        '/History': (context)=>HistoryofCyprus()
      },
      initialRoute: '/',
    );
  }
}