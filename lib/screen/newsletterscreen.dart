// ignore_for_file: non_constant_identifier_names

import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/newsLetterProvider.dart';
import 'package:midtowncomics/widget/searchList.dart';

class NewsLetterScreen extends StatefulWidget {
  const NewsLetterScreen({super.key});

  @override
  State<NewsLetterScreen> createState() => _NewsLetterScreenState();
}

class _NewsLetterScreenState extends State<NewsLetterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController l_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController c_email = TextEditingController();
  bool weeklynewsletter = false;
  bool dailydealsnewsletter = false;
  bool backissuenews = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  void initState() {
    final streamProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    name.text = streamProvider.loginuserdata['sh_fname'];
    l_name.text = streamProvider.loginuserdata['sh_lname'];
    email.text = streamProvider.loginuserdata['sh_lgid'];
    c_email.text = streamProvider.loginuserdata['sh_lgid'];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final streamProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    ApiRequests().loadNewsLetterList(streamProvider.loginuserdata['sh_id'],streamProvider.loginuserdata['sh_lgid']);
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize:Size(size.width*1,allsize*0.11),
          child: Header_Widget(
            ontap: () => scaffoldKey.currentState!.openDrawer(),
            searchcontroller:searchController,
          ),),
        drawer: const Custom_drawer(),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchList(searchcontroller: searchController),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: size.width*0.01),
                  child: Text(
                    "Subscribe to our newsletter!",
                    style:
                    TextStyle(
                        fontFamily: 'oswald_bold',
                        fontSize: allsize*0.02, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        title: "First Name",
                        textEditingController: name,
                        optional: true, readOnly: false,),
                      TextFormFieldWidget(
                        title: "Last Name",
                    textEditingController: l_name,
                    optional: true,
                    readOnly: false,
                  ),
                      TextFormFieldWidget(
                        title: "Email Address",
                    textEditingController: email,
                    optional: true,
                    readOnly: false,
                  ),
                      TextFormFieldWidget(
                        title: "Confirm Email Address",
                    textEditingController: c_email,
                    optional: true,
                    readOnly: false,
                  ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      "Midtown Comics Newsletter",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: allsize * 0.015),
                    ),
                    Consumer<NewsLetterProvider>(
                        builder: (context, provider, child) {
                      return provider.indicator==false?
                        ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.newsLetterDataList.length,
                        itemBuilder: (context, index) {
                          bool isSubscribed =
                          provider.newsLetterDataList[index]['isSubscribed'] ;
                         // bool isTrue=provider.newsLetterDataList[index]['isSubscribed']=='false'?false:true;
                         // print(isTrue);
                          return Theme(
                            data: ThemeData(
                              unselectedWidgetColor: const Color(0xff006ccf), // Change the border color here
                            ),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor:const Color(0xff006ccf),
                              title: Transform.translate(
                                offset: const Offset(-20, 0),
                                child: Text(provider.newsLetterDataList[index]['nlName'],style: TextStyle(fontSize: allsize*0.012,),),
                              ),
                              contentPadding: EdgeInsets.all(allsize*0),
                              dense: true,
                              value:isSubscribed,
                              onChanged: (value) {
                                provider.updateSubscribeValue(value!,index);
                              },
                            ),
                          );
                        },
                      ): Center(child: Column(
                        children: [
                          SizedBox(height: size.height*0.01,),
                          const CircularProgressIndicator(),
                        ],
                      ),);
                    }),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InkWell(
                      onTap: (){
                        final streamedDataProvider =
                        Provider.of<StreamedDataProvider>(context,
                            listen: false);
                        final provider =
                        Provider.of<NewsLetterProvider>(context,
                            listen: false);
                        ApiRequests().subscribeToNewsLetter(streamedDataProvider.loginuserdata['sh_id'],email.text,c_email.text,name.text,l_name.text,provider.newsLetterDataList);
                      },
                      child: Container(
                        height: size.height * 0.06,
                        width: double.infinity,
                        color: const Color(0xff006ccf),
                        child: Center(
                          child: Text(
                            "SUBSCRIBE",
                            style: TextStyle(
                                    fontSize:allsize*0.016,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                    )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "Weekly Newsletter",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: allsize * 0.012),
                  ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "Sign up for our weekly newsletter for special savings, creator events, industry news and so much more, including"
                    " the most accurate new release list available in the industry, one"
                    " full week in advance! This newsletter goes out every Wednesday afternoon, and highlights "
                    "all of the new books and products to be released the following Wednesday.",
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: allsize * 0.012),
                  ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Daily Deals",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: allsize * 0.012),
                  ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "Sign up to be notified DAILY of our hot Deal of the Day! Save up to 70% on great items related to the hottest trends!",
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: allsize * 0.012),
                  ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Back Issue Newsletter",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: allsize * 0.012),
                  ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "This newsletter is perfect for those who want to know what's "
                    "new with what's old! We add tons of back issues to our site EVERY DAY, and in the"
                    " Back Issues Newsletter we let you know what's hot, what's relevant, and maybe help you find an "
                    "undiscovered series "
                    "to love! This newsletter goes out every Friday.",
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: allsize * 0.012),
                  ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Information that you supply to us:We store all of the information that you enter on midtowncomics.com for the purposes of shipping, so that you don't have to re-enter the same data with each order,"
                    " and responding to all of your requests.\n\n"
                    "Sharing information:Midtowncomics.com does not share your information with any third parties.\n\n"
                    "E-Mail communications:From time to time we send out e-mails informing our customers of hot new releases.\n\n"
                    "Security:We protect our customers information by using SSL encryption provided by GoDaddy , which ensure the highest level of protection when transmitting data across the internet. Furthermore, our Website servers are protected behind hardware and software firewalls and tested on a regular basis using industry"
                    " standard Web scanners to keep our severs and site protected from any malicious activity.",
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: allsize * 0.012),
                  ),
                    ],
                  ),
                ),
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
