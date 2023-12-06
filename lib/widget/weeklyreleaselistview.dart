// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:midtowncomics/export.dart';

class WeeklyRelaseListView extends StatefulWidget {
  WeeklyRelaseListView({
    super.key,
    // required this.size,
    // required this.allsize,
    required this.index,
  });

  // final Size size;
  // final double allsize;
  // // Map<String,dynamic>data;
  int index;

  @override
  State<WeeklyRelaseListView> createState() => _WeeklyRelaseListViewState();
}

class _WeeklyRelaseListViewState extends State<WeeklyRelaseListView> {
  bool change = false;
  bool showdialugue = false;
  String dropdownValue = '1 in Cart';
  List<String> item = [];
  List<dynamic> group = [];
  String groupvalue = "";
  String imagedata = "";
  List<dynamic> size = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<WeeklyReleaseProvider>(builder: (context, provider, child) {
      if (int.parse(provider.dataweekly[widget.index]['pr_qty'] == "0"
              ? "1"
              : provider.dataweekly[widget.index]['pr_qty']) >
          25) {
        item = FunctionClass().generateStringListFromInteger(25);
      } else {
        item = FunctionClass().generateStringListFromInteger(int.parse(
            provider.dataweekly[widget.index]['pr_qty'] == "0"
                ? "1"
                : provider.dataweekly[widget.index]['pr_qty']));
      }
      dropdownValue =
          int.parse(provider.dataweekly[widget.index]['sc_qty']) == 0
              ? "1 in Cart"
              : '${provider.dataweekly[widget.index]['sc_qty']} in Cart';
      final dateFormat = DateFormat("M/d/yyyy");
      DateTime dateTime =
          dateFormat.parse(provider.dataweekly[widget.index]['pr_reldt']);
      DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
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
                      width: size.width * 0.35,
                      child: Image.network(
                        provider.dataweekly[widget.index]['hideadultimage'] == '0'
                            ? "https://www.midtowncomics.com/images/PRODUCT/FUL/${provider.dataweekly[widget.index]['pr_id']}_ful.jpg"
                            : 'https://www.midtowncomics.com/images/PRODUCT/FUL/adults_ful.jpg',
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.dataweekly[widget.index]["su_id"] == "0"
                            ? Container()
                            : ClipPath(
                                clipper: CustomClipPath(),
                                child: Container(
                                  height: size.height * 0.025,
                                  width: size.width * 0.35,
                                  color: const Color(0xff006ccf),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "Available for pull list!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: allsize * 0.01),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          provider.dataweekly[widget.index]['pr_ttle'],
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: allsize * 0.012,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "By ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: allsize * 0.011),
                            ),
                            Flexible(
                              child: Text(
                                provider.dataweekly[widget.index]['mn_name'],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: allsize * 0.011),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Release Date ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: allsize * 0.011),
                            ),
                            Flexible(
                              child: Text(
                                "${dateOnly.day}-${dateOnly.month}-${dateOnly.year}",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: allsize * 0.011),
                              ),
                            )
                          ],
                        ),
                        // group.isNotEmpty||size.isNotEmpty?
                        // InkWell(
                        //   onTap: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return Dialog(
                        //           insetPadding: EdgeInsets.symmetric(
                        //               horizontal: widget.allsize * 0.016,
                        //               vertical: widget.allsize * 0.04),
                        //           child: SingleChildScrollView(
                        //             child: Column(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: group
                        //                   .map<Widget>((dynamic item) {
                        //                 return ListTile(
                        //                   title: Text(
                        //                       item['condition_name']),
                        //                   onTap: () async {
                        //                     debugPrint(item['pr_id']);
                        //                     provider
                        //                         .updatereturnproductforgrade(
                        //                         provider.returnproduct[
                        //                         widget.index]
                        //                         ['pr_id'],
                        //                         item['pr_id'],
                        //                         item['pr_price'],
                        //                         item['pr_lprice'],
                        //                         item['pr_advord'],
                        //                         item['pr_qty']);
                        //                     setState(() {
                        //                       groupvalue =
                        //                       item['condition_name'];
                        //                     });
                        //                     Navigator.of(context).pop();
                        //                   },
                        //                 );
                        //               }).toList(),
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     );
                        //   },
                        //   child: Container(
                        //     height: widget.size.height * 0.04,
                        //     decoration:
                        //     BoxDecoration(color: Colors.grey[300]),
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       mainAxisAlignment:
                        //       MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           groupvalue,
                        //           style: TextStyle(
                        //               fontSize: widget.allsize * 0.014),
                        //         ),
                        //         Icon(
                        //           Icons.arrow_drop_down,
                        //           size: widget.allsize * 0.02,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ):Container(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          "\$${provider.dataweekly[widget.index]['pr_lprice']}",
                          style: TextStyle(
                              fontSize: allsize * 0.011,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        provider.dataweekly[widget.index]['pr_price'] ==
                                provider.dataweekly[widget.index]['pr_lprice']
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${provider.dataweekly[widget.index]['pr_price']}",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontSize: allsize * 0.011),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // print(
                                        //     provider.returnproduct[widget.index]
                                        //         ['pr_id']);
                                        // debugPrint(
                                        //     provider.returnproduct[widget.index]
                                        //     ['in_cart']);
                                        // debugPrint(provider.returnproduct.toString());
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
                                        height: size.height * 0.035,
                                        width: size.width * 0.25,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 3),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            "${FunctionClass().findoff(provider.dataweekly[widget.index]['pr_price'], provider.dataweekly[widget.index]['pr_lprice'])}% OFF",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: allsize * 0.012,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        if (provider.dataweekly[widget.index]['in_cart'] ==
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
                                        final streamprovider =
                                            Provider.of<StreamedDataProvider>(
                                                context,
                                                listen: false);
                                        streamprovider.loginuserdata.isEmpty
                                            ? Get.to(const SignInScreen())
                                            : showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                allsize * 0.016,
                                                            vertical:
                                                                allsize * 0.04),
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
                                                                  showdialugue =
                                                                      false;
                                                                  dropdownValue =
                                                                      '1 in Cart';
                                                                  streamprovider.call(
                                                                      provider.dataweekly[
                                                                              widget.index]
                                                                          [
                                                                          'pr_id'],
                                                                      "0",
                                                                      "1",provider.dataweekly[widget.index]['addedtowl']);
                                                                  provider.updateweeklyrelease(
                                                                      provider.dataweekly[
                                                                              widget.index]
                                                                          [
                                                                          'pr_id'],
                                                                      "0",
                                                                      "1",provider.dataweekly[widget.index]['addedtowl']);
                                                                  // provider.updatereturnproduct(provider.returnproduct[widget.index]['pr_id'], "0", "1");
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
                                                                          'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${ streamedDataProvider.loginuserdata['sh_id']}&pr_id=${provider.dataweekly[widget.index]['pr_id']}&sc_qty=${item == "-Remove-" ? "0" : value1}&app_id='));
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
                                                                Map<String,
                                                                        dynamic>
                                                                    datache =
                                                                    jsonDecode(
                                                                        data);
                                                              } else {}
                                                              streamedDataProvider
                                                                  .updatedetail(
                                                                      "1",
                                                                      value1
                                                                          .toString());
                                                              streamprovider.call(
                                                                  provider.dataweekly[
                                                                          widget
                                                                              .index]
                                                                      ['pr_id'],
                                                                  "1",
                                                                  value1
                                                                      .toString(),provider.dataweekly[widget.index]['addedtowl']);
                                                              provider.updateweeklyrelease(
                                                                  provider.dataweekly[
                                                                          widget
                                                                              .index]
                                                                      ['pr_id'],
                                                                  "1",
                                                                  value1
                                                                      .toString(),provider.dataweekly[widget.index]['addedtowl']);
                                                              // provider.updatereturnproduct(
                                                              //     provider.returnproduct[
                                                              //     widget
                                                              //         .index]
                                                              //     ['pr_id'],
                                                              //     "1",
                                                              //     value1
                                                              //         .toString());
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
                                          size: size,
                                          dropdownValue: dropdownValue,
                                          allsize: allsize),
                                    ):
                              int.parse(provider.dataweekly[widget.index]['pr_qty'])==0?
                              InkWell(
                                onTap: (){
                                  if( int.parse(provider.dataweekly[widget.index]['addedtowl'])>0)
                                  {
                                    Get.to(const MyWishListScreen());
                                  }
                                  {
                                    final streamedDataProvider =
                                    Provider.of<StreamedDataProvider>(context,
                                        listen: false);
                                    ApiRequests().saveToWishList(streamedDataProvider.loginuserdata['sh_id']
                                        , provider.dataweekly[widget.index]['pr_parentid']);
                                    streamedDataProvider.updateWishListDetail();
                                    streamedDataProvider.call(provider.dataweekly[widget.index]['pr_id'],provider.dataweekly[widget.index]['in_cart'],provider.dataweekly[widget.index]['sc_qty'], "1");
                                    provider.updateweeklyrelease(provider.dataweekly[widget.index]['pr_id'],provider.dataweekly[widget.index]['in_cart'],provider.dataweekly[widget.index]['sc_qty'],"1");
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  color: int.parse(provider.dataweekly[widget.index]['addedtowl'])>0?Colors.grey: Colors.red,
                                  child: Center(
                                      child: Text(
                                        int.parse(provider.dataweekly[widget.index]['addedtowl'])>0?"ADDED TO WISH LIST":
                                            "ADD TO WISH LIST",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: allsize * 0.012),
                                      )),
                                ),
                              )
                                  : InkWell(
                                      onTap: () async {
                                        final streamprovider =
                                            Provider.of<StreamedDataProvider>(
                                                context,
                                                listen: false);
                                        int quantity = int.parse(
                                            provider.dataweekly[widget.index]
                                                ['pr_qty']);
                                        if (quantity == 0 || quantity < 0) {
                                          debugPrint('WhishList');
                                        } else {
                                          if (streamprovider
                                              .loginuserdata.isEmpty) {
                                            Get.to(const SignInScreen());
                                          } else {
                                            streamprovider.call(
                                                provider.dataweekly[
                                                    widget.index]['pr_id'],
                                                "1",
                                                "1",provider.dataweekly[widget.index]['addedtowl']);
                                            provider.updateweeklyrelease(
                                                provider.dataweekly[
                                                    widget.index]['pr_id'],
                                                "1",
                                                "1",provider.dataweekly[widget.index]['addedtowl']);
                                            // provider.updatedetail("1", "1");
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
                                                    provider.dataweekly[
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
                                        quan: provider.dataweekly[widget.index]
                                            ['pr_qty'],
                                        preorder:
                                            provider.dataweekly[widget.index]
                                                ['pr_advord'],
                                      ),
                                    )
                        else
                          InkWell(
                            onTap: () {
                              final streamprovider =
                                  Provider.of<StreamedDataProvider>(context,
                                      listen: false);
                              streamprovider.loginuserdata.isEmpty
                                  ? Get.to(const SignInScreen())
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: allsize * 0.016,
                                              vertical: allsize * 0.04),
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
                                                        streamprovider.call(
                                                            provider.dataweekly[
                                                                    widget
                                                                        .index]
                                                                ['pr_id'],
                                                            "0",
                                                            "1",provider.dataweekly[widget.index]['addedtowl']);
                                                        provider.updateweeklyrelease(
                                                            provider.dataweekly[
                                                                    widget
                                                                        .index]
                                                                ['pr_id'],
                                                            "0",
                                                            "1",provider.dataweekly[widget.index]['addedtowl']);
                                                        // provider.updatereturnproduct(provider.returnproduct[widget.index]['pr_id'], "0", "1");
                                                        // provider.updatedetail("0", "1");
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
                                                            'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${ streamedDataProvider.loginuserdata['sh_id']}&pr_id=${provider.dataweekly[widget.index]['pr_id']}&sc_qty=${item == "-Remove-" ? "0" : value1}&app_id='));
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
                                                      Map<String, dynamic>
                                                          datache =
                                                          jsonDecode(data);
                                                    } else {}
                                                    streamedDataProvider
                                                        .updatedetail("1",
                                                            value1.toString());
                                                    streamprovider.call(
                                                        provider.dataweekly[
                                                                widget.index]
                                                            ['pr_id'],
                                                        "1",
                                                        value1.toString(),provider.dataweekly[widget.index]['addedtowl']);
                                                    provider
                                                        .updateweeklyrelease(
                                                            provider.dataweekly[
                                                                    widget
                                                                        .index]
                                                                ['pr_id'],
                                                            "1",
                                                            value1.toString(),provider.dataweekly[widget.index]['addedtowl']);
                                                    // provider.updatereturnproduct(
                                                    //     provider.returnproduct[
                                                    //     widget
                                                    //         .index]
                                                    //     ['pr_id'],
                                                    //     "1",
                                                    //     value1
                                                    //         .toString());
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
                                size: size,
                                dropdownValue: dropdownValue,
                                allsize: allsize),
                          ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        provider.dataweekly[widget.index]["su_id"] == "0"
                            ? Container()
                            : provider.dataweekly[widget.index]['issubscribe'] == "0"?
                        InkWell(
                          child: Container(
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xff006ccf),
                                    width: allsize * 0.002)),
                            child: Center(
                              child: Text(
                                "ADD TO PULL LIST",
                                style: TextStyle(
                                    color: const Color(0xff006ccf),
                                    fontSize: allsize * 0.014,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: ()async{
                            final streamedDataProvider =
                            Provider.of<
                                StreamedDataProvider>(
                                context,
                                listen:
                                false);
                            if (streamedDataProvider
                                .loginuserdata
                                .isEmpty) {
                              Get.to(
                                  const SignInScreen());
                            } else {
                              await ApiRequests().SavePullList(
                                  streamedDataProvider
                                      .loginuserdata['sh_id'],
                                  provider.dataweekly[widget.index]['su_id'],
                                  "1",
                                  "0",
                                  provider.dataweekly[widget.index]['pr_id'],
                                  context);

                              // print( provider.dataweekly[widget.index]);
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
                                    width: allsize * 0.002)),
                            child: Center(
                              child: Text(
                                "ADDED TO PULL LIST",
                                style: TextStyle(
                                    color: const Color(0xff006ccf),
                                    fontSize: allsize * 0.014,
                                    fontWeight: FontWeight.bold),
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
                            // if (streamedDataProvider
                            //     .loginuserdata
                            //     .isEmpty) {
                            //   Get.to(
                            //       const SignInScreen());
                            // } else {
                            //   ApiRequests().SavePullList(
                            //       streamedDataProvider
                            //           .loginuserdata[
                            //       'sh_id'],
                            //       provider.dataweekly[widget.index],
                            //       "1",
                            //       "0",
                            //       context);
                            // }
                          },
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
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
