
import 'package:midtowncomics/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<dynamic> data = [];

  Future<void> fetchData() async {
    final streamedDataProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String sh_id=prefs.getString("sh_id")??"";
    if(sh_id=="")
      {
        Map<String,dynamic>data=await ApiRequests().fetchData();
        streamedDataProvider.updateData(data);
      }
    else
      {
        String sh_id=prefs.getString("sh_id")??"";
        String f_name=prefs.getString("sh_fname")??"";
        String l_name=prefs.getString("sh_lname")??"";
        String email=prefs.getString("sh_lgid")??"";
        streamedDataProvider.updateSharedPrefrenceData(sh_id, email, f_name, l_name);
      }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      fetchData();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffd70306),
      body: Container(
        height: size.height*1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashscreen/splash_page.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
              children: [
        // SizedBox(
        //   height: size.height * 0.2,
        // ),
        // Center(
        //   child: SizedBox(
        //     height: size.height * 0.3,
        //   ),
        // ),
        // SizedBox(
        //   height: size.height * 0.28,
        // ),
        Center(
          child: Text(
            "Loading...",
            style: TextStyle(fontSize: allsize * 0.015, color: Colors.white),
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
           Center(
          child: Transform.scale(
            scale: allsize*0.0007,
            child: const CircularProgressIndicator(
              color: Color(0xff016fdf),
            ),
          ),
        ),
      SizedBox(
        height: size.height*0.02,
      )
              ],
            ),
      ),
    );
  }
}
