
import 'package:flutter_html/flutter_html.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

import '../widget/featurenewrelease.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  int index = 1;
  String dropdownselected = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
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
        body: Consumer<StreamedDataProvider>(builder: (context, provider, child) {
            return   SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SearchList(searchcontroller: searchController),
                    DealOfTheDayText(size: size, allsize: allsize),
                    SizedBox(height: size.height*0.01,),
                    SizedBox(
                      height: size.height * 0.35,
                      child: Image.network(
                        "https://www.midtowncomics.com/images/PRODUCT/FUL/1971224_ful.jpg",
                        loadingBuilder: (BuildContext context,
                            Widget child,
                            ImageChunkEvent?
                            loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                                child:
                                CircularProgressIndicator());
                          }
                        },
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Blade Runner 2029 #2 Cover A Regular Peach Momoko Cover",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize:
                                      allsize * 0.013),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("By ",
                                                  style: TextStyle(
                                                      color: Colors.grey[
                                                      600],
                                                      fontSize:
                                                      allsize *
                                                          0.012,
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              Flexible(
                                                child: Text(
                                                    "Titan Comics",
                                                    // provider.productdetail['DATA']
                                                    // [
                                                    // 'prDetail']
                                                    // [
                                                    // 'mn_name'],
                                                    style:
                                                    TextStyle(
                                                      color: Colors
                                                          .blueAccent,
                                                      fontSize:
                                                      allsize *
                                                          0.012,
                                                    )),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Artist ",
                                                  style: TextStyle(
                                                      color: Colors.grey[
                                                      600],
                                                      fontSize:
                                                      allsize *
                                                          0.012,
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              Flexible(
                                                child: Text(
                                                  "Andres Guinaldo",
                                                  // provider.productdetail['DATA']
                                                  // [
                                                  // 'prDetail']
                                                  // [
                                                  // 'pr_artst'],
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .blueAccent,
                                                    fontSize:
                                                    allsize *
                                                        0.012,
                                                  ),
                                                  overflow:
                                                  TextOverflow
                                                      .clip,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                  "|Written  by ",
                                                  style: TextStyle(
                                                      color: Colors.grey[
                                                      600],
                                                      fontSize:
                                                      allsize *
                                                          0.012,
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              Flexible(
                                                child: Text(
                                                    "Michael Green - Mike Johnson",
                                                    // provider.productdetail['DATA']
                                                    // [
                                                    // 'prDetail']
                                                    // [
                                                    // 'pr_writ'],
                                                    style:
                                                    TextStyle(
                                                      color: Colors
                                                          .blueAccent,
                                                      fontSize:
                                                      allsize *
                                                          0.012,
                                                    )),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "|Release Date ",
                                                  style: TextStyle(
                                                      color: Colors.grey[
                                                      600],
                                                      fontSize:
                                                      allsize *
                                                          0.012,
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              Flexible(
                                                child: Text(
                                                    "2022-5-12",
                                                    // "${dateOnly.year}-${dateOnly.month}-${dateOnly.day}",
                                                    style:
                                                    TextStyle(
                                                      color: Colors
                                                          .blueAccent,
                                                      fontSize:
                                                      allsize *
                                                          0.012,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Text(
                                      "\$22",
                                      // "\$${provider.productdetail['DATA']['prDetail']['pr_lprice']}",
                                      style: TextStyle(
                                        // decoration: TextDecoration.lineThrough,
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: allsize *
                                              0.0115),
                                    ),
                                    // provider.productdetail[
                                    // 'DATA']
                                    // [
                                    // 'prDetail']
                                    // [
                                    // 'pr_lprice'] ==
                                    //     provider.productdetail[
                                    //     'DATA']
                                    //     [
                                    //     'prDetail']
                                    //     ['pr_price']
                                    //     ? Container()
                                    //     :
                                    Text(
                                      "\$23",
                                      // "\$${provider.productdetail['DATA']['prDetail']['pr_price']}",
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration
                                              .lineThrough,
                                          // fontWeight: FontWeight.bold,
                                          fontSize:
                                          allsize *
                                              0.0115),
                                    ),
                                    // provider.productdetail[
                                    // 'DATA']
                                    // [
                                    // 'prDetail']
                                    // [
                                    // 'pr_lprice'] ==
                                    //     provider.productdetail[
                                    //     'DATA']
                                    //     [
                                    //     'prDetail']
                                    //     ['pr_price']
                                    //     ? Container()
                                    //     :
                                    Container(
                                      height:
                                      size.height *
                                          0.04,
                                      width:
                                      size.width *
                                          0.25,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .red,
                                              width: 3),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              5)),
                                      child: Center(
                                        child: Text(
                                          "10% OFF",
                                          // "${FunctionClass().findoff(provider.detail['pr_price'], provider.detail['pr_lprice'])}% OFF",
                                          style: TextStyle(
                                              color: Colors
                                                  .red,
                                              fontSize:
                                              allsize *
                                                  0.012,
                                              fontWeight:
                                              FontWeight
                                                  .bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                // if (provider.detail[
                                // 'in_cart'] ==
                                //     "0" ||
                                //     change)
                                //   change
                                //       ? const Center(
                                //     child:
                                //     CircularProgressIndicator(), // Show a circular progress indicator while loading
                                //   )
                                //       : showdialugue
                                //       ? InkWell(
                                //     onTap: () {
                                //       provider.loginuserdata
                                //           .isEmpty
                                //           ? Get.to(
                                //           const SignInScreen())
                                //           : showDialog(
                                //         context:
                                //         context,
                                //         builder:
                                //             (BuildContext context) {
                                //           return Dialog(
                                //             insetPadding: EdgeInsets.symmetric(horizontal: allsize * 0.016, vertical: allsize * 0.04),
                                //             child: SingleChildScrollView(
                                //               child: Column(
                                //                 mainAxisSize: MainAxisSize.min,
                                //                 children: item.map<Widget>((String item) {
                                //                   return ListTile(
                                //                     title: Text(item),
                                //                     onTap: () async {
                                //                       setState(() {
                                //                         if (item == '-Remove-') {
                                //                           showdialugue = false;
                                //                           dropdownValue = '1 in Cart';
                                //                           provider.call(provider.detail['pr_id'], "0", "1");
                                //                           provider.updatedetail("0", "1");
                                //                         }
                                //                         dropdownValue = item;
                                //                       });
                                //                       Navigator.of(context).pop();
                                //                       final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                //                       int value1 = FunctionClass().extractIntegerBeforeSpace(item);
                                //                       // ApiRequests().Savedata(widget.productid,item == "-Remove-" ? "0" : value1.toString(), context);
                                //                       var request = http.Request('GET', Uri.parse('https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=76367&pr_id=${widget.productid}&sc_qty=${item == "-Remove-" ? "0" : value1}&app_id='));
                                //                       http.StreamedResponse response = await request.send();
                                //                       if (response.statusCode == 200) {
                                //                         final data = await response.stream.bytesToString();
                                //                         streamedDataProvider.updateCartData(jsonDecode(data));
                                //                         debugPrint(data.toString());
                                //                         Map<String, dynamic> datache = jsonDecode(data);
                                //                       } else {
                                //                         debugPrint(response.reasonPhrase);
                                //                       }
                                //                       provider.updatedetail("1", value1.toString());
                                //                       provider.call(widget.productid, "1", value1.toString());
                                //                     },
                                //                   );
                                //                 }).toList(),
                                //               ),
                                //             ),
                                //           );
                                //         },
                                //       );
                                //     },
                                //     child: CustomDropDown(
                                //         size: size,
                                //         dropdownValue:
                                //         dropdownValue,
                                //         allsize:
                                //         allsize),
                                //   )
                                //       :
                                InkWell(
                                  onTap:
                                      () async {
                                    // if (provider
                                    //     .loginuserdata
                                    //     .isEmpty) {
                                    //   Get.to(
                                    //       const SignInScreen());
                                    // } else {
                                    //   provider.call(
                                    //       provider
                                    //           .detail['pr_id'],
                                    //       "1",
                                    //       "1");
                                    //   provider
                                    //       .updatedetail(
                                    //       "1",
                                    //       "1");
                                    //   setState(
                                    //           () {
                                    //         change =
                                    //         true; // Set the loading flag to true
                                    //       });
                                    //
                                    //   // Make your API request
                                    //   final streamedDataProvider = Provider.of<
                                    //       StreamedDataProvider>(
                                    //       context,
                                    //       listen:
                                    //       false);
                                    //   Map<String,
                                    //       dynamic>
                                    //   data =
                                    //   await ApiRequests().Savedata(
                                    //       provider.detail['pr_id'],
                                    //       1,
                                    //       context);
                                    //
                                    //   setState(
                                    //           () {
                                    //         change =
                                    //         false; // Set the loading flag to false when the API request is done
                                    //         showdialugue =
                                    //         true; // Show the dropdown after the button is pressed
                                    //       });
                                    //
                                    //   streamedDataProvider
                                    //       .updateCartData(
                                    //       data);
                                    // }
                                  },
                                  child:
                                  ButtonWidget(
                                    quan:"2",
                                    // provider
                                    //     .detail[
                                    // 'pr_qty'],
                                    preorder:"0",
                                    // provider
                                    //     .detail[
                                    // 'pr_advord'],
                                  ),
                                )
                                // else
                                //   InkWell(
                                //     onTap: () {
                                //       provider.loginuserdata
                                //           .isEmpty
                                //           ? Get.to(
                                //           const SignInScreen())
                                //           : showDialog(
                                //         context:
                                //         context,
                                //         builder:
                                //             (BuildContext
                                //         context) {
                                //           return Dialog(
                                //             insetPadding: EdgeInsets.symmetric(
                                //                 horizontal:
                                //                 allsize *
                                //                     0.016,
                                //                 vertical:
                                //                 allsize *
                                //                     0.04),
                                //             child:
                                //             SingleChildScrollView(
                                //               child:
                                //               Column(
                                //                 mainAxisSize:
                                //                 MainAxisSize.min,
                                //                 children:
                                //                 item.map<Widget>((String
                                //                 item) {
                                //                   return ListTile(
                                //                     title:
                                //                     Text(item),
                                //                     onTap:
                                //                         () async {
                                //                       setState(() {
                                //                         if (item == '-Remove-') {
                                //                           showdialugue = false;
                                //                           dropdownValue = '1 in Cart';
                                //                           provider.call(provider.detail['pr_id'], "0", "1");
                                //                           provider.updatedetail("0", "1");
                                //                         }
                                //                         dropdownValue = item;
                                //                       });
                                //                       Navigator.of(context).pop();
                                //                       final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                //                       int value1 = FunctionClass().extractIntegerBeforeSpace(item);
                                //                       // ApiRequests().Savedata(widget.productid,item == "-Remove-" ? "0" : value1.toString(), context);
                                //                       var request = http.Request('GET', Uri.parse('https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=76367&pr_id=${widget.productid}&sc_qty=${item == "-Remove-" ? "0" : value1}&app_id='));
                                //                       http.StreamedResponse response = await request.send();
                                //                       if (response.statusCode == 200) {
                                //                         final data = await response.stream.bytesToString();
                                //                         streamedDataProvider.updateCartData(jsonDecode(data));
                                //                         Map<String, dynamic> datache = jsonDecode(data);
                                //                       } else {
                                //                         debugPrint(response.reasonPhrase);
                                //                       }
                                //                       provider.updatedetail("1", value1.toString());
                                //                       provider.call(widget.productid, "1", value1.toString());
                                //                       // Map<String, dynamic> data =
                                //                       //     await ApiRequests().Savedata(
                                //                       //         widget.image,
                                //                       //         item == "-Remove-"
                                //                       //             ? "0"
                                //                       //             : value1,
                                //                       //         context);
                                //                       // streamedDataProvider
                                //                       //     .updateCartData(data);
                                //                       // Map<String, dynamic> refresh =
                                //                       //     await ApiRequests()
                                //                       //         .fetchData1(context);
                                //                       // streamedDataProvider
                                //                       //     .updateData(refresh);
                                //                       // Close the dialog
                                //                     },
                                //                   );
                                //                 }).toList(),
                                //               ),
                                //             ),
                                //           );
                                //         },
                                //       );
                                //     },
                                //     child: CustomDropDown(
                                //         size: size,
                                //         dropdownValue:
                                //         dropdownValue,
                                //         allsize: allsize),
                                //   ),
                                , SizedBox(
                                  height: size.height * 0.01,
                                ),
                                // provider.detail['su_id'] ==
                                //     "0"
                                //     ? Container()
                                //     : InkWell(
                                //     child: Container(
                                //       height:
                                //       size.height *
                                //           0.06,
                                //       decoration: BoxDecoration(
                                //           border: Border.all(
                                //               color: const Color(
                                //                   0xff006ccf),
                                //               width: allsize *
                                //                   0.003)),
                                //       child: Center(
                                //         child: Text(
                                //           'ADD TO PULL LIST',
                                //           style: TextStyle(
                                //               color: const Color(
                                //                   0xff006ccf),
                                //               fontSize:
                                //               allsize *
                                //                   0.012,
                                //               fontWeight:
                                //               FontWeight
                                //                   .bold),
                                //         ),
                                //       ),
                                //     ),
                                //     onTap: () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment:
                                  Alignment.topLeft,
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.w500,
                                        fontSize:
                                        allsize * 0.016),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "Written By",
                                            style: TextStyle(
                                                color: Colors
                                                    .grey[
                                                600],
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize:
                                                allsize *
                                                    0.012),
                                          ),
                                          SizedBox(
                                            height:
                                            size.height *
                                                0.005,
                                          ),
                                          Text(
                                              "Michael Green - Mike Johnson",
                                              // provider.detail[
                                              // 'pr_writ'],
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey,
                                                  fontSize:
                                                  allsize *
                                                      0.012))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      size.width * 0.15,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "Art By",
                                            style: TextStyle(
                                                color: Colors
                                                    .grey[
                                                600],
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize:
                                                allsize *
                                                    0.012),
                                          ),
                                          SizedBox(
                                            height:
                                            size.height *
                                                0.005,
                                          ),
                                          Text(
                                              "Andres Guinaldo",
                                              // provider.detail[
                                              // 'pr_artst'],
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey,
                                                  fontSize:
                                                  allsize *
                                                      0.012))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Html(
                                    data:
                                    "<p>The first comic to tell original, in-canon stories set in the <i>Blade Runner</i> universe returns!<p>It is 2029 and Blade Runner Ash continues to hunt the streets of the rain-soaked dystopian world of Los Angeles for renegade Replicants, but this time she's trying to protect as many as she can find.<p>Written by Academy award-nominated screenwriter MICHAEL GREEN (<i>Blade Runner 2049</i>) and co-writer MIKE JOHNSON (<i>Supergirl</i>)!"
                                        "</p>",
                                    // "<p>${provider.detail['pr_sdesc']}</p>",
                                    style: {
                                      "p": Style(
                                        color: Colors.grey,
                                      ),
                                      "li": Style(
                                        color: Colors.grey,
                                      ),
                                      "ul": Style(
                                        color: Colors.grey,
                                      ),
                                    }),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Flexible(
                                        child: Text(
                                          "Item #:2233031",
                                          style: TextStyle(
                                            fontSize:
                                            allsize * 0.009,
                                            color: const Color(0xff006ccf),
                                          ),
                                        )),
                                    Flexible(
                                        child: Text(
                                          "Diamond Code: -",
                                          // "${provider.detail['pre_code']}",
                                          style: TextStyle(
                                            fontSize:
                                            allsize * 0.009,
                                            color: const Color(0xff006ccf),),
                                        )),
                                    Flexible(
                                        child: Text(
                                          "UPC: -",
                                          // "${provider.detail['upc']}",
                                          style: TextStyle(
                                            fontSize:
                                            allsize * 0.009,
                                            color: const Color(0xff006ccf),),
                                        )),
                                  ],
                                )
                                // Text(provider.detail['pr_sdesc'],style: TextStyle(color: Colors.grey,fontSize: allsize*0.012))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        // height: size.height * 0.48,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Bonus Deal of the Day",
                                  style: TextStyle(
                                      color: const Color(0xff018703),
                                      fontSize: allsize * 0.02,
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              height: size.height * 0.43,
                              child: Scrollbar(
                                trackVisibility: true,
                                thumbVisibility: true,
                                child: PageView.builder(
                                  itemCount:
                                  (provider.featurenewrelease.length /
                                      2)
                                      .ceil(),
                                  // Display two items per page
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, pageIndex) {
                                    FunctionClass().precacheImages(
                                        provider.featurenewrelease,
                                        context);
                                    final startIndex = pageIndex * 2;
                                    final endIndex = startIndex + 2;

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.013),
                                      child: Row(
                                        mainAxisAlignment: endIndex <=
                                            provider.featurenewrelease
                                                .length
                                            ? MainAxisAlignment.spaceBetween
                                            : MainAxisAlignment.start,
                                        children: [
                                          for (var index = startIndex;
                                          index < endIndex;
                                          index++)
                                            if (index <
                                                provider.featurenewrelease
                                                    .length)
                                              SizedBox(
                                                // width: size.width * 0.47962,
                                                // Adjust the width as needed
                                                child: FeatureNewRelease(
                                                  adultimage: provider
                                                      .featurenewrelease[
                                                  index]['hideadultimage'],
                                                  pulllist: provider
                                                      .featurenewrelease[
                                                  index]['su_id'],
                                                  image: provider
                                                      .featurenewrelease[
                                                  index]['pr_id'],
                                                  title: provider
                                                      .featurenewrelease[
                                                  index]['pr_ttle'],
                                                  prce1: provider
                                                      .featurenewrelease[
                                                  index]['pr_price'],
                                                  price2: provider
                                                      .featurenewrelease[
                                                  index]['pr_lprice'],
                                                  preorder: provider
                                                      .featurenewrelease[
                                                  index]['pr_advord'],
                                                  quantity: int.parse(provider
                                                      .featurenewrelease[
                                                  index]['pr_qty']),
                                                  incart: int.parse(provider
                                                      .featurenewrelease[
                                                  index]['in_cart']),
                                                  productquantity:
                                                  int.parse(provider
                                                      .featurenewrelease[
                                                  index]['pr_qty']),
                                                  qtycart: int.parse(provider
                                                      .featurenewrelease[
                                                  index]['sc_qty']),
                                                  data: provider
                                                      .featurenewrelease[
                                                  index], parentid: provider
                                                    .featurenewrelease[
                                                index]['pr_parentid'], addedtowl: int.parse(provider
                                                    .featurenewrelease[
                                                index]['addedtowl']),
                                                ),
                                              ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Get Daily Update
                    SizedBox(height: size.height*0.01,),
                    TextWidget(size, allsize),
                    SizedBox(height: size.height*0.01,),
                    const SubcribeWidget(),

                    const Footer(),
                    SizedBox(
                      height: size.height * 0.05,
                    )
                  ],
                ));
        }),
      ),
    );
  }

  Padding TextWidget(Size size, double allsize) {
    return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.025),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.mail,color: Colors.grey[800],size: allsize*0.02,),
                      SizedBox(width: size.width*0.01,),
                      Text("Get Daily Updates!",style: TextStyle(color: Colors.grey[800],fontSize: allsize*0.017),)
                    ],),
                    SizedBox(height: size.height*0.005,),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize:allsize*0.012, color: Colors.black),
                        children:  <TextSpan>[
                          TextSpan(text: "Subscribe to our daily deals email,follow us on", style: TextStyle(color: const Color(0xff818181),fontSize: allsize*0.012)),
                          TextSpan(text:"Twitter", style: TextStyle(color: const Color(0xff217fda),decoration: TextDecoration.underline,fontSize: allsize*0.012)),
                          TextSpan(text: "or", style: TextStyle(color: const Color(0xff818181),fontSize: allsize*0.012)),
                          TextSpan(text:"Facebook", style: TextStyle(color: const Color(0xff217fda),decoration: TextDecoration.underline,fontSize: allsize*0.012)),
                          TextSpan(text: "or download our iPhone app or get notified of our deals of the days", style: TextStyle(color: const Color(0xff818181),fontSize: allsize*0.012)),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*0.005,),
                    Text("More Info",style: TextStyle(color: Colors.grey[800],fontSize: allsize*0.017),),
                    SizedBox(height: size.height*0.005,),
                    Text("The Deal of the day is online only and cannot be combines"
                        "with any other sales or promotions. Price is only valid one day,midnight through 11:59 EST"
                        ", and while supplies last. We cannot extend rain checks sold-out items, but don't "
                        "worry, there'll be a new deal tomorrow.",style: TextStyle(color: const Color(0xff818181),fontSize: allsize*0.012))
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


