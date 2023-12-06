// ignore_for_file: camel_case_types

import 'package:midtowncomics/screen/weeklyreleasepage.dart';
import '../screen/dealoftheday.dart';
import '../screen/preorder_screen.dart';
import 'package:midtowncomics/export.dart';


class Custom_drawer extends StatefulWidget {
  const Custom_drawer({Key? key}) : super(key: key);

  @override
  State<Custom_drawer> createState() => _Custom_drawerState();
}

class _Custom_drawerState extends State<Custom_drawer> {
  @override
  Widget build(BuildContext context) {
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Drawer(
        width: size.width*0.6,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: const Color(0xff006ccf),
              height: 60,
              child: Center(
                child: Text(
                  "HOME",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: allsize*0.016),
                ),
              ),
            ),
            ListTile(
              title:  Text("Weekly Release",style: TextStyle(fontSize: allsize*0.013),),
              onTap: (){
                Navigator.pop(context);
                Get.to(const WeeklyReleasePage());
              },
            ),
            ListTile(
              title:  Text("Comics",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const ComicScreen());
              },
            ),
            ListTile(
              title:  Text("Varient/Incentive",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("Back Issues",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const BackIssueScreen());
              },
            ),
            ListTile(
              title: Text("Graphic Novels",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const GraphicNovels());
              },
            ),
            ListTile(
              title: Text("Books",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const Books());
              },
            ),
            ListTile(
              title: Text("Magazines",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const Magazines());
              },
            ),
            ListTile(
              title: Text("Manga",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const MangaScreen());
              },
            ),
            ListTile(
              title: Text("Apparel",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const ApparelScreen());
              },
            ),
            ListTile(
              title: Text("Statues",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const StatuesScreen());
              },
            ),
            ListTile(
              title: Text("Action Figure",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const ActionFigureScreen());
              },
            ),
            ListTile(
              title: Text("Collectibles",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const CollectibleScreen());
              },
            ),
            ListTile(
              title: Text("Gaming and Cards",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const GamingAndCardScreen());
              },
            ),
            ListTile(
              title: Text("DVD'S",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const DVDS_Screen());
              },
            ),
            ListTile(
              title: Text("Supplies",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const SuppliesScreen());
              },
            ),
            ListTile(
              title: Text("Clearance",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){},
            ),
            ListTile(
              title: Text("Pull List",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){},
            ),
            ListTile(
              title: Text("Pre Orders",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Get.to(const PreOrderScreen());
              },
            ),
            ListTile(
              title: Text("Deal of the Day",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){
                Navigator.pop(context);
                Get.to(const DealOfTheDay());
              },
            ),
            ListTile(
              title: Text("Gift Card",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){},
            ),
            ListTile(
              title: Text("Browsing Histoy",style: TextStyle(fontSize: allsize*0.013)),
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}
