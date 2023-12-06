
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class PushNotificationSetting extends StatefulWidget {
  const PushNotificationSetting({super.key});

  @override
  State<PushNotificationSetting> createState() =>
      _PushNotificationSettingState();
}

class _PushNotificationSettingState extends State<PushNotificationSetting> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize=size.height+size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size(size.width*1,allsize*0.11),
          child: Header_Widget(
            ontap: () => scaffoldKey.currentState!.openDrawer(),
            searchcontroller:searchController,
          ),),
        key: scaffoldKey,
        drawer: const Custom_drawer(),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchList(searchcontroller: searchController),
            SizedBox(
              height: size.height * 0.02,
            ),
            const SubcribeWidget(),
            SizedBox(height: size.height*0.02,),
            const Footer(),
            SizedBox(
              height: size.height * 0.015,
            )
          ],
        )),
      ),
    );
  }
}
