
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/giftCardProvider.dart';
import 'package:midtowncomics/widget/searchList.dart';

class ManageGiftCards extends StatefulWidget {
  const ManageGiftCards({super.key});

  @override
  State<ManageGiftCards> createState() => _ManageGiftCardsState();
}

class _ManageGiftCardsState extends State<ManageGiftCards> {
  TextEditingController number=TextEditingController();
  TextEditingController pin=TextEditingController();
  TextEditingController searchController=TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final streamedDataProvider =
    Provider.of<StreamedDataProvider>(context, listen: false);
    ApiRequests().getGiftCardData(streamedDataProvider.loginuserdata['sh_id']);
    var size = MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:Size(size.width*1,allsize*0.11),
        child: Header_Widget(
          ontap: () => scaffoldKey.currentState!.openDrawer(),
          searchcontroller:searchController,
        ),),
      drawer: const Custom_drawer(),
      body: Consumer<GiftCardProvider>(
      builder: (context,gift, child) {
      return  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchList(searchcontroller: searchController),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
              child: Text(
                "Manage Gift Cards",
                style: TextStyle(
                    fontFamily: 'oswald_bold',
                    fontSize:allsize*0.02, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(allsize*0.005),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Claim Gift Cards",
                        style: TextStyle(
                            color: const Color(0xff006ccf),
                            fontSize: allsize*0.016,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Gift Card #",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: allsize*0.013),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.5,
                            child: TextFormField(
                              controller:number ,
                              decoration: InputDecoration(
                                  hintText: "123456 78901 23456",
                                  hintStyle:
                                  TextStyle(color: Colors.grey[500],fontSize: allsize*0.013)),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: TextFormField(
                              controller:pin,
                              decoration: InputDecoration(
                                  hintText: "PIN #",
                                  hintStyle:
                                  TextStyle(color: Colors.grey[500],fontSize: allsize*0.013)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height*0.01,),
                      InkWell(
                        onTap: (){
                          final streamedDataProvider =
                          Provider.of<StreamedDataProvider>(context,
                              listen: false);
                          ApiRequests().claimGiftCard(streamedDataProvider.loginuserdata['sh_id']
                              ,number.text, pin.text);
                        },
                        child: Container(
                          height: size.height * 0.06,
                          width: double.infinity,
                          color: const Color(0xff006ccf),
                          child:  Center(
                            child: Text(
                              "ADD GIFT CARD",
                              style: TextStyle(color: Colors.white, fontSize: allsize*0.017,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Gift Card Balance",style: TextStyle(
                          color: const Color(0xff006ccf),
                          fontWeight: FontWeight.w600,
                          fontSize: allsize*0.015
                      ),),
                    ),
                    SizedBox(height: size.height*0.01),
                    Table(
                      defaultColumnWidth:
                      FixedColumnWidth(size.width * 0.35),
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                              color: Color(0xffececec)),
                          children: [
                            Center(
                              child: Text(
                                'Card#',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Balance',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Memo',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Generate table rows
                        for (var item in gift.giftCardList)
                          TableRow(
                            children: [
                              Center(
                                child: Text(
                                  item['gc_num'],
                                  style: TextStyle(
                                      fontSize: allsize * 0.012),
                                ),
                              ),
                              Center(
                                child: Text(
                                  item['gc_bal'],
                                  style: TextStyle(
                                    fontSize: allsize * 0.012,
                                    // color: const Color(0xff006ccf),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  item['gc_design_name'],
                                  style: TextStyle(
                                      fontSize: allsize * 0.012),
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SubcribeWidget(),
            SizedBox(height: size.height*0.02,),
            const Footer(),
            SizedBox(
              height: size.height * 0.015,
            )
          ],
        ));
      }),
    );
  }
}
