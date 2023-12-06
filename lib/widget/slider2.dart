// ignore_for_file: non_constant_identifier_names

import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/faqProvider.dart';
import 'package:midtowncomics/screen/faqScreen.dart';
import 'package:midtowncomics/screen/shippingInformation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Slider2 extends StatefulWidget {
  const Slider2({super.key});

  @override
  State<Slider2> createState() => _Slider2State();
}

class _Slider2State extends State<Slider2> {
  List<IconData> Ico = [
    FontAwesomeIcons.truck,
    FontAwesomeIcons.shieldHalved,
    FontAwesomeIcons.store
  ];

  int _currentIndex = 0;

  @override
  faqGetFunction()async{
    final faq=Provider.of<FAQProvider>(context,listen: false);
    final streamedDataProvider =
    Provider.of<StreamedDataProvider>(context, listen: false);
    faq.updateGeneralInformation(await ApiRequests().faqApi( streamedDataProvider.loginuserdata.isEmpty ? "" :streamedDataProvider.loginuserdata['sh_id'], "GI"));
  }
  @override
  void initState() {
    faqGetFunction();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<StreamedDataProvider>(builder: (context, provider, child) {
      List<dynamic> data = [
        'FREE SHIPPING!',
        'FREE BAG AND BOARD',
        'FREE IN-STORE PICK UP'
      ];
      // provider.streamedData['DATA']['free3XMessagesSection'];
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: data.length, // Use the length of your data list
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                // Access the data from your list using itemIndex
                // final item = data[itemIndex];
                return Consumer<FAQProvider>(builder: (context,provider,child){
                  return  InkWell(
                    onTap: (){
                      if(itemIndex==0)
                      {
                        Get.to(const ShippingInformation());
                      }
                      else if(itemIndex==2)
                      {
                        Get.to(const InStorePickupScreen());
                      }
                      else if(itemIndex==1)
                      {
                        Get.to(FAQScreen(data:provider.generalInforamtionList, faqTopic: 'General Information',));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                          color: const Color(0xfff7f7f5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            Ico[itemIndex],
                            color: const Color(0xff1277d1),
                            size: allsize * 0.018,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text(
                            data[itemIndex],
                            style: TextStyle(
                                color: const Color(0xff1277d1),
                                fontFamily: 'opensans_semibold',
                                fontWeight: FontWeight.w900,
                                fontSize: allsize * 0.017),
                          )
                        ],
                      ),
                    ),
                  );
                });
              },
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                height: size.height * 0.04,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            AnimatedSmoothIndicator(
              duration: const Duration(milliseconds: 300),
              activeIndex: _currentIndex,
              count: data.length,
              effect:  WormEffect(
                paintStyle: PaintingStyle.stroke,
                dotColor: Colors.grey[600]!,
                dotHeight: allsize*0.012,
                dotWidth: allsize*0.012,
                strokeWidth: 1.5,
                activeDotColor: Colors.white,
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: data.asMap().entries.map((entry) {
            //     return Container(
            //       width: allsize * 0.013,
            //       height: allsize * 0.012,
            //       margin: const EdgeInsets.symmetric(horizontal: 4.0),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(
            //             color: _currentIndex == entry.key
            //                 ? Colors.grey[300]!
            //                 : Colors.grey[600]!),
            //         color: _currentIndex == entry.key
            //             ? Colors.white
            //             : Colors.transparent,
            //       ),
            //     );
            //   }).toList(),
            // ),
            SizedBox(height: size.height*0.03,)
          ],
        ),
      );
    });
  }
}
