
import 'package:midtowncomics/export.dart';

import '../screen/landingPage.dart';

class CardGridView2 extends StatelessWidget {
  const CardGridView2({super.key});

  @override
  Widget build(BuildContext context) {
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<StreamedDataProvider>(builder: (context, provider, child) {
      return Padding(
        padding: EdgeInsets.only(left: allsize * 0.005, right: allsize * 0.005),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: allsize * 0.009,
          mainAxisSpacing: allsize * 0.009,
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.shortestSide < 550
              ? (2 / 3.5)
              : (2 / 2.2),
          children: [
            //New to Mid tOWN
            InkWell(
              onTap: (){
                provider. updatesearchselextion(provider.featurenewrelease1['pageparameters']['cat']);
                final streamedDataProvider =
                Provider.of<StreamedDataProvider>(context, listen: false);
                ApiRequests().SearchApi(streamedDataProvider.loginuserdata.isEmpty ? "" :streamedDataProvider.loginuserdata['sh_id'],provider.featurenewrelease1['pageparameters']['cat'],provider.featurenewrelease1['pageparameters']['cat'],"10","","","","","","", "","", "", "", "", "","",false,"", context);
                Get.to(const SearchPage());
              },
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(allsize * 0.01),
                    child:provider.featurenewreleasegrid.isEmpty?const Center(child: CircularProgressIndicator(),):
                    Column(
                      children: [
                        Text(
                          "Action Figures",
                          style: TextStyle(
                              color: const Color(0xff1569b4),
                              fontSize: allsize * 0.016,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Flexible(
                          child: Image.network(
                            "https://www.midtowncomics.com/images/PRODUCT/FUL/${provider.featurenewrelease1['pr_id']}_ful.jpg",
                            fit: BoxFit.contain,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.asset('assets/images/imagecomingsoon_ful.jpg',fit: BoxFit.contain,);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //New Release
            InkWell(
              onTap: (){
                provider. updatesearchselextion(provider.featurenewrelease2['pageparameters']['q']);
                final streamedDataProvider =
                Provider.of<StreamedDataProvider>(context, listen: false);
                ApiRequests().SearchApi(streamedDataProvider.loginuserdata.isEmpty ? "" :streamedDataProvider.loginuserdata['sh_id'],provider.featurenewrelease2['pageparameters']['q'],"","10","","","","","","", "","", "", "", "", "","",false,"", context);
                Get.to(const SearchPage());
              },
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(allsize * 0.01),
                    child:
                        provider.featurenewrelease2.isEmpty?const Center(child: CircularProgressIndicator(),):
                    Column(
                      children: [
                        Text(
                          "Japanese Import",
                          style: TextStyle(
                              color: const Color(0xff1569b4),
                              fontSize: allsize * 0.016,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Flexible(
                          child: Image.network(
                            "https://www.midtowncomics.com/images/PRODUCT/FUL/${provider.streamedData['DATA']['featureNewAdditionSection2']['pr_id']}_ful.jpg",
                            fit: BoxFit.contain,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.asset('assets/images/imagecomingsoon_ful.jpg',fit: BoxFit.contain,);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //My Pull List
            InkWell(
              onTap: (){
                final provider=Provider.of<StreamedDataProvider>(context,listen: false);
                ApiRequests().landingPage(provider
                    .loginuserdata
                    .isEmpty
                    ? ""
                    :provider
                    .loginuserdata['sh_id'],provider.featurenewrelease3['pageparameters']['pageName']);
                Get.to(LandingPage());
              },
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(allsize * 0.01),
                    child:
                        provider.featurenewrelease3.isEmpty?const Center(child: CircularProgressIndicator(),):
                    Column(
                      children: [
                        Text(
                          "Funko",
                          style: TextStyle(
                              color: const Color(0xff1569b4),
                              fontSize: allsize * 0.016,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Flexible(
                          child: Image.network(
                            "https://www.midtowncomics.com/images/PRODUCT/FUL/${provider.streamedData['DATA']['featureNewAdditionSection3']['pr_id']}_ful.jpg",
                            fit: BoxFit.contain,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.asset('assets/images/imagecomingsoon_ful.jpg',fit: BoxFit.contain,);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Pre Order
            InkWell(
              onTap: (){
                provider. updatesearchselextion(provider.featurenewrelease4['pageparameters']['cat']);
                final streamedDataProvider =
                Provider.of<StreamedDataProvider>(context, listen: false);
                ApiRequests().SearchApi(streamedDataProvider.loginuserdata.isEmpty ? "" :streamedDataProvider.loginuserdata['sh_id'],provider.featurenewrelease4['pageparameters']['cat'],provider.featurenewrelease4['pageparameters']['cat'],"10","","","","","","", "","", "", "", "", "","",false,"", context);
                Get.to(const SearchPage());
              },
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(allsize * 0.01),
                    child:
                        provider.featurenewrelease4.isEmpty?const Center(child:CircularProgressIndicator(),):
                    Column(
                      children: [
                        Text(
                          "Apparel",
                          style: TextStyle(
                              color: const Color(0xff1569b4),
                              fontSize: allsize * 0.016,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Flexible(
                          child: Image.network(
                            "https://www.midtowncomics.com/images/PRODUCT/FUL/${provider.streamedData['DATA']['featureNewAdditionSection4']['pr_id']}_ful.jpg",
                            fit: BoxFit.contain,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.asset('assets/images/imagecomingsoon_ful.jpg',fit: BoxFit.contain,);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
