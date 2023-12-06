// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:midtowncomics/export.dart';

class ListViewBuilderWidget extends StatefulWidget {
  ListViewBuilderWidget(
      {super.key,
      required this.size,
      required this.allsize,
      required this.index,
      });

  final Size size;
  final double allsize;
  // Map<String,dynamic>data;
  int index;
  @override
  State<ListViewBuilderWidget> createState() => _ListViewBuilderWidgetState();
}

class _ListViewBuilderWidgetState extends State<ListViewBuilderWidget> {
  bool change = false;
  bool showdialugue = false;
  String dropdownValue = '1 in Cart';
  List<String> item = [];
  List<dynamic> group = [];
  String groupvalue = "";
  String imagedata = "";
  List<dynamic> size=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizea=MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: widget.size.width * 0.35,
                    child: Image.network(
                      Provider.of<StreamedDataProvider>(context,listen: false).returnproduct[widget.index]['hideadultimage'] == '0'
                          ?   "https://www.midtowncomics.com/images/PRODUCT/FUL/${Provider.of<StreamedDataProvider>(context,listen: false).manageimage[widget.index]}_ful.jpg"
                          : 'https://www.midtowncomics.com/images/PRODUCT/FUL/adults_ful.jpg',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return  Center(
                              child: Image.asset('assets/images/imagecomingsoon_ful.jpg')
                              // CircularProgressIndicator()
                          );
                        }
                      },
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset('assets/images/imagecomingsoon_ful.jpg',fit: BoxFit.contain,);
                      },
                      // fit: BoxFit.fill,
                    )),
              ),
              Consumer<StreamedDataProvider>(
                  builder: (context, provider, child) {
                if (int.parse(
                        provider.returnproduct[widget.index]['pr_qty'] == "0"
                            ? "1"
                            : provider.returnproduct[widget.index]['pr_qty']) >
                    25) {
                  item = FunctionClass().generateStringListFromInteger(25);
                } else {
                  item = FunctionClass().generateStringListFromInteger(
                      int.parse(
                          provider.returnproduct[widget.index]['pr_qty'] == "0"
                              ? "1"
                              : provider.returnproduct[widget.index]
                                  ['pr_qty']));
                }
                dropdownValue = int.parse(
                            provider.returnproduct[widget.index]['sc_qty']) ==
                        0
                    ? "1 in Cart"
                    : '${provider.returnproduct[widget.index]['sc_qty']} in Cart';
                final dateFormat = DateFormat("M/d/yyyy");
                DateTime dateTime = dateFormat
                    .parse(provider.returnproduct[widget.index]['pr_reldt']);
                DateTime dateOnly =
                    DateTime(dateTime.year, dateTime.month, dateTime.day);
                group = provider.returnproduct[widget.index]['grades'];
                size=provider.returnproduct[widget.index]['sizes'];
                groupvalue = groupvalue == ""
                    ? FunctionClass().searchgradevalue(
                        provider.returnproduct[widget.index]['pr_id'], group)
                    : groupvalue;
                return Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.returnproduct[widget.index]["su_id"] == "0"
                            ? Container()
                            : ClipPath(
                                clipper: CustomClipPath(),
                                child: Container(
                                  height: widget.size.height * 0.025,
                                  width: widget.size.width * 0.35,
                                  color: const Color(0xff006ccf),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "Available for pull list!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: widget.allsize * 0.01),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: widget.size.height * 0.01,
                        ),
                        Text(
                          provider.returnproduct[widget.index]['pr_ttle'],
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: widget.allsize * 0.012,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: widget.size.height * 0.01,
                        ),
                        Row(
                          children: [
                               Text(
                              "By ",
                              style: TextStyle(color: Colors.grey,fontSize: widget.allsize*0.011),
                            ),
                            Flexible(
                              child: Text(
                                provider.returnproduct[widget.index]['mn_name'],
                                style: TextStyle(color: Colors.blue,fontSize: widget.allsize*0.011),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: widget.size.height * 0.01,
                        ),
                        Row(
                          children: [
                               Text(
                              "Release Date ",
                              style: TextStyle(color: Colors.grey,fontSize: widget.allsize*0.011),
                            ),
                            Flexible(
                              child: Text(
                                "${dateOnly.day}-${dateOnly.month}-${dateOnly.year}",
                                style:  TextStyle(color: Colors.blue,fontSize: widget.allsize*0.011),
                              ),
                            )
                          ],
                        ),
                        group.isNotEmpty||size.isNotEmpty?
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: widget.allsize * 0.016,
                                      vertical: widget.allsize * 0.04),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: group
                                          .map<Widget>((dynamic item) {
                                        return ListTile(
                                          title: Text(
                                              item['condition_name']),
                                          onTap: () async {
                                            debugPrint(item['pr_id']);
                                            provider
                                                .updatereturnproductforgrade(
                                                provider.returnproduct[
                                                widget.index]
                                                ['pr_id'],
                                                item['pr_id'],
                                                item['pr_price'],
                                                item['pr_lprice'],
                                                item['pr_advord'],
                                                item['pr_qty']);
                                            setState(() {
                                              groupvalue =
                                              item['condition_name'];
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: widget.allsize*0.033,
                            decoration:
                            BoxDecoration(color: Colors.grey[300]),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  groupvalue,
                                  style: TextStyle(
                                      fontSize: widget.allsize * 0.014),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: widget.allsize * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ):Container(),
                        SizedBox(
                          height: widget.size.height * 0.02,
                        ),
                        Text(
                          "\$${provider.returnproduct[widget.index]['pr_lprice']}",
                          style: TextStyle(
                              fontSize: widget.allsize * 0.011,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: widget.size.height * 0.005,
                        ),
                        provider.returnproduct[widget.index]['pr_price'] ==
                                provider.returnproduct[widget.index]
                                    ['pr_sol_lprice']
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${provider.returnproduct[widget.index]['pr_price']}",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontSize: widget.allsize * 0.011),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // print(
                                        //     provider.returnproduct[widget.index]
                                        //         ['pr_id']);
                                        debugPrint(
                                            provider.returnproduct[widget.index]
                                            ['in_cart']);
                                        debugPrint(provider.returnproduct.toString());
                                        // print(
                                        //     provider.returnproduct[widget.index]
                                        //         ['sizes']);
                                        // print(
                                        //     provider.returnproduct[widget.index]
                                        //     ['grades']);
                                        // print(  provider.returnproduct[widget.index]
                                        // ['pr_is_backissue']);
                                      },
                                      child: Container(
                                        height: widget.size.height * 0.035,
                                        width: widget.size.width * 0.25,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 3),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            "${FunctionClass().findoff(provider.returnproduct[widget.index]['pr_price'], provider.returnproduct[widget.index]['pr_lprice'])}% OFF",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize:
                                                    widget.allsize * 0.012,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: widget.size.height * 0.01,
                        ),
                        if (provider.returnproduct[widget.index]['in_cart'] ==
                                "0" ||
                            change)
                          change
                              ? const Center(
                                  child:
                                      CircularProgressIndicator(), // Show a circular progress indicator while loading
                                )
                              : showdialugue
                                  ? InkWell(
                                      onTap: () {
                                        provider.loginuserdata.isEmpty
                                            ? Get.to(const SignInScreen())
                                            : showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                widget.allsize *
                                                                    0.016,
                                                            vertical:
                                                                widget.allsize *
                                                                    0.04),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: item
                                                            .map<Widget>(
                                                                (String item) {
                                                          return ListTile(
                                                            title: Text(item),
                                                            onTap: () async {
                                                              setState(() {
                                                                if (item ==
                                                                    '-Remove-') {
                                                                  showdialugue = false;
                                                                  dropdownValue = '1 in Cart';
                                                                  provider.call(provider.returnproduct[widget.index]['pr_id'], "0", "1",provider.returnproduct[widget.index]['addedtowl']);
                                                                  provider.updatereturnproduct(provider.returnproduct[widget.index]['pr_id'], "0", "1",provider.returnproduct[widget.index]['addedtowl']);
                                                                  // provider.updatedetail("0", "1");
                                                                }
                                                                dropdownValue =
                                                                    item;
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              final streamedDataProvider =
                                                                  Provider.of<
                                                                          StreamedDataProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              int value1 =
                                                                  FunctionClass()
                                                                      .extractIntegerBeforeSpace(
                                                                          item);
                                                              // ApiRequests().Savedata(widget.productid,item == "-Remove-" ? "0" : value1.toString(), context);
                                                              var request =
                                                                  http.Request(
                                                                      'GET',
                                                                      Uri.parse(
                                                                          'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${ streamedDataProvider.loginuserdata['sh_id']}&pr_id=${provider.returnproduct[widget.index]['pr_id']}&sc_qty=${item == "-Remove-" ? "0" : value1}&app_id='));
                                                              http.StreamedResponse
                                                                  response =
                                                                  await request
                                                                      .send();
                                                              if (response
                                                                      .statusCode ==
                                                                  200) {
                                                                final data =
                                                                    await response
                                                                        .stream
                                                                        .bytesToString();
                                                                streamedDataProvider
                                                                    .updateCartData(
                                                                        jsonDecode(
                                                                            data));
                                                                debugPrint(data);
                                                                Map<String,
                                                                        dynamic>
                                                                    datache =
                                                                    jsonDecode(
                                                                        data);
                                                                debugPrint(datache[
                                                                        'DATA'][
                                                                    'cartList']);
                                                              } else {
                                                                debugPrint(response
                                                                    .reasonPhrase);
                                                              }
                                                              provider.updatedetail(
                                                                  "1",
                                                                  value1
                                                                      .toString());
                                                              provider.call(
                                                                  provider.returnproduct[
                                                                          widget
                                                                              .index]
                                                                      ['pr_id'],
                                                                  "1",
                                                                  value1
                                                                      .toString(),provider.returnproduct[widget.index]['addedtowl']);
                                                              provider.updatereturnproduct(
                                                                  provider.returnproduct[
                                                                          widget
                                                                              .index]
                                                                      ['pr_id'],
                                                                  "1",
                                                                  value1
                                                                      .toString(),provider.returnproduct[widget.index]['addedtowl']);
                                                            },
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                      },
                                      child: CustomDropDown(
                                          size: widget.size,
                                          dropdownValue: dropdownValue,
                                          allsize: widget.allsize),
                                    ):
                          int.parse( provider.returnproduct[widget.index]
                          ['pr_qty'])==0?
                          InkWell(
                            child: Container(
                              height: sizea.height * 0.06,
                              color: int.parse(provider.returnproduct[widget.index]['addedtowl'])>0?Colors.grey:Colors.red,
                              child: Center(
                                  child: Text(
                                    int.parse(provider.returnproduct[widget.index]['addedtowl'])>0?"ADDED TO WISH LIST":
                                    "ADD TO WISH LIST",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: allsize * 0.012),
                                  )),
                            ),
                            onTap: (){
                              if( int.parse(provider.returnproduct[widget.index]['addedtowl'])>0)
                              {
                                Get.to(const MyWishListScreen());
                              }
                              {
                                final streamedDataProvider =
                                Provider.of<StreamedDataProvider>(context,
                                    listen: false);
                                ApiRequests().saveToWishList(streamedDataProvider.loginuserdata['sh_id']
                                    , provider.returnproduct[widget.index]['pr_parentid']);
                                streamedDataProvider.updateWishListDetail();
                                streamedDataProvider.call(provider.returnproduct[widget.index]['pr_id'],provider.returnproduct[widget.index]['in_cart'],provider.returnproduct[widget.index]['sc_qty'], "1");
                                provider.updatereturnproduct(provider.returnproduct[widget.index]['pr_id'],provider.returnproduct[widget.index]['in_cart'],provider.returnproduct[widget.index]['sc_qty'], "1");
                              }
                            },
                          )
                                  : InkWell(
                                      onTap: () async {
                                        int quantity = int.parse(provider.returnproduct[widget.index]['pr_qty']);
                                        if (quantity == 0 || quantity < 0) {
                                          debugPrint('WhishList');
                                        } else {
                                          if (provider.loginuserdata.isEmpty) {
                                            Get.to(const SignInScreen());
                                          } else {
                                            provider.call(
                                                provider.returnproduct[
                                                    widget.index]['pr_id'],
                                                "1",
                                                "1",provider.returnproduct[widget.index]['addedtowl']);
                                            provider.updatereturnproduct(provider.returnproduct[widget.index]['pr_id'], "1", "1",provider.returnproduct[widget.index]['addedtowl']);
                                            provider.updatedetail("1", "1");
                                            setState(() {
                                              change =
                                                  true; // Set the loading flag to true
                                            });
                                            // Make your API request
                                            final streamedDataProvider =
                                                Provider.of<
                                                        StreamedDataProvider>(
                                                    context,
                                                    listen: false);
                                            Map<String, dynamic> data =
                                                await ApiRequests().Savedata(
                                                    streamedDataProvider.loginuserdata['sh_id'],
                                                    provider.returnproduct[
                                                        widget.index]['pr_id'],
                                                    1,
                                                    context);
                                            setState(() {
                                              change =
                                                  false; // Set the loading flag to false when the API request is done
                                              showdialugue =
                                                  true; // Show the dropdown after the button is pressed
                                            });

                                            streamedDataProvider
                                                .updateCartData(data);
                                          }
                                        }
                                      },
                                      child: ButtonWidget(
                                        quan:
                                            provider.returnproduct[widget.index]
                                                ['pr_qty'],
                                        preorder:
                                            provider.returnproduct[widget.index]
                                                ['pr_advord'],
                                      ),
                                    )
                        else
                          InkWell(
                            onTap: () {
                              provider.loginuserdata.isEmpty
                                  ? Get.to(const SignInScreen())
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal:
                                                  widget.allsize * 0.016,
                                              vertical: widget.allsize * 0.04),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: item
                                                  .map<Widget>((String item) {
                                                return ListTile(
                                                  title: Text(item),
                                                  onTap: () async {
                                                    setState(() {
                                                      if (item == '-Remove-') {
                                                        showdialugue = false;
                                                        dropdownValue =
                                                            '1 in Cart';
                                                        provider.call(
                                                            provider.returnproduct[
                                                                    widget
                                                                        .index]
                                                                ['pr_id'],
                                                            "0",
                                                            "1",provider.returnproduct[widget.index]['addedtowl']);
                                                        provider.updatereturnproduct(provider.returnproduct[widget.index]['pr_id'], "0", "1",provider.returnproduct[widget.index]['addedtowl']);
                                                        // provider.updatedetail(
                                                        //     "0", "1");
                                                      }
                                                      dropdownValue = item;
                                                    });
                                                    Navigator.of(context).pop();
                                                    final streamedDataProvider =
                                                        Provider.of<
                                                                StreamedDataProvider>(
                                                            context,
                                                            listen: false);
                                                    int value1 = FunctionClass()
                                                        .extractIntegerBeforeSpace(
                                                            item);
                                                    // ApiRequests().Savedata(widget.productid,item == "-Remove-" ? "0" : value1.toString(), context);
                                                    var request = http.Request(
                                                        'GET',
                                                        Uri.parse(
                                                            'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${ streamedDataProvider.loginuserdata['sh_id']}&pr_id=${provider.returnproduct[widget.index]['pr_id']}&sc_qty=${item == "-Remove-" ? "0" : value1}&app_id='));
                                                    http.StreamedResponse
                                                        response =
                                                        await request.send();
                                                    if (response.statusCode ==
                                                        200) {
                                                      final data =
                                                          await response.stream
                                                              .bytesToString();
                                                      streamedDataProvider
                                                          .updateCartData(
                                                              jsonDecode(data));
                                                      debugPrint(data);
                                                      Map<String, dynamic>
                                                          datache =
                                                          jsonDecode(data);
                                                      debugPrint(datache['DATA']
                                                          ['cartList']);
                                                    } else {
                                                      debugPrint(response
                                                          .reasonPhrase);
                                                    }
                                                    provider.updatedetail(
                                                        "1", value1.toString());
                                                    provider.call(
                                                        provider.returnproduct[
                                                                widget.index]
                                                            ['pr_id'],
                                                        "1",
                                                        value1.toString(),provider.returnproduct[widget.index]['addedtowl']);
                                                    provider.updatereturnproduct(
                                                        provider.returnproduct[
                                                                widget.index]
                                                            ['pr_id'],
                                                        "1",
                                                        value1.toString(),provider.returnproduct[widget.index]['addedtowl']);
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                            child: CustomDropDown(
                                size: widget.size,
                                dropdownValue: dropdownValue,
                                allsize: widget.allsize),
                          ),
                        SizedBox(
                          height: widget.size.height * 0.01,
                        ),
                        provider.returnproduct[widget.index]["su_id"] == "0"
                            ? Container() :provider.returnproduct[widget.index]['issubscribe'] == "0"?
                        InkWell(
                              child: Container(
                                  height: widget.size.height * 0.06,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xff006ccf),
                                          width: widget.allsize * 0.002)),
                                  child: Center(
                                    child: Text(
                                      "ADD TO PULL LIST",
                                      style: TextStyle(color: const Color(0xff006ccf),fontSize: widget.allsize*0.014,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                          onTap: (){
                            final streamedDataProvider =
                            Provider.of<
                                StreamedDataProvider>(
                                context,
                                listen:
                                false);
                            if (provider
                                .loginuserdata
                                .isEmpty) {
                              Get.to(
                                  const SignInScreen());
                            } else {
                              ApiRequests().SavePullList(
                                  streamedDataProvider
                                      .loginuserdata[
                                  'sh_id'],
                                  provider.returnproduct[widget.index]['su_id'],
                                  "1",
                                  "0",
                                  provider.returnproduct[widget.index]['pr_id'],
                                  context);
                            }
                          },
                            ):
                        InkWell(
                          child: Container(
                            height: widget.size.height * 0.06,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xff006ccf),
                                    width: widget.allsize * 0.002)),
                            child: Center(
                              child: Text(
                                "ADDED TO PULL LIST",
                                style: TextStyle(color: const Color(0xff006ccf),fontSize: widget.allsize*0.014,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: (){
                            // final streamedDataProvider =
                            // Provider.of<
                            //     StreamedDataProvider>(
                            //     context,
                            //     listen:
                            //     false);
                            // if (provider
                            //     .loginuserdata
                            //     .isEmpty) {
                            //   Get.to(
                            //       const SignInScreen());
                            // } else {
                            //   ApiRequests().SavePullList(
                            //       streamedDataProvider
                            //           .loginuserdata[
                            //       'sh_id'],
                            //       provider.returnproduct[widget.index],
                            //       "1",
                            //       "0",
                            //       context);
                            // }
                          },
                        )
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.size,
    required this.dropdownValue,
    required this.allsize,
  });

  final Size size;
  final String dropdownValue;
  final double allsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.06,
      decoration: BoxDecoration(color: Colors.grey[300]),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dropdownValue,
            style: TextStyle(fontSize: allsize * 0.014),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: allsize * 0.02,
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  String preorder, quan;

  ButtonWidget({super.key, required this.quan, required this.preorder});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    int quantity = int.parse(widget.quan);
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Container(
      height: size.height * 0.06,
      color: (widget.preorder == "1")
          ? const Color(0xff9048c4)
          : (quantity == 0 || quantity < 0)
              ? Colors.red
              : const Color(0xff006ccf),
      child: Center(
          child: Text(
        widget.preorder == "1"
            ? "PRE-ORDER"
            : (quantity == 0 || quantity < 0)
                ? "ADD TO WISH LIST"
                : "ADD TO CART",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: allsize * 0.012),
      )),
    );
  }
}
