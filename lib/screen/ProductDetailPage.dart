// ignore_for_file: must_be_immutable, deprecated_member_use, depend_on_referenced_packages

import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

import '../widget/featurenewrelease.dart';

class ProductDetialPage extends StatefulWidget {
  String productid;

  ProductDetialPage({super.key, required this.productid});

  @override
  State<ProductDetialPage> createState() => _ProductDetialPageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
bool wait = false;
String image = "";

class _ProductDetialPageState extends State<ProductDetialPage> {
  bool change = false;
  bool showdialugue = false;
  String dropdownValue = '1 in Cart';
  List<String> item = [];
  String groupvalue = "";
  TextEditingController searchcontroller = TextEditingController();

  Color getColor(Set<MaterialState> states) {
    return const Color(0xffececec);
  }

  Future<void> fetchData() async {
    setState(() {
      wait = true;
    });
    final streamedDataProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    Map<String, dynamic> data = await ApiRequests().ProductDetail(
        streamedDataProvider.loginuserdata['sh_id'], widget.productid, context);
    streamedDataProvider.updateProductDetail(data);
    debugPrint(data.toString());
    setState(() {
      wait = false;
    });
  }

  @override
  void initState() {
    image = widget.productid;
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollToNextItem() {
    final int nextItemScrollPosition =
        _scrollController.position.extentAfter as int;
    _scrollController.animateTo(nextItemScrollPosition as double,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize:Size(size.width*1,allsize*0.11),
              child: Header_Widget(
                ontap: () => scaffoldKey.currentState!.openDrawer(),
                searchcontroller:searchcontroller,
              ),),
            key: scaffoldKey,
            drawer: const Custom_drawer(),
            backgroundColor: const Color(0xfff6f6f6),
            body: Consumer<StreamedDataProvider>(
                builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.01,),
                    SearchList(searchcontroller: searchcontroller),
                    provider.detailpageindicator == true ||
                            provider.detail.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : Consumer<StreamedDataProvider>(
                            builder: (context, provider, child) {
                            List<dynamic> grades =
                                provider.detail['grades'] ?? [];
                            Map<String, dynamic>?
                                searchProductIdByCondition(
                                    String condition) {
                              for (var product in grades) {
                                if (product['condition_name'] ==
                                    condition) {
                                  return {
                                    "pr_id": product['pr_id'],
                                    "pr_price": product['pr_price'],
                                    "pr_lprice": product['pr_lprice'],
                                    "pr_advord": product['pr_advord'],
                                    "pr_qty": product['pr_qty']
                                  };
                                }
                              }
                              return null; // Return null if no product with the specified condition name is found
                            }

                            final dateFormat = DateFormat("M/d/yyyy");
                            DateTime dateTime = dateFormat.parse(
                                provider.productdetail['DATA']['prDetail']
                                    ['pr_reldt']);
                            DateTime dateOnly = DateTime(dateTime.year,
                                dateTime.month, dateTime.day);
                            if (int.parse(provider.detail['pr_qty']) >
                                25) {
                              item = FunctionClass()
                                  .generateStringListFromInteger(25);
                            } else {
                              item = FunctionClass()
                                  .generateStringListFromInteger(
                                      int.parse(
                                          provider.detail['pr_qty']));
                            }
                            dropdownValue = int.parse(
                                        provider.detail['sc_qty']) ==
                                    0
                                ? "1 in Cart"
                                : '${provider.detail['sc_qty']} in Cart';
                            return Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.35,
                                  child: Image.network(
                                    "https://www.midtowncomics.com/images/PRODUCT/FUL/${image}_ful.jpg",
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
                                    errorBuilder: (context, exception, stackTrace) {
                                      return Image.asset('assets/images/imagecomingsoon_ful.jpg',fit: BoxFit.contain,);
                                    },
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      provider.detail[
                                                  'previous_series'] ==
                                              "0"
                                          ? Container()
                                          : SizedBox(
                                              width: size.width * 0.28,
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    widget
                                                        .productid = provider
                                                            .detail[
                                                        'previous_series'];
                                                  });
                                                  provider.chanddetai({});
                                                  Map<String, dynamic>
                                                      data =
                                                      await ApiRequests()
                                                          .ProductDetail(
                                                          provider.loginuserdata[
                                                                  'sh_id'],
                                                              widget
                                                                  .productid,
                                                              context);
                                                  provider
                                                      .updateProductDetail(
                                                          data);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .arrow_back_ios_new_rounded,
                                                      size:
                                                          allsize * 0.013,
                                                      color: const Color(
                                                          0xff878787),
                                                    ),
                                                    Text("Prev Issue",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey[600]!,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                      provider.detail['next_series'] ==
                                              "0"
                                          ? Container()
                                          : SizedBox(
                                              width: size.width * 0.28,
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    widget.productid =
                                                        provider.detail[
                                                            'next_series'];
                                                  });
                                                  provider.chanddetai({});
                                                  Map<String, dynamic>
                                                      data =
                                                      await ApiRequests()
                                                          .ProductDetail(
                                                          provider.loginuserdata[
                                                                  'sh_id'],
                                                              widget
                                                                  .productid,
                                                              context);
                                                  provider
                                                      .updateProductDetail(
                                                          data);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Next Issue",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey[600]!,
                                                        )),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios,
                                                      size:
                                                          allsize * 0.013,
                                                      color: const Color(
                                                          0xff878787),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
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
                                              provider.productdetail[
                                                      'DATA']['prDetail']
                                                  ['pr_ttle'],
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
                                                                provider.productdetail['DATA']
                                                                        [
                                                                        'prDetail']
                                                                    [
                                                                    'mn_name'],
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
                                                              provider.productdetail['DATA']
                                                                      [
                                                                      'prDetail']
                                                                  [
                                                                  'pr_artst'],
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
                                                                provider.productdetail['DATA']
                                                                        [
                                                                        'prDetail']
                                                                    [
                                                                    'pr_writ'],
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
                                                                "${dateOnly.year}-${dateOnly.month}-${dateOnly.day}",
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
                                                  "\$${provider.productdetail['DATA']['prDetail']['pr_lprice']}",
                                                  style: TextStyle(
                                                      // decoration: TextDecoration.lineThrough,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: allsize *
                                                          0.0115),
                                                ),
                                                provider.productdetail[
                                                                    'DATA']
                                                                [
                                                                'prDetail']
                                                            [
                                                            'pr_lprice'] ==
                                                        provider.productdetail[
                                                                    'DATA']
                                                                [
                                                                'prDetail']
                                                            ['pr_price']
                                                    ? Container()
                                                    : Text(
                                                        "\$${provider.productdetail['DATA']['prDetail']['pr_price']}",
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            // fontWeight: FontWeight.bold,
                                                            fontSize:
                                                                allsize *
                                                                    0.0115),
                                                      ),
                                                provider.productdetail[
                                                                    'DATA']
                                                                [
                                                                'prDetail']
                                                            [
                                                            'pr_lprice'] ==
                                                        provider.productdetail[
                                                                    'DATA']
                                                                [
                                                                'prDetail']
                                                            ['pr_price']
                                                    ? Container()
                                                    : Container(
                                                        height:
                                                            size.height *
                                                                0.03,
                                                        width:
                                                            size.width *
                                                                0.2,
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
                                                            "${FunctionClass().findoff(provider.detail['pr_price'], provider.detail['pr_lprice'])}% OFF",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red,
                                                                fontSize:
                                                                    allsize *
                                                                        0.01,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                            provider.detail[
                                                        'pr_is_backissue'] ==
                                                    "0"
                                                ? Container()
                                                : Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Please Select A Grade",
                                                      style: TextStyle(
                                                          fontSize:
                                                              allsize *
                                                                  0.015,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                    )),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            provider.detail[
                                                        'pr_is_backissue'] ==
                                                    "0"
                                                ? Container()
                                                : Theme(
                                                    data: Theme.of(
                                                            context)
                                                        .copyWith(
                                                            dividerColor:
                                                                Colors
                                                                    .transparent),
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: DataTable(
                                                        headingRowColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    getColor),
                                                        headingRowHeight:
                                                            size.height *
                                                                0.040,
                                                        horizontalMargin:
                                                            0,
                                                        // columnSpacing:size.width*0.06,
                                                        // Add column spacing for better visibility
                                                        dataRowHeight:
                                                            size.height *
                                                                0.050,
                                                        columns: <DataColumn>[
                                                          DataColumn(
                                                            label: Text(
                                                              'Grade',
                                                              style: TextStyle(
                                                                  color: Colors.grey[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      allsize *
                                                                          0.015), // Set text color for the heading
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                              'Price',
                                                              style: TextStyle(
                                                                  color: Colors.grey[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      allsize *
                                                                          0.015), //// Set text color for the heading
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                              'List Price',
                                                              style: TextStyle(
                                                                  color: Colors.grey[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      allsize *
                                                                          0.015), //// Set text color for the heading
                                                            ),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                              'Discount',
                                                              style: TextStyle(
                                                                  color: Colors.grey[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      allsize *
                                                                          0.015), // // Set text color for the heading
                                                            ),
                                                          ),
                                                        ],
                                                        rows: List.generate(
                                                            grades.length,
                                                            (index) {
                                                          final item =
                                                              grades[
                                                                  index];
                                                          return DataRow(
                                                            color: index %
                                                                        2 ==
                                                                    0
                                                                ? null
                                                                : MaterialStateProperty
                                                                    .resolveWith(
                                                                        getColor),
                                                            cells: [
                                                              DataCell(
                                                                  Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Transform
                                                                      .scale(
                                                                    scale:
                                                                        allsize * 0.0013,
                                                                    child: Radio(
                                                                        activeColor: const Color(0xff006ccf),
                                                                        value: item['condition_name'],
                                                                        groupValue: provider.groupvalue,
                                                                        onChanged: (value) async {
                                                                          Map<String, dynamic>? data = searchProductIdByCondition(value);
                                                                          setState(() {
                                                                            provider.setgroupvalue(value);
                                                                            widget.productid = data!['pr_id'];
                                                                          });
                                                                          provider.updatedetailongrades(data!);
                                                                          // Map<String, dynamic> data = await ApiRequests().ProductDetail(widget.productid, context);
                                                                          // provider.updateProductDetail(data);
                                                                        }),
                                                                  ),
                                                                  Text(
                                                                    item[
                                                                        'condition_name'],
                                                                    style:
                                                                        TextStyle(fontSize: allsize * 0.017),
                                                                  ),
                                                                ],
                                                              )),
                                                              DataCell(
                                                                  Text(
                                                                "\$${item['pr_price']}",
                                                                style: TextStyle(
                                                                    decoration: TextDecoration
                                                                        .lineThrough,
                                                                    color: Colors.grey[
                                                                        600],
                                                                    fontSize:
                                                                        allsize * 0.017),
                                                              )),
                                                              DataCell(
                                                                  Text(
                                                                "\$${item['pr_lprice']}",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    fontSize:
                                                                        allsize * 0.017),
                                                              )),
                                                              DataCell(
                                                                  Text(
                                                                "${FunctionClass().findoff(grades[index]['pr_price'], grades[index]['pr_price'])}2% OFF",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        allsize * 0.017),
                                                              )),
                                                            ],
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                  ),
                                            provider.multiplecoverlist
                                                    .isEmpty
                                                ? Container()
                                                : Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Available in Multiple Covers",
                                                      style: TextStyle(
                                                          fontSize:
                                                              allsize *
                                                                  0.015,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                    )),
                                            provider.multiplecoverlist
                                                    .isEmpty
                                                ? Container()
                                                : GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount:
                                                                2,
                                                            mainAxisSpacing:
                                                                8.0,
                                                            crossAxisSpacing:
                                                                8.0,
                                                            childAspectRatio:
                                                                2 / 1.1),
                                                    padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                    // padding around the grid
                                                    itemCount: provider
                                                        .multiplecoverlist
                                                        .length,
                                                    // total number of items
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          provider
                                                              .chanddetai(
                                                                  {});
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ProductDetialPage(
                                                                        productid: provider.multiplecoverlist[index]['pr_id'],
                                                                      )));
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black26,
                                                                blurRadius:
                                                                    0.7,
                                                                offset:
                                                                    Offset(
                                                                        0,
                                                                        2),
                                                              ),
                                                            ],
                                                          ),
                                                          child:
                                                              Container(
                                                            color: Colors
                                                                .white,
                                                            child:
                                                                Padding(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                      8.0),
                                                              child:
                                                                  Column(
                                                                children: [
                                                                  Text(
                                                                    provider.multiplecoverlist[index]
                                                                        [
                                                                        'pr_ttle'],
                                                                    maxLines:
                                                                        2,
                                                                    overflow:
                                                                        TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        color: Colors.grey[600],
                                                                        fontWeight: FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        size.height * 0.01,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      Text(
                                                                        "\$${provider.multiplecoverlist[index]['pr_lprice']}",
                                                                        style: TextStyle(
                                                                            // decoration: TextDecoration.lineThrough,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: allsize * 0.0115),
                                                                      ),
                                                                      provider.multiplecoverlist[index]['pr_lprice'] == provider.multiplecoverlist[index]['pr_price']
                                                                          ? Container()
                                                                          : Text(
                                                                              "\$${provider.multiplecoverlist[index]['pr_price']}",
                                                                              style: TextStyle(
                                                                                  decoration: TextDecoration.lineThrough,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontSize: allsize * 0.0115),
                                                                            ),
                                                                      provider.multiplecoverlist[index]['pr_lprice'] == provider.multiplecoverlist[index]['pr_price']
                                                                          ? Container()
                                                                          : Center(
                                                                              child: Text(
                                                                                "${FunctionClass().findoff(provider.multiplecoverlist[index]['pr_price'], provider.multiplecoverlist[index]['pr_lprice'])}% OFF",
                                                                                style: TextStyle(color: Colors.red, fontSize: allsize * 0.01, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            if (provider.detail[
                                                        'in_cart'] ==
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
                                                            provider.loginuserdata
                                                                    .isEmpty
                                                                ? Get.to(
                                                                    const SignInScreen())
                                                                : showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext context) {
                                                                      return Dialog(
                                                                        insetPadding: EdgeInsets.symmetric(horizontal: allsize * 0.016, vertical: allsize * 0.04),
                                                                        child: SingleChildScrollView(
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: item.map<Widget>((String item) {
                                                                              return ListTile(
                                                                                title: Text(item),
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    if (item == '-Remove-') {
                                                                                      showdialugue = false;
                                                                                      dropdownValue = '1 in Cart';
                                                                                      provider.call(provider.detail['pr_id'], "0", "1",provider.detail['addedtowl']);
                                                                                      provider.updatedetail("0", "1");
                                                                                    }
                                                                                    dropdownValue = item;
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                  final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                                                                  int value1 = FunctionClass().extractIntegerBeforeSpace(item);
                                                                                  // ApiRequests().Savedata(widget.productid,item == "-Remove-" ? "0" : value1.toString(), context);
                                                                                  var request = http.Request('GET', Uri.parse('https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${streamedDataProvider.loginuserdata['sh_id']}&pr_id=${widget.productid}&sc_qty=${item == "-Remove-" ? "0" : value1}&app_id='));
                                                                                  http.StreamedResponse response = await request.send();
                                                                                  if (response.statusCode == 200) {
                                                                                    final data = await response.stream.bytesToString();
                                                                                    streamedDataProvider.updateCartData(jsonDecode(data));
                                                                                    debugPrint(data.toString());
                                                                                    Map<String, dynamic> datache = jsonDecode(data);
                                                                                  } else {
                                                                                    debugPrint(response.reasonPhrase);
                                                                                  }
                                                                                  provider.updatedetail("1", value1.toString());
                                                                                  provider.call(widget.productid, "1", value1.toString(),provider.detail['addedtowl']);
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
                                                              dropdownValue:
                                                                  dropdownValue,
                                                              allsize:
                                                                  allsize),
                                                        ):
                                                  int.parse(provider.detail['pr_qty'])==0?
                              InkWell(
                                child: Container(
                                height: size.height * 0.06,
                                color:int.parse(provider.detail['addedtowl'])>0?Colors.grey:Colors.red,
                                child: Center(
                                child: Text(
                                  int.parse(provider.detail['addedtowl'])>0?"ADDED TO WISH LIST":
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
                                                      : InkWell(
                                                          onTap:
                                                              () async {
                                                            if (provider
                                                                .loginuserdata
                                                                .isEmpty) {
                                                              Get.to(
                                                                  const SignInScreen());
                                                            } else {
                                                              provider.call(
                                                                  provider
                                                                      .detail['pr_id'],
                                                                  "1",
                                                                  "1",
                                                                provider.detail['addedtowl']
                                                              );
                                                              provider
                                                                  .updatedetail(
                                                                      "1",
                                                                      "1");
                                                              setState(
                                                                  () {
                                                                change =
                                                                    true; // Set the loading flag to true
                                                              });
                                                              // Make your API request
                                                              final streamedDataProvider = Provider.of<
                                                                      StreamedDataProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                              Map<String, dynamic> data = await ApiRequests().Savedata(
                                                                  streamedDataProvider.loginuserdata[
                                                                      'sh_id'],
                                                                  provider
                                                                      .detail['pr_id'],
                                                                  1,
                                                                  context);

                                                              setState(
                                                                  () {
                                                                change =
                                                                    false; // Set the loading flag to false when the API request is done
                                                                showdialugue =
                                                                    true; // Show the dropdown after the button is pressed
                                                              });

                                                              streamedDataProvider
                                                                  .updateCartData(
                                                                      data);
                                                            }
                                                          },
                                                          child:
                                                              ButtonWidget(
                                                            quan: provider
                                                                    .detail[
                                                                'pr_qty'],
                                                            preorder: provider
                                                                    .detail[
                                                                'pr_advord'],
                                                          ),
                                                        )
                                            else
                                              InkWell(
                                                onTap: () {
                                                  provider.loginuserdata
                                                          .isEmpty
                                                      ? Get.to(
                                                          const SignInScreen())
                                                      : showDialog(
                                                          context:
                                                              context,
                                                          builder:
                                                              (BuildContext
                                                                  context) {
                                                            return Dialog(
                                                              insetPadding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      allsize *
                                                                          0.016,
                                                                  vertical:
                                                                      allsize *
                                                                          0.04),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child:
                                                                    Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize.min,
                                                                  children:
                                                                      item.map<Widget>((String
                                                                          item) {
                                                                    return ListTile(
                                                                      title:
                                                                          Text(item),
                                                                      onTap:
                                                                          () async {
                                                                        setState(() {
                                                                          if (item == '-Remove-') {
                                                                            showdialugue = false;
                                                                            dropdownValue = '1 in Cart';
                                                                            provider.call(provider.detail['pr_id'], "0", "1",provider.detail['addedtowl']);
                                                                            provider.updatedetail("0", "1");
                                                                          }
                                                                          dropdownValue = item;
                                                                        });
                                                                        Navigator.of(context).pop();
                                                                        final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                                                        int value1 = FunctionClass().extractIntegerBeforeSpace(item);
                                                                        // ApiRequests().Savedata(widget.productid,item == "-Remove-" ? "0" : value1.toString(), context);
                                                                        var request = http.Request('GET', Uri.parse('https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${streamedDataProvider.loginuserdata['sh_id']}&pr_id=${widget.productid}&sc_qty=${item == "-Remove-" ? "0" : value1}&app_id='));
                                                                        http.StreamedResponse response = await request.send();
                                                                        if (response.statusCode == 200) {
                                                                          final data = await response.stream.bytesToString();
                                                                          streamedDataProvider.updateCartData(jsonDecode(data));
                                                                          Map<String, dynamic> datache = jsonDecode(data);
                                                                        } else {
                                                                          debugPrint(response.reasonPhrase);
                                                                        }
                                                                        provider.updatedetail("1", value1.toString());
                                                                        provider.call(widget.productid, "1", value1.toString(),provider.detail['addedtowl']);
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
                                                    dropdownValue:
                                                        dropdownValue,
                                                    allsize: allsize),
                                              ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            provider.detail['su_id'] == "0"
                                                ? Container()
                                                : provider.detail['issubscribe'] == "0"?
                                            InkWell(
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
                                                          provider.detail[
                                                              'pr_writ'],
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
                                                          provider.detail[
                                                              'pr_artst'],
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
                                                    "<p>${provider.detail['pr_sdesc']}</p>",
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
                                                      color: Colors
                                                          .grey[500]),
                                                )),
                                                Flexible(
                                                    child: Text(
                                                  "Diamond Code:${provider.detail['pre_code']}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          allsize * 0.009,
                                                      color: Colors
                                                          .grey[500]),
                                                )),
                                                Flexible(
                                                    child: Text(
                                                  "UPC:${provider.detail['upc']}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          allsize * 0.009,
                                                      color: Colors
                                                          .grey[500]),
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
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "MORE FROM ${provider.productdetail['DATA']['prDetail']['pr_writ']}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    allsize * 0.0143,
                                                fontWeight:
                                                    FontWeight.w500)),
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
                                                (provider.writer.length /
                                                        2)
                                                    .ceil(),
                                            // Display two items per page
                                            scrollDirection:
                                                Axis.horizontal,
                                            itemBuilder:
                                                (context, pageIndex) {
                                              FunctionClass()
                                                  .precacheImages(
                                                      provider.writer,
                                                      context);
                                              final startIndex =
                                                  pageIndex * 2;
                                              final endIndex =
                                                  startIndex + 2;

                                              return Padding(
                                                padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal:
                                                            size.width *
                                                                0.013),
                                                child: Row(
                                                  mainAxisAlignment: endIndex <=
                                                          provider.writer
                                                              .length
                                                      ? MainAxisAlignment
                                                          .spaceBetween
                                                      : MainAxisAlignment
                                                          .start,
                                                  children: [
                                                    for (var index =
                                                            startIndex;
                                                        index < endIndex;
                                                        index++)
                                                      if (index <
                                                          provider.writer
                                                              .length)
                                                        SizedBox(
                                                          // width: size.width * 0.47962,
                                                          // Adjust the width as needed
                                                          child:
                                                              FeatureNewRelease(
                                                            adultimage: provider
                                                                        .writer[
                                                                    index]
                                                                [
                                                                'hideadultimage'],
                                                            pulllist: provider
                                                                        .writer[
                                                                    index]
                                                                ['su_id'],
                                                            image: provider
                                                                        .writer[
                                                                    index]
                                                                ['pr_id'],
                                                            title: provider
                                                                        .writer[
                                                                    index]
                                                                [
                                                                'pr_ttle'],
                                                            prce1: provider
                                                                        .writer[
                                                                    index]
                                                                [
                                                                'pr_price'],
                                                            price2: provider
                                                                        .writer[
                                                                    index]
                                                                [
                                                                'pr_lprice'],
                                                            preorder: provider
                                                                        .writer[
                                                                    index]
                                                                [
                                                                'pr_advord'],
                                                            quantity: int.parse(
                                                                provider.writer[
                                                                        index]
                                                                    [
                                                                    'pr_qty']),
                                                            incart: int.parse(
                                                                provider.writer[
                                                                        index]
                                                                    [
                                                                    'in_cart']),
                                                            productquantity:
                                                                int.parse(
                                                                    provider.writer[index]
                                                                        [
                                                                        'pr_qty']),
                                                            qtycart: int.parse(
                                                                provider.writer[
                                                                        index]
                                                                    [
                                                                    'sc_qty']),
                                                            data: provider
                                                                    .writer[
                                                                index], parentid: provider
                                                                  .writer[
                                                              index]['pr_parentid'], addedtowl: int.parse(provider
                                                                  .writer[
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "MORE FROM ${provider.productdetail['DATA']['prDetail']['pr_artst']}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    allsize * 0.0143,
                                                fontWeight:
                                                    FontWeight.w500)),
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
                                                (provider.artist.length /
                                                        2)
                                                    .ceil(),
                                            // Display two items per page
                                            scrollDirection:
                                                Axis.horizontal,
                                            itemBuilder:
                                                (context, pageIndex) {
                                              FunctionClass()
                                                  .precacheImages(
                                                      provider.artist,
                                                      context);
                                              final startIndex =
                                                  pageIndex * 2;
                                              final endIndex =
                                                  startIndex + 2;

                                              return Padding(
                                                padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal:
                                                            size.width *
                                                                0.013),
                                                child: Row(
                                                  mainAxisAlignment: endIndex <=
                                                          provider.artist
                                                              .length
                                                      ? MainAxisAlignment
                                                          .spaceBetween
                                                      : MainAxisAlignment
                                                          .start,
                                                  children: [
                                                    for (var index =
                                                            startIndex;
                                                        index < endIndex;
                                                        index++)
                                                      if (index <
                                                          provider.artist
                                                              .length)
                                                        SizedBox(
                                                          // width: size.width * 0.47962,
                                                          // Adjust the width as needed
                                                          child:
                                                              FeatureNewRelease(
                                                            adultimage: provider
                                                                        .artist[
                                                                    index]
                                                                [
                                                                'hideadultimage'],
                                                            pulllist: provider
                                                                        .artist[
                                                                    index]
                                                                ['su_id'],
                                                            image: provider
                                                                        .artist[
                                                                    index]
                                                                ['pr_id'],
                                                            title: provider
                                                                        .artist[
                                                                    index]
                                                                [
                                                                'pr_ttle'],
                                                            prce1: provider
                                                                        .artist[
                                                                    index]
                                                                [
                                                                'pr_price'],
                                                            price2: provider
                                                                        .artist[
                                                                    index]
                                                                [
                                                                'pr_lprice'],
                                                            preorder: provider
                                                                        .artist[
                                                                    index]
                                                                [
                                                                'pr_advord'],
                                                            quantity: int.parse(
                                                                provider.artist[
                                                                        index]
                                                                    [
                                                                    'pr_qty']),
                                                            incart: int.parse(
                                                                provider.artist[
                                                                        index]
                                                                    [
                                                                    'in_cart']),
                                                            productquantity:
                                                                int.parse(
                                                                    provider.artist[index]
                                                                        [
                                                                        'pr_qty']),
                                                            qtycart: int.parse(
                                                                provider.artist[
                                                                        index]
                                                                    [
                                                                    'sc_qty']),
                                                            data: provider
                                                                    .artist[
                                                                index], parentid: provider
                                                                  .artist[
                                                              index]['pr_parentid'], addedtowl: int.parse(provider
                                                                  .artist[
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Recently Viewed",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    allsize * 0.0143,
                                                fontWeight:
                                                    FontWeight.w500)),
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
                                            itemCount: (provider
                                                        .recentlyview
                                                        .length /
                                                    2)
                                                .ceil(),
                                            // Display two items per page
                                            scrollDirection:
                                                Axis.horizontal,
                                            itemBuilder:
                                                (context, pageIndex) {
                                              FunctionClass()
                                                  .precacheImages(
                                                      provider
                                                          .recentlyview,
                                                      context);
                                              final startIndex =
                                                  pageIndex * 2;
                                              final endIndex =
                                                  startIndex + 2;

                                              return Padding(
                                                padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal:
                                                            size.width *
                                                                0.013),
                                                child: Row(
                                                  mainAxisAlignment: endIndex <=
                                                          provider
                                                              .recentlyview
                                                              .length
                                                      ? MainAxisAlignment
                                                          .spaceBetween
                                                      : MainAxisAlignment
                                                          .start,
                                                  children: [
                                                    for (var index =
                                                            startIndex;
                                                        index < endIndex;
                                                        index++)
                                                      if (index <
                                                          provider
                                                              .recentlyview
                                                              .length)
                                                        SizedBox(
                                                          // width: size.width * 0.47962,
                                                          // Adjust the width as needed
                                                          child:
                                                              FeatureNewRelease(
                                                            adultimage: provider
                                                                        .recentlyview[
                                                                    index]
                                                                [
                                                                'hideadultimage'],
                                                            pulllist: provider
                                                                        .recentlyview[
                                                                    index]
                                                                ['su_id'],
                                                            image: provider
                                                                        .recentlyview[
                                                                    index]
                                                                ['pr_id'],
                                                            title: provider
                                                                        .recentlyview[
                                                                    index]
                                                                [
                                                                'pr_ttle'],
                                                            prce1: provider
                                                                        .recentlyview[
                                                                    index]
                                                                [
                                                                'pr_price'],
                                                            price2: provider
                                                                        .recentlyview[
                                                                    index]
                                                                [
                                                                'pr_lprice'],
                                                            preorder: provider
                                                                        .recentlyview[
                                                                    index]
                                                                [
                                                                'pr_advord'],
                                                            quantity: int.parse(
                                                                provider.recentlyview[
                                                                        index]
                                                                    [
                                                                    'pr_qty']),
                                                            incart: int.parse(
                                                                provider.recentlyview[
                                                                        index]
                                                                    [
                                                                    'in_cart']),
                                                            productquantity:
                                                                int.parse(
                                                                    provider.recentlyview[index]
                                                                        [
                                                                        'pr_qty']),
                                                            qtycart: int.parse(
                                                                provider.recentlyview[
                                                                        index]
                                                                    [
                                                                    'sc_qty']),
                                                            data: provider
                                                                    .recentlyview[
                                                                index], parentid: provider
                                                                  .recentlyview[
                                                              index]['pr_parentid'], addedtowl: int.parse(provider
                                                                  .recentlyview[
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
                              ],
                            );
                          }),

                    //Best Seller
                    const SubcribeWidget(),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const Footer(),
                    SizedBox(
                      height: size.height * 0.05,
                    )
                  ],
                ),
              );
            })),
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
