
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class MyPullList extends StatefulWidget {
  const MyPullList({super.key});

  @override
  State<MyPullList> createState() => _MyPullListState();
}

class _MyPullListState extends State<MyPullList> {
  bool defaultshipping = true;
  bool defaultbilling = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
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
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My Pull List",
                  style: TextStyle(
                      fontSize: allsize * 0.02,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius:0.1,
                          offset: Offset(2, 2),
                        ),
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Welcome to the Midtown Comics Pull List Program",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                fontSize: allsize * 0.016),
                          ),
                          Text(
                            "1. To get started, brose our Pull list titles below, or use the search box belo"
                            "to look for the title you'd like to subscribe to.\n"
                            "2.Once you've selected ten or more monthly titles ,click Save and Continuous\n"
                            "3. On the following page, you'll be prompted to fill in the shipping and billing information",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: allsize * 0.012),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius:0.1,
                        offset: Offset(2, 2),
                      ),
                    ]
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.07,
                        color: const Color(0xff006ccf),
                        child: Center(
                          child: Text(
                            "BROWSE PULL LIST",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: allsize * 0.018,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const SubcribeWidget(),
            SizedBox(
              height: size.height * 0.02,
            ),
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
