import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/creditcardprovider.dart';
import 'package:midtowncomics/widget/addCard.dart';
import 'package:midtowncomics/widget/editcart.dart';
import 'package:midtowncomics/widget/searchList.dart';

class MyCreditCard extends StatefulWidget {
  const MyCreditCard({super.key});

  @override
  State<MyCreditCard> createState() => _MyCreditCardState();
}

class _MyCreditCardState extends State<MyCreditCard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final streamedDataProvider =
    Provider.of<StreamedDataProvider>(context,
        listen: false);
    ApiRequests().LoadCreditCard(
        streamedDataProvider.loginuserdata['sh_id'], context);
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
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
        body: SingleChildScrollView(child:
            Consumer<CreditCardProvider>(builder: (context, credit, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchList(searchcontroller: searchController),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "My Credit Cards",
                    style: TextStyle(
                        fontFamily: 'oswald_bold',
                        fontSize: allsize * 0.02,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
              ListView.builder(
                  itemCount: credit.creditcardlist.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // bool defaultvalue=credit.creditcardlist[index]['is_default']=="0"?false:true;
                    return credit.creditcardlist.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListVieCardWidget(
                            allsize: allsize,
                            size: size,
                            index: index,
                          );
                  }),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xff006ccf), width: 3)),
                    child: Center(
                      child: Text(
                        "ADD NEW CARD",
                        style: TextStyle(
                            fontFamily: 'oswald_bold',
                            color: const Color(0xff006ccf),
                            fontSize: allsize * 0.015,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AddCard();
                    },
                  );
                },
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
                height: size.height * 0.015,
              )
            ],
          );
        })),
      ),
    );
  }
}

class ListVieCardWidget extends StatefulWidget {
  const ListVieCardWidget(
      {super.key,
      required this.allsize,
      required this.size,
      required this.index});

  final double allsize;
  final Size size;
  final index;

  @override
  State<ListVieCardWidget> createState() => _ListVieCardWidgetState();
}

class _ListVieCardWidgetState extends State<ListVieCardWidget> {
  bool defaultvalue = false;

  @override
  void initState() {
    defaultvalue = Provider.of<CreditCardProvider>(context, listen: false)
                .creditcardlist[widget.index]['is_default'] ==
            "0"
        ? false
        : true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreditCardProvider>(builder: (context, credit, child) {
      String CreditCard="";
      if(credit.creditcardlist[widget.index]['pm_cardtype']=="MC")
        {
          CreditCard=="Master Card";
        }
      else if(credit.creditcardlist[widget.index]['pm_cardtype']=="AX")
        {
          CreditCard="American Express";
        }
      else if(credit.creditcardlist[widget.index]['pm_cardtype']=="DI")
      {
        CreditCard="Discover";
      }
      else if(credit.creditcardlist[widget.index]['pm_cardtype']=="VI")
      {
        CreditCard="Visa Card";
      }
      defaultvalue = credit.creditcardlist[widget.index]['is_default'] == "0"
          ? false
          : true;
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.size.width*0.04,vertical: widget.size.height*0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CreditCard,
                      style: TextStyle(
                          color: const Color(0xff006ccf),
                          fontWeight: FontWeight.bold,
                          fontSize: widget.allsize * 0.0125),
                    ),
                    IconButton(
                        onPressed: () {
                          final streamedDataProvider =
                          Provider.of<StreamedDataProvider>(context,
                              listen: false);
                          ApiRequests().ProceedCard(

                              streamedDataProvider.loginuserdata['sh_id'],
                              credit.creditcardlist[widget.index]['pm_id'],
                              "dl",
                              context);
                        },
                        icon: Icon(
                          Icons.delete,
                          size: widget.allsize * 0.02,
                        ))
                  ],
                ),
                Text(
                  credit.creditcardlist[widget.index]['first_name'] +
                      " " +
                      credit.creditcardlist[widget.index]['last_name'],
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: widget.allsize * 0.0125),
                ),
                Text(
                  credit.creditcardlist[widget.index]['pm_cardnum'],
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: widget.allsize * 0.0125),
                ),
                Text(
                  "Exp. ${credit.creditcardlist[widget.index]['pm_expmnth']}/${credit.creditcardlist[widget.index]['pm_expyear']}",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: widget.allsize * 0.0125),
                ),
                SizedBox(
                  height: widget.size.height * 0.005,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditCard(
                          data: credit.creditcardlist[widget.index],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: widget.size.height * 0.06,
                    width: double.infinity,
                    color: const Color(0xff006ccf),
                    child: Center(
                      child: Text(
                        "EDIT CREDIT CARD",
                        style: TextStyle(
                          fontFamily: 'opensans_semibold',
                            color: Colors.white,
                            fontSize: widget.allsize * 0.015,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "DEFAULT ",
                      style: TextStyle(
                          color: const Color(0xff006ccf),
                          fontSize: widget.allsize * 0.01),
                    ),
                    Transform.scale(
                      scale: widget.allsize * 0.0006,
                      child: Switch(
                          activeColor: const Color(0xff006ccf),
                          value: defaultvalue,
                          onChanged: (value) {
                            final streamedDataProvider =
                            Provider.of<StreamedDataProvider>(context,
                                listen: false);
                            setState(() {
                              defaultvalue = value;
                              ApiRequests().ProceedCard(
                                  streamedDataProvider.loginuserdata['sh_id'],
                                  credit.creditcardlist[widget.index]['pm_id'],
                                  "df",
                                  context);
                            });
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
