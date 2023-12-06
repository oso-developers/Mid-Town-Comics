

import 'package:midtowncomics/screen/shippingFaq.dart';
import 'package:midtowncomics/export.dart';

import '../provider/faqProvider.dart';
import '../screen/faqscreen.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  faqGetPullList()async{
    final faq=Provider.of<FAQProvider>(context,listen: false);
    final streamedDataProvider =
    Provider.of<StreamedDataProvider>(context, listen: false);
    faq.updatePullListInformationSection(await ApiRequests().faqApi(streamedDataProvider.loginuserdata.isEmpty ? "" :streamedDataProvider.loginuserdata['sh_id'], "PLI"));
  }
  faqGetPreview()async{
    final faq=Provider.of<FAQProvider>(context,listen: false);
    final streamedDataProvider =
    Provider.of<StreamedDataProvider>(context, listen: false);
    faq.updatePreviewIInformationSection(await ApiRequests().faqApi(streamedDataProvider.loginuserdata.isEmpty ? "" :streamedDataProvider.loginuserdata['sh_id'], "PREI"));
  }
  @override
  void initState() {
    faqGetPullList();
    faqGetPreview();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          //About Us
          Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                visualDensity: const VisualDensity(vertical: -4)
            ),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              title: Text(
                "ABOUT US",
                style: GoogleFonts.openSans(
                    color: const Color(0xff006ccf),
                    fontSize: allsize * 0.0113,
                    fontWeight: FontWeight.w600),
              ),
              onExpansionChanged: (value) {
                setState(() {
                  // isExpanded = value;
                });
              },
              children: [
                ListTile(
                  title: Text(
                    "CONTACT INFORMATION",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const ContactInformationScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "CUSTOMER TESTIMONIALS",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "SIGNING & EVENTS",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          //OUR Stories
          Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                visualDensity: const VisualDensity(vertical: -4)
            ),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              title: Text(
                "OUR STORIES",
                style: GoogleFonts.openSans(
                    color: const Color(0xff006ccf),
                    fontSize: allsize * 0.0113,
                    fontWeight: FontWeight.w600),
              ),
              onExpansionChanged: (value) {
                setState(() {
                  // isExpanded = value;
                });
              },
              children: <Widget>[
                ListTile(
                  title: Text(
                    "DOWNTOWN",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "GRAND CENTRAL",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "TIMES SQUARE",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "ASTORIA OUTLET",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          //Community
          Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                visualDensity: const VisualDensity(vertical: -4)
            ),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              title: Text(
                "COMMUNITY",
                style: GoogleFonts.openSans(
                    color: const Color(0xff006ccf),
                    fontSize: allsize * 0.0113,
                    fontWeight: FontWeight.w600),
              ),
              onExpansionChanged: (value) {
                setState(() {
                  // isExpanded = value;
                });
              },
              children: <Widget>[
                ListTile(
                  title: Text(
                    "BLOG",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "FACEBOOK",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "INSTAGRAM",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "TUMBLR",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "TWITTER",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "YOUTUBE",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          //My Accounts
          Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                visualDensity: const VisualDensity(vertical: -4)
            ),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              title: Text(
                "MY ACCOUNT",
                style: GoogleFonts.openSans(
                    color: const Color(0xff006ccf),
                    fontSize: allsize * 0.0113,
                    fontWeight: FontWeight.w600),
              ),
              onExpansionChanged: (value) {
                setState(() {
                  // isExpanded = value;
                });
              },
              children: <Widget>[
                ListTile(
                  title: Text(
                    "ORDER STATUS",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const MyOrderScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "ACCOUNT SETTINGS",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const MyAccountSetting());
                  },
                ),
                ListTile(
                  title: Text(
                    "SUBSCRIPTION SETTINGS",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const NewsLetterScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "CHECK GIFT CARD BALANCE",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const ManageGiftCards());
                  },
                ),
                Consumer<FAQProvider>(builder: (context,provider,child)
                    {
                      return ListTile(
                        title: Text(
                          "PULL LIST FAQ",
                          style: GoogleFonts.openSans(
                              fontSize: allsize * 0.0113,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Get.to(FAQScreen(data:provider.pullListInformationSectionList, faqTopic:"Pull List Information"));
                        },
                      );
                    }
                ),
                ListTile(
                  title: Text(
                    "PULL LIST",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const BrowsePullList());
                  },
                ),
                Consumer<FAQProvider>(builder: (context,providr,child)
                    {
                      return  ListTile(
                        title: Text(
                          "PREVIEWS FAQ",
                          style: GoogleFonts.openSans(
                              fontSize: allsize * 0.0113,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Get.to(FAQScreen(data:providr.preViewInformationSectionList, faqTopic:"Previews Information"));
                        },
                      );
                    }
                ),
                ListTile(
                  title: Text(
                    "PREVIEWS",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          //Customer Service
          Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                visualDensity: const VisualDensity(vertical: -4)
            ),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              title: Text(
                "CUSTOMER SERVICE",
                style: GoogleFonts.openSans(
                    color: const Color(0xff006ccf),
                    fontSize: allsize * 0.0113,
                    fontWeight: FontWeight.w600),
              ),
              onExpansionChanged: (value) {
                setState(() {
                  // isExpanded = value;
                });
              },
              children: <Widget>[
                ListTile(
                  title: Text(
                    "IN-STORE PICK-UP",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const InStorePickupScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "SITEMAP",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "FAQ",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.off(const AllFaqScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "PRIVACY POLICY",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const PrivacyPolicy());
                  },
                ),
                ListTile(
                  title: Text(
                    "UNSUBSCRIBE NEWSLETTER",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const NewsLetterScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "TERMS & CONDITIONS",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    "SHIPPING INFORMATION",
                    style: GoogleFonts.openSans(
                        fontSize: allsize * 0.0113,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Get.to(const ShippingFaqScreen());
                  },
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){},
                  child: Image.asset('assets/images/icon/facebook_50.png',height: allsize*0.025,width: allsize*0.025,)),              // IconButton(
              IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.twitter,
                      color: Colors.black, size: allsize * 0.02)),
              InkWell(
                  onTap: (){},
                  child: Image.asset('assets/images/icon/youtube_50.png',height: allsize*0.025,width: allsize*0.025,)),
              IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.instagram,
                      color: Colors.black, size: allsize * 0.02)),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            "All Site Content and 2018 Midtown Comics, unless otherwise noted\n All Right Reserved",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color(0xff006ccf), fontSize: allsize * 0.0097),
          )
        ],
      ),
    );
  }
}
