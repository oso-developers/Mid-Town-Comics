// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/customDropDownGrade.dart';

class CustomPrdoductDiallugue extends StatefulWidget {
  String productid;

  CustomPrdoductDiallugue({super.key, required this.productid});

  @override
  State<CustomPrdoductDiallugue> createState() =>
      _CustomPrdoductDiallugueState();
}

class _CustomPrdoductDiallugueState extends State<CustomPrdoductDiallugue> {
  bool change = false;
  String dropdownvalue = "1 in Cart";
  List<String> items = [];
  bool showDropdown = false;
  String image = "";

  int extractIntegerBeforeSpace(String text) {
    List<String> parts = text.split(" ");
    if (parts.isNotEmpty) {
      String value = parts.first;
      return int.tryParse(value) ??
          0; // Convert to int or default to 0 if not a valid integer.
    } else {
      return 0; // Default value if no space is found.
    }
  }

  Future<void> fetchData() async {
    final streamedDataProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    Map<String, dynamic> data =
        await ApiRequests().ProductDetail(streamedDataProvider.loginuserdata['sh_id'],widget.productid, context);
    streamedDataProvider.updateProductDetail(data);
    debugPrint(data.toString());
  }

  @override
  void initState() {
    image = widget.productid;
    // TODO: implement initState
    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<StreamedDataProvider>(builder: (context, provider, child) {


     // int.parse();
      return Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: allsize * 0.012, vertical: allsize * 0.01),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Padding(
              padding: EdgeInsets.all(allsize * 0.01),
              child: provider.detailpageindicator == true ||
                      provider.detail.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<StreamedDataProvider>(
                      builder: (context, provider, child) {
                        final dateFormat = DateFormat("M/d/yyyy");
                        DateTime dateTime = dateFormat.parse(
                            provider.productdetail['DATA']['prDetail']
                            ['pr_reldt']);
                        DateTime dateOnly = DateTime(dateTime.year,
                            dateTime.month, dateTime.day);
                        int  addedToWishList=0;
                        if(provider.detail['addedtowl']==null)
                        {
                          addedToWishList=0;
                        }
                        else{
                          addedToWishList=int.parse(provider.detail['addedtowl']);
                        }
                      dropdownvalue = int.parse(provider.detail['sc_qty']) == 0
                          ? "1 in Cart"
                          : '${provider.detail['sc_qty']} in Cart';
                      if (int.parse(provider.detail['pr_qty']) > 25) {
                        items =
                            FunctionClass().generateStringListFromInteger(25);
                      } else {
                        items = FunctionClass().generateStringListFromInteger(
                            int.parse(provider.detail['pr_qty']));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context, dropdownvalue);
                              },
                              icon: Icon(
                                CupertinoIcons.clear,
                                size: allsize * 0.02,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SizedBox(
                            height: size.height * 0.38,
                            child: Image.network(
                              "https://www.midtowncomics.com/images/PRODUCT/FUL/${image}_ful.jpg",
                              loadingBuilder: (BuildContext context,
                                  Widget child,
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
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            provider.detail['pr_ttle'],
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: allsize * 0.011,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("By: ",
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: allsize * 0.011,
                                                fontWeight: FontWeight.bold)),
                                        Flexible(
                                          child:
                                              Text(provider.detail['scg_name'],
                                                  style: TextStyle(
                                                    color: const Color(0xff006ccf),
                                                    fontSize: allsize * 0.011,
                                                  )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Writer: ",
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: allsize * 0.011,
                                                fontWeight: FontWeight.bold)),
                                        Flexible(
                                          child:
                                              Text(provider.detail['pr_writ'],
                                                  style: TextStyle(
                                                    color: const Color(0xff006ccf),
                                                    fontSize: allsize * 0.011,
                                                  )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Artist: ",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: allsize * 0.011,
                                                fontWeight: FontWeight.bold)),
                                        Flexible(
                                          child: Text(
                                            provider.detail['pr_artst'],
                                            style: TextStyle(
                                              color: const Color(0xff006ccf),
                                              fontSize: allsize * 0.011,
                                            ),
                                            overflow: TextOverflow.clip,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Release Date: ",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: allsize * 0.011,
                                                fontWeight: FontWeight.bold)),
                                        Flexible(
                                          child:
                                              Text("${dateOnly.year}-${dateOnly.day}-${dateOnly.month}",
                                                  style: TextStyle(
                                                    color: const Color(0xff006ccf),
                                                    fontSize: allsize * 0.011,
                                                  )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("ISBN: ",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: allsize * 0.011,
                                                fontWeight: FontWeight.bold)),
                                        Flexible(
                                          child: Text(
                                              provider.detail['isbn'] ?? '-',
                                              style: TextStyle(
                                                color: const Color(0xff006ccf),
                                                fontSize: allsize * 0.011,
                                              )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Diamond Code: ",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: allsize * 0.011,
                                                fontWeight: FontWeight.bold)),
                                        Flexible(
                                          child: Text(
                                              provider.detail['pre_code'] ??
                                                  "-",
                                              style: TextStyle(
                                                color: const Color(0xff006ccf),
                                                fontSize: allsize * 0.011,
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: provider.detail['pr_lprice'] ==
                                    provider.detail['pr_price']
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "\$${provider.detail['pr_lprice']}",
                                style: TextStyle(
                                    // decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.bold,
                                    fontSize: allsize * 0.0115),
                              ),
                              provider.detail['pr_lprice'] ==
                                      provider.detail['pr_price']
                                  ? Container()
                                  : Text(
                                      "\$${provider.detail['pr_price']}",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: allsize * 0.0115),
                                    ),
                              provider.detail['pr_lprice'] ==
                                      provider.detail['pr_price']
                                  ? Container()
                                  : Container(
                                      height: size.height * 0.03,
                                      width: size.width * 0.2,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red, width: 3),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          "${FunctionClass().findoff(provider.detail['pr_price'], provider.detail['pr_lprice'])}% OFF",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: allsize * 0.01,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          provider.detail['pr_is_backissue'] == "0"
                              ? Container()
                              : CustomDropDownGrade(
                                  items: provider.grades,
                                  onTapCallback: (item) {
                                    provider
                                        .setgroupvalue(item['condition_name']);
                                    widget.productid = item['pr_id'];
                                    provider.updatedetailongrades({
                                      "pr_id": item['pr_id'],
                                      "pr_price": item['pr_price'],
                                      "pr_lprice": item['pr_lprice'],
                                      "pr_advord": item['pr_advord'],
                                      "pr_qty": item['pr_qty']
                                    });
                                  },
                                  groupValue: provider.groupvalue,
                                  sizeValue: 0.047,
                                  name: 'condition_name',
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          if (provider.detail['in_cart'] == "0" || change)
                            change
                                ? const Center(
                                    child:
                                        CircularProgressIndicator(), // Show a circular progress indicator while loading
                                  )
                                : showDropdown
                                    ? CustomDropDownGrade(
                                        items: items,
                                        onTapCallback: (item) async {
                                          setState(() {
                                            if (item == '-Remove-') {
                                              showDropdown = false;
                                              dropdownvalue = '1 in Cart';
                                            }
                                            dropdownvalue = item;
                                          });
                                          final streamedDataProvider =
                                              Provider.of<StreamedDataProvider>(
                                                  context,
                                                  listen: false);
                                          int value1 =
                                              extractIntegerBeforeSpace(item);
                                          // ApiRequests().Savedata(widget.productid,item == "-Remove-" ? "0" : value1.toString(), context);
                                          var request = http.Request(
                                              'GET',
                                              Uri.parse(
                                                  'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${streamedDataProvider.loginuserdata['sh_id']}&pr_id=${widget.productid}&sc_qty=${item == "-Remove-" ? "0" : value1.toString()}&app_id='));
                                          http.StreamedResponse response =
                                              await request.send();
                                          if (response.statusCode == 200) {
                                            final data = await response.stream
                                                .bytesToString();
                                            streamedDataProvider.updateCartData(
                                                jsonDecode(data));
                                            Map<String, dynamic> datache =
                                                jsonDecode(data);
                                          } else {
                                            // debugPrint(response.reasonPhrase);
                                          }
                                          provider.updatedetail(
                                              item == "-Remove-" ? "0" : "1",
                                              value1.toString());
                                          provider.call(
                                              widget.productid,
                                              item == "-Remove-" ? "0" : "1",
                                              value1.toString(),provider.detail['addedtowl']);
                                        },
                                        groupValue: dropdownvalue,
                                        sizeValue: 0.07,
                                        name: ""):
                                int.parse(provider.detail['pr_qty'])==0?
                        InkWell(
                          child: Container(
                          height: size.height * 0.06,
                          color:addedToWishList>0?Colors.grey:Colors.red,
                          child: Center(
                          child: Text(
                            addedToWishList>0?"Added to Wish List":
                           "ADD TO WISH LIST",
                          style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: allsize * 0.012),
                          )),
                          ),
                          onTap: (){
                            if( int.parse(provider.detail['addedtowl'])>0)
                              {
                                Get.to(const MyWishListScreen());
                              }
                            {
                              final streamedDataProvider =
                              Provider.of<StreamedDataProvider>(context,
                                  listen: false);
                              ApiRequests().saveToWishList(streamedDataProvider.loginuserdata['sh_id']
                                  , provider.detail['pr_parentid']);
                              streamedDataProvider.updateWishListDetail();
                              streamedDataProvider.call(provider.detail['pr_id'],provider.detail['in_cart'],provider.detail['sc_qty'], "1");
                            }

                          },
                        )
                                    :
                            InkWell(
                                        onTap: () async {
                                          if (provider.loginuserdata.isEmpty) {
                                            Get.to(const SignInScreen());
                                          } else {
                                            provider.call(
                                                provider.detail['pr_id'],
                                                "1",
                                                "1",provider.detail['addedtowl']);
                                            provider.updatedetail("1", "1");
                                            setState(() {
                                          change =
                                          true; // Set the loading flag to true
                                        });

                                        // Make your API request
                                        final streamedDataProvider =
                                        Provider.of<StreamedDataProvider>(
                                            context,
                                            listen: false);
                                        Map<String, dynamic> data =
                                        await ApiRequests().Savedata(
                                            streamedDataProvider.loginuserdata['sh_id'],
                                            provider.detail['pr_id'],
                                            1,
                                            context);

                                        setState(() {
                                          change =
                                          false; // Set the loading flag to false when the API request is done
                                          showDropdown =
                                          true; // Show the dropdown after the button is pressed
                                            });
                                            streamedDataProvider
                                                .updateCartData(data);
                                          }
                                        },
                                        child: ButtonWidget(
                                          quan: provider.detail['pr_qty'],
                                          preorder:
                                              provider.detail['pr_advord'],
                                        ),
                                      )
                          else
                            CustomDropDownGrade(
                                items: items,
                                onTapCallback: (item) async {
                                  setState(() {
                                    if (item == '-Remove-') {
                                      showDropdown = false;
                                      dropdownvalue = '1 in Cart';
                                    }
                                    dropdownvalue = item;
                                  });
                                  final streamedDataProvider =
                                      Provider.of<StreamedDataProvider>(context,
                                          listen: false);
                                  int value1 = extractIntegerBeforeSpace(item);
                                  // ApiRequests().Savedata(widget.productid,item == "-Remove-" ? "0" : value1.toString(), context);
                                  var request = http.Request(
                                      'GET',
                                      Uri.parse(
                                          'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${streamedDataProvider.loginuserdata['sh_id']}&pr_id=${widget.productid}&sc_qty=${item == "-Remove-" ? "0" : value1.toString()}&app_id='));
                                  http.StreamedResponse response =
                                      await request.send();
                                  if (response.statusCode == 200) {
                                    final data =
                                        await response.stream.bytesToString();
                                    streamedDataProvider
                                        .updateCartData(jsonDecode(data));
                                    Map<String, dynamic> datache =
                                        jsonDecode(data);
                                  } else {
                                    // debugPrint(response.reasonPhrase);
                                  }
                                  provider.updatedetail(
                                      item == "-Remove-" ? "0" : "1",
                                      value1.toString());
                                  provider.call(
                                      widget.productid,
                                      item == "-Remove-" ? "0" : "1",
                                      value1.toString(),provider.detail['addedtowl']);
                                },
                                groupValue: dropdownvalue,
                                sizeValue: 0.07,
                                name: ""),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          provider.detail['su_id'] == "0"
                              ? Container()
                              : provider.detail['issubscribe'] == "0"
                                  ? InkWell(
                                      child: Container(
                                        height: size.height * 0.06,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                            color: const Color(0xff006ccf),
                                            width: allsize * 0.003)),
                                    child: Center(
                                      child: Text(
                                        'ADD TO PULL LIST',
                                        style: TextStyle(
                                            color: const Color(0xff006ccf),
                                            fontSize: allsize * 0.012,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                            onTap: (){
                           final streamedDataProvider=   Provider.of<
                                  StreamedDataProvider>(
                                  context,
                                  listen: false);
                                    if (provider.loginuserdata.isEmpty) {
                                      Get.to(const SignInScreen());
                                    } else {
                                      ApiRequests().SavePullList(
                                          streamedDataProvider
                                              .loginuserdata['sh_id'],
                                          provider.detail['su_id'],
                                          "1",
                                          "0",
                                          provider.detail['pr_id'],
                                          context);
                                    }
                                  },
                              )
                              :
                          InkWell(
                            child: Container(
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff006ccf),
                                      width: allsize * 0.003)),
                              child: Center(
                                child: Text(
                                  'ADDED TO PULL LIST',
                                  style: TextStyle(
                                      color: const Color(0xff006ccf),
                                      fontSize: allsize * 0.012,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: (){
                            },
                          )
                        ],
                      );
                    })));
    });
  }
}



