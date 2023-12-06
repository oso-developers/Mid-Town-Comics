
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/creditcardprovider.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController creditCardNumber=TextEditingController();

  String selectedCard="MasterCard";
  String creditCardValue="";
  String selectedMonth="January";
  String selectedMonthNumber="1";
  String selectedYear="2023";
  List<String> generateYearList() {
    int currentYear = DateTime.now().year;
    List<String> years = [];
    for (int i = 0; i < 8; i++) {
      years.add((currentYear + i).toString());
    }
    return years;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return
      Consumer<CreditCardProvider>(
          builder: (context,credit, child) {
            return Dialog(
                insetPadding:EdgeInsets.symmetric(horizontal:allsize*0.012,vertical: allsize*0.01),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height*1,
                    child: Padding(
                      padding: EdgeInsets.all(allsize*0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Manage Credit Card",style: TextStyle(fontSize:allsize*0.023,fontWeight: FontWeight.w600),),
                          SizedBox(height: size.height*0.015,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/icons/icons8_visa_48.png'),
                              Image.asset('assets/icons/icons8_mastercard_48.png'),
                              Image.asset('assets/icons/icons8_discover_48.png'),
                              Image.asset('assets/icons/icons8_american_express_48.png')
                            ],
                          ),
                          TextFormFieldWidget(
                            title: "First Name",
                            textEditingController: firstName,
                            optional: false, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title: "Last Name",
                            textEditingController: lastName,
                            optional: false, readOnly: false,
                          ),
                          Row(
                            children: [
                              Text("*",style:  TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: allsize*0.011),),
                              Flexible(child: Text("Credit Card Type",style:  TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: allsize*0.012),)),
                            ],
                          ),
                          SizedBox(height: size.height*0.01,),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext
                                context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        allsize *
                                            0.016,
                                        vertical:
                                        allsize *
                                            0.04),
                                    child:
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize:
                                        MainAxisSize
                                            .min,
                                        children: credit.cardData
                                            .map<Widget>(
                                                (dynamic
                                            item) {
                                              return ListTile(
                                                title: Text(
                                                    item['card']),
                                                onTap:
                                                    () async {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    selectedCard=item['card'];
                                                    creditCardValue=item['id'];
                                                  });
                                                    }
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height:
                              size.height * 0.045,
                              width: size.width*1,
                              decoration: BoxDecoration(
                                  color:
                                  Colors.grey[300]),
                              padding:
                              const EdgeInsets.all(
                                  8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                   selectedCard,
                                    style: TextStyle(
                                        fontSize:
                                        allsize *
                                            0.012),
                                  ),
                                  Icon(
                                    Icons
                                        .arrow_drop_down,
                                    size:
                                    allsize * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: size.height*0.01,),
                          TextFormFieldWidget(
                            title: "Credit Card Number",
                            textEditingController: creditCardNumber,
                            optional: false, readOnly: false,
                          ),
                          Row(
                            children: [
                              Text("*",style:  TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: allsize*0.011),),
                              Flexible(child: Text("Expiration",style:  TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: allsize*0.012),)),
                            ],
                          ),
                          SizedBox(height: size.height*0.01,),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext
                                    context) {
                                      return Dialog(
                                        insetPadding: EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            allsize *
                                                0.016,
                                            vertical:
                                            allsize *
                                                0.04),
                                        child:
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize
                                                .min,
                                            children: credit.month
                                                .map<Widget>(
                                                    (dynamic
                                                item) {
                                                  return ListTile(
                                                      title: Text(
                                                          item['year']),
                                                      onTap:
                                                          () async {
                                                            setState(() {
                                                              selectedMonthNumber=item['id'];
                                                              selectedMonth=item['year'];
                                                            });
                                                            Navigator.pop(context);
                                                      }
                                                  );
                                                }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height:
                                  size.height * 0.045,
                                  width: size.width*0.49,
                                  decoration: BoxDecoration(
                                      color:
                                      Colors.grey[300]),
                                  padding:
                                  const EdgeInsets.all(
                                      8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        selectedMonth,
                                        style: TextStyle(
                                            fontSize:
                                            allsize *
                                                0.012),
                                      ),
                                      Icon(
                                        Icons
                                            .arrow_drop_down,
                                        size:
                                        allsize * 0.02,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width*0.03,),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext
                                    context) {
                                      return Dialog(
                                        insetPadding: EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            allsize *
                                                0.016,
                                            vertical:
                                            allsize *
                                                0.04),
                                        child:
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize
                                                .min,
                                            children:generateYearList()
                                                .map<Widget>(
                                                    (String
                                                item) {
                                                  return ListTile(
                                                      title: Text(
                                                          item),
                                                      onTap:
                                                          () async {
                                                            setState(() {
                                                              selectedYear=item;
                                                            });
                                                            Navigator.pop(context);
                                                      }
                                                  );
                                                }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height:
                                  size.height * 0.045,
                                  width: size.width*0.25,
                                  decoration: BoxDecoration(
                                      color:
                                      Colors.grey[300]),
                                  padding:
                                  const EdgeInsets.all(
                                      8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        selectedYear,
                                        style: TextStyle(
                                            fontSize:
                                            allsize *
                                                0.012),
                                      ),
                                      Icon(
                                        Icons
                                            .arrow_drop_down,
                                        size:
                                        allsize * 0.02,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height*0.015,),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("CANCEL",style: TextStyle(color: Colors.red,fontSize: allsize*0.012,fontWeight: FontWeight.bold),)),
                                SizedBox(width: size.width*0.06,),
                                TextButton(onPressed: (){
                                  final streamedDataProvider =
                                  Provider.of<StreamedDataProvider>(context,
                                      listen: false);
                                  ApiRequests().SaveCardData(streamedDataProvider.loginuserdata['sh_id'],firstName.text,lastName.text,"0",creditCardValue,creditCardNumber.text,selectedMonthNumber,selectedYear, context);
                                }, child: Text("SAVE",style: TextStyle(color: const Color(0xff006ccf,),fontSize: allsize*0.012,fontWeight: FontWeight.bold),)),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height*0.02,),
                        ],
                      ),
                    ),
                  ),
                ));
          });

  }
}
