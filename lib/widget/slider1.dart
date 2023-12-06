// ignore_for_file: library_private_types_in_public_api

import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/screen/ProductDetailPage.dart';
import 'package:midtowncomics/screen/landingPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Slider1 extends StatefulWidget {
  const Slider1({super.key});

  @override
  _Slider1State createState() => _Slider1State();
}

class _Slider1State extends State<Slider1> {
  int _currentIndex = 0;

  void _precacheImages(List<dynamic> imageUrls) {
    for (final imageUrl in imageUrls) {
      precacheImage(NetworkImage(imageUrl['img_url']), context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<StreamedDataProvider>(
      builder: (context, provider, child) {
        // Precache the images in the slider
        if(provider.slider1.isNotEmpty)
          {
            _precacheImages(provider.slider1);
          }
        return Container(
          color: Colors.white,
          // height: size.height * 0.34,
          child:
              provider.slider1.isEmpty?const Center(child: CircularProgressIndicator()):
          Column(
            children: [
              Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: provider.slider1.length, // Use the length of your data list
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      // Access the data from your list using itemIndex
                      final item = provider.slider1[itemIndex];
                      return InkWell(
                        onTap: ()async{
                         if(item['url_type']=="P")
                           {
                             provider.chanddetai({});
                             Get.to(ProductDetialPage(productid:item['search_object']['pr_id']));
                           }
                         else if(item['url_type']=="S")
                           {
                             provider. updatesearchselextion(item['search_object']['q']);
                             final streamedDataProvider =
                             Provider.of<StreamedDataProvider>(context, listen: false);
                              ApiRequests().SearchApi(streamedDataProvider.loginuserdata.isEmpty ? "" :streamedDataProvider.loginuserdata['sh_id'], item['search_object']['q'],"","10","","","","","","", "","", "", "", "", "","",false,"", context);
                             Get.to(const SearchPage());
                           }
                         else if(item['url_type']=="L")
                           {
                             Get.to(LandingPage());
                           }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              height: size.height * 0.25,
                              width: double.infinity,
                              child: Image.network(
                                  // Use the precached image instead of loading the image from the network directly
                                  item['img_url'],
                                  fit: BoxFit.fitHeight, loadingBuilder:
                                      (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                                errorBuilder: (context, exception, stackTrace) {
                                  return Image.asset('assets/images/imagecomingsoon_ful.jpg',fit: BoxFit.cover,);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      height: size.height * 0.25,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: size.height * 0.04,
                    left: size.width * 0.4,
                    child:
                    AnimatedSmoothIndicator(
                      duration: const Duration(milliseconds:300),
                      activeIndex: _currentIndex,
                      count: provider.slider1.length,
                      effect:  WormEffect(
                        paintStyle: PaintingStyle.stroke,
                        dotColor: Colors.grey[600]!,
                        dotHeight: allsize*0.012,
                        dotWidth: allsize*0.012,
                        strokeWidth: 1.5,
                        activeDotColor: Colors.white,
                      ),
                    )

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children:provider.slider1.asMap().entries.map((entry) {
                    //     return AnimatedContainer(
                    //       duration: const Duration(milliseconds:300),
                    //       width: allsize * 0.012,
                    //       height: allsize * 0.012,
                    //       curve: Curves.elasticIn,
                    //       margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         border:
                    //             Border.all(color: Colors.grey[700]!, width: 1),
                    //         color: _currentIndex == entry.key
                    //             ? Colors.white
                    //             : Colors.transparent,
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      provider.slider1[_currentIndex]['img_name'],
                      // Use the 'title' field from your data
                      style: TextStyle(
                        fontSize: allsize * 0.015,
                        // fontWeight: FontWeight.,
                          fontFamily: 'oswald_semi_bold'
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      provider.slider1[_currentIndex]['img_name_sub'],
                      // Use the 'title' field from your data
                      style: TextStyle(
                          fontSize: allsize * 0.012,
                        color: Colors.grey,
                        fontFamily: 'oswald_light'
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


