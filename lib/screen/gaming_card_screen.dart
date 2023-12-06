
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class GamingAndCardScreen extends StatefulWidget {
  const GamingAndCardScreen({super.key});

  @override
  State<GamingAndCardScreen> createState() => _GamingAndCardScreenState();
}

class _GamingAndCardScreenState extends State<GamingAndCardScreen> {
  int index = 1;
  String dropdownselected = "";
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
                Material(
                  elevation: 3,
                  child: SizedBox(
                      height: size.height * 0.05,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "CARDS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: allsize * 0.018),
                        ),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 2 / 0.6),
                  padding: const EdgeInsets.all(8.0),
                  // padding around the grid
                  itemCount: 5,
                  // total number of items
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xff006ccf),
                              width: allsize * 0.003)),
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                ListView.builder(
                    itemCount: 5,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (item, index) {
                      return Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.16,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/extra/dark_knights.png',
                                      ),
                                      fit: BoxFit.cover)),
                              child: Container(
                                color: Colors.black45,
                                child: Center(
                                  child: Text(
                                    "Alternative",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: allsize*0.025,
                                      shadows: const [
                                        Shadow(
                                          color: Colors.black,
                                          // Choose the color of the shadow
                                          blurRadius: 2.0,
                                          // Adjust the blur radius for the shadow effect
                                          offset: Offset(2.0,
                                              2.0), // Set the horizontal and vertical offset for the shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            )
                          ],
                        ),
                      );
                    }),
                const Footer(),
                SizedBox(
                  height: size.height * 0.05,
                )
              ],
            )),
      ),
    );
  }
}
