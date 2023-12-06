
import 'package:midtowncomics/widget/searchList.dart';

import '../widget/backissuelistwidget.dart';
import 'package:midtowncomics/export.dart';

class BackIssueScreen extends StatefulWidget {
  const BackIssueScreen({super.key});

  @override
  State<BackIssueScreen> createState() => _BackIssueScreenState();
}

class _BackIssueScreenState extends State<BackIssueScreen> {
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
                          "BACK ISSUES",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: allsize * 0.018),
                        ),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.025),
                  child: Text("Featured Publishers",style: TextStyle(fontSize: allsize*0.015,fontWeight: FontWeight.w500),),
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
                //Marvel
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Marvel",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                //DC
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DC",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Dark Horse
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dark Horse",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Dynamite Entertainement
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dynamite Entertainment",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //IDW Publishing
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("IDW Publishing",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Image
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Image",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Indipendant
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("InDependants",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Archie Comics
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Archie Comics",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.025),
                  //Featured Characters
                  child: Text("Featured Characters",style: TextStyle(fontSize: allsize*0.015,fontWeight: FontWeight.w500),),
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
                //Featured Runs
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // height: size.height * 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Featured Runs",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: allsize * 0.02,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.43,
                          child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: PageView.builder(
                              itemCount:
                              (200 /
                                  2)
                                  .ceil(),
                              // Display two items per page
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, pageIndex) {
                                final startIndex = pageIndex * 2;
                                final endIndex = startIndex + 2;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.013),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var index = startIndex;
                                      index < endIndex;
                                      index++)
                                        if (index <
                                            200)
                                          const SizedBox(
                                            // width: size.width * 0.47962,
                                            // Adjust the width as needed
                                            child: BackIssueListWidget(),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.025),
                  //Featured Characters
                  child: Text("Categories",style: TextStyle(fontSize: allsize*0.015,fontWeight: FontWeight.w500),),
                ),
                SizedBox(height: size.height*0.01,),
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
