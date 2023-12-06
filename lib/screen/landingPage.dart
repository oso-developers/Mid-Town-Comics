// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/LandingPageProvider.dart';
import 'package:midtowncomics/widget/searchList.dart';

import '../widget/homeScrrenHorizantalListView.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key,required });
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

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
          child:
              Consumer<LandingPageProvider>(builder: (context,provider,child){
                return  provider.landingPageData.isNotEmpty?
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchList(searchcontroller: searchController),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                              offset: Offset(2, 0),
                            ),
                          ]
                      ),
                      child: Container(
                        width:double.infinity,
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              provider.pageSummary['lp_kwrd'],
                              style: TextStyle(
                                  fontSize: allsize * 0.017,
                                  fontFamily: 'oswald_bold',
                                  fontWeight: FontWeight.bold),
                            ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.02,),
                    ListView.builder(
                itemCount: provider.categoryList.length,
                itemBuilder: (context,index)
                    {
                      ScrollController scrollController=ScrollController();
                      PageController pageController=PageController();
                      List<dynamic>data=provider.categoryList[index]['productList'];
                      return Container(
                        color: Colors.white,
                        child: Padding(
                          padding:EdgeInsets.symmetric(horizontal: size.width*0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(provider.categoryList[index]['section_name'],style: TextStyle(
                                fontSize: allsize*0.017,fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: size.height*0.02,),
                              SizedBox(
                                  height: size.height*0.43,
                                  child: HomeScrrenHorizantalList(data:data, scrollController: scrollController, pageScrollController: pageController,)
                              ),
                              SizedBox(height: size.height*0.01,)
                            ],
                          ),
                        ),
                      );
                    },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                      height: size.height * 0.05,
                    )
                  ],
                )
                    :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.16),
                    const Center(child: CircularProgressIndicator())
                  ],
                )
                ;
          },)
        ),
      ),
    );
  }
}


