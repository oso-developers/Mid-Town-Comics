
import 'package:midtowncomics/widget/searchList.dart';

import '../widget/featurenewrelease.dart';
import 'package:midtowncomics/export.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
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
        body: SingleChildScrollView(child: Consumer<StreamedDataProvider>(
            builder: (context, provider, child) {
              return Column(
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
                            "BOOKS",
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
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // height: size.height * 0.48,
                      child: Column(
                        children: [
                          Text("Today's Best Seller",
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
                                (provider.featurenewrelease.length /
                                    2)
                                    .ceil(),
                                // Display two items per page
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, pageIndex) {
                                  FunctionClass().precacheImages(
                                      provider.featurenewrelease,
                                      context);
                                  final startIndex = pageIndex * 2;
                                  final endIndex = startIndex + 2;

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.013),
                                    child: Row(
                                      mainAxisAlignment: endIndex <=
                                          provider.featurenewrelease
                                              .length
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.start,
                                      children: [
                                        for (var index = startIndex;
                                        index < endIndex;
                                        index++)
                                          if (index <
                                              provider.featurenewrelease
                                                  .length)
                                            SizedBox(
                                              // width: size.width * 0.47962,
                                              // Adjust the width as needed
                                              child: FeatureNewRelease(
                                                adultimage: provider
                                                    .featurenewrelease[
                                                index]['hideadultimage'],
                                                pulllist: provider
                                                    .featurenewrelease[
                                                index]['su_id'],
                                                image: provider
                                                    .featurenewrelease[
                                                index]['pr_id'],
                                                title: provider
                                                    .featurenewrelease[
                                                index]['pr_ttle'],
                                                prce1: provider
                                                    .featurenewrelease[
                                                index]['pr_price'],
                                                price2: provider
                                                    .featurenewrelease[
                                                index]['pr_lprice'],
                                                preorder: provider
                                                    .featurenewrelease[
                                                index]['pr_advord'],
                                                quantity: int.parse(provider
                                                    .featurenewrelease[
                                                index]['pr_qty']),
                                                incart: int.parse(provider
                                                    .featurenewrelease[
                                                index]['in_cart']),
                                                productquantity:
                                                int.parse(provider
                                                    .featurenewrelease[
                                                index]['pr_qty']),
                                                qtycart: int.parse(provider
                                                    .featurenewrelease[
                                                index]['sc_qty']),
                                                data: provider
                                                .featurenewrelease[
                                                index], parentid: provider
                                                  .featurenewrelease[
                                              index]['pr_parentid'],
                                                addedtowl:int.parse(provider
                                                    .featurenewrelease[
                                                index]['addedtowl']),
                                              ),
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
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // height: size.height * 0.48,
                      child: Column(
                        children: [
                          Text("Featured Advance Orders",
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
                                (provider.recomendedpreorder.length /
                                    2)
                                    .ceil(),
                                // Display two items per page
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, pageIndex) {
                                  FunctionClass().precacheImages(
                                      provider.recomendedpreorder,
                                      context);
                                  final startIndex = pageIndex * 2;
                                  final endIndex = startIndex + 2;

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.013),
                                    child: Row(
                                      mainAxisAlignment: endIndex <=
                                          provider.recomendedpreorder
                                              .length
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.start,
                                      children: [
                                        for (var index = startIndex;
                                        index < endIndex;
                                        index++)
                                          if (index <
                                              provider.recomendedpreorder
                                                  .length)
                                            SizedBox(
                                              // width: size.width * 0.47962,
                                              // Adjust the width as needed
                                              child: FeatureNewRelease(
                                                adultimage: provider
                                                    .recomendedpreorder[
                                                index]['hideadultimage'],
                                                pulllist: provider
                                                    .recomendedpreorder[
                                                index]['su_id'],
                                                image: provider
                                                    .recomendedpreorder[
                                                index]['pr_id'],
                                                title: provider
                                                    .recomendedpreorder[
                                                index]['pr_ttle'],
                                                prce1: provider
                                                    .recomendedpreorder[
                                                index]['pr_price'],
                                                price2: provider
                                                    .recomendedpreorder[
                                                index]['pr_lprice'],
                                                preorder: provider
                                                    .recomendedpreorder[
                                                index]['pr_advord'],
                                                quantity: int.parse(provider
                                                    .recomendedpreorder[
                                                index]['pr_qty']),
                                                incart: int.parse(provider
                                                    .recomendedpreorder[
                                                index]['in_cart']),
                                                productquantity:
                                                int.parse(provider
                                                    .recomendedpreorder[
                                                index]['pr_qty']),
                                                qtycart: int.parse(provider
                                                    .recomendedpreorder[
                                                index]['sc_qty']),
                                                data: provider
                                                    .recomendedpreorder[
                                                index], parentid: provider
                                                  .recomendedpreorder[
                                              index]['pr_parentid'], addedtowl: int.parse(provider
                                                  .recomendedpreorder[
                                              index]['addedtowl']),
                                              ),
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
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  ListView.builder(
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (item, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
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
                                        fontSize: allsize * 0.025,
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
              );
            })),
      ),
    );
  }
}
