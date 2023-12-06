
import 'package:midtowncomics/screen/weeklyreleasepage.dart';
import 'package:midtowncomics/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeeklyReleaseButton extends StatelessWidget {
  const WeeklyReleaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(allsize*0.006),
      child: Container(
        // height: size.height * 0.09,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{
                     final provider=Provider.of<StreamedDataProvider>(context,listen: false);
                     print(provider.loginuserdata);
                     final SharedPreferences prefs = await SharedPreferences.getInstance();
                     String data=prefs.getString("sh_id")??"";
                     print(data);
                    },
                    child: Text(
                      "WEEKLY RELEASE",
                      style: TextStyle(
                          color: const Color(0xff006ccf),
                          fontFamily: 'oswald_light',
                          fontSize: allsize*0.019,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.14),
                        child: Text(
                    "Updated every wednesday",
                    style: TextStyle(color: const Color(0xff7c7c7c),fontSize: allsize*0.011),
                  ),
                      )
                ],
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero
                  )),
                  backgroundColor: MaterialStatePropertyAll(Colors.white)
                ),
                  onPressed: () {
                  Provider.of<WeeklyReleaseProvider>(context,listen: false). updatesortby("TITLE");
                  Get.to(const WeeklyReleasePage());
                  },
                  child:  Center(
                      child: Text(
                    "VIEW ALL",
                    style: TextStyle(color: Colors.black,fontSize: allsize*0.012),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
