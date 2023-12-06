import 'package:midtowncomics/provider/LandingPageProvider.dart';
import 'package:midtowncomics/provider/addressprovider.dart';
import 'package:midtowncomics/provider/creditcardprovider.dart';
import 'package:midtowncomics/provider/faqProvider.dart';
import 'package:midtowncomics/provider/giftCardProvider.dart';
import 'package:midtowncomics/provider/instorePickUpProvider.dart';
import 'package:midtowncomics/provider/newsLetterProvider.dart';
import 'package:midtowncomics/provider/orderprovider.dart';
import 'package:midtowncomics/provider/previewOrderProvider.dart';
import 'package:midtowncomics/provider/settingProvider.dart';
import 'package:midtowncomics/provider/shipingInformationProvider.dart';
import 'package:midtowncomics/provider/wishListProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'export.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Error:\n${details.exception}",
        style: const TextStyle(
            color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  };
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xff004674),
      ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StreamedDataProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => WeeklyReleaseProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CreditCardProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => AccountSettingProvider()),
        ChangeNotifierProvider(create: (_) => GiftCardProvider()),
        ChangeNotifierProvider(create: (_) => WishListProvider()),
        ChangeNotifierProvider(create: (_) => NewsLetterProvider()),
        ChangeNotifierProvider(create: (_) => ShippingInformationProvider()),
        ChangeNotifierProvider(create: (_) => InStorePickUpProvider()),
        ChangeNotifierProvider(create: (_) => FAQProvider()),
        ChangeNotifierProvider(create: (_) => LandingPageProvider()),
        ChangeNotifierProvider(create: (_) => PreviewOrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Midtown Comics',
      theme: ThemeData(
          // useMaterial3: true,
          fontFamily: GoogleFonts.openSans().fontFamily,
          scaffoldBackgroundColor: const Color(0xfff6f6f6),
          colorSchemeSeed: const Color(0xff006ccf),
          scrollbarTheme: const ScrollbarThemeData().copyWith(
            thumbColor: MaterialStateProperty.all(const Color(0xff006ccf)),
          )),
      home: const SplashScreen(),
    );
  }
}
