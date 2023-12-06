// ignore_for_file: must_be_immutable, depend_on_referenced_packages, use_build_context_synchronously


import 'package:http/http.dart' as http;

import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

class CartDetail extends StatefulWidget {
  const CartDetail({super.key});

  @override
  State<CartDetail> createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  bool active = true;
  bool inactive = false;
  TextEditingController searchcontroller = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String countryValue="-SELECT COUNTRY-";
  @override
  Widget build(BuildContext context) {
    ApiRequests().GetCountries(context);
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size(size.width*1,allsize*0.11),
          child: Header_Widget(
            ontap: () => scaffoldKey.currentState!.openDrawer(),
            searchcontroller:searchcontroller,
          ),),
        key: scaffoldKey,
        drawer: const Custom_drawer(),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Consumer<StreamedDataProvider>(
                    builder: (context, provider, child) {
                  List<dynamic> cartdatalist =
                      provider.cartdata['DATA'] == null
                          ? []
                          : provider.cartdata['DATA']['cartList'];
                  String totalcart = provider.cartdata['DATA'] == null
                      ? "0"
                      : cartdatalist[0]['cart_total_qty'];
                  double totalprice = double.parse(
                      provider.cartdata['DATA'] == null
                          ? "0"
                          : cartdatalist[0]['cart_total']);
                  int convert = totalprice.toInt();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchList(searchcontroller: searchcontroller),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Your Cart",
                          style: TextStyle(
                              fontSize: allsize * 0.02,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500]),
                        ),
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
                                offset: Offset(1, 1),
                              ),
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 0.2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Regular Items",
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: allsize * 0.017,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "\$$convert",
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: allsize * 0.011),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.5,
                                            child: LinearProgressIndicator(
                                              value: convert / 89,
                                              color: const Color(0xff006ccf),
                                              backgroundColor: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "89",
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: allsize * 0.011),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Text(
                                    "Spend \$${89 - convert} to unlock free Shipping",
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                        fontSize: allsize * 0.013),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Subtotal($totalcart Items)",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: allsize * 0.012),
                                      ),
                                      Text(
                                        "\$$totalprice",
                                        style: TextStyle(
                                            fontSize: allsize * 0.012,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: allsize * 0.016),
                                      ),
                                      Text(
                                        "\$$totalprice",
                                        style: TextStyle(
                                            fontSize: allsize * 0.017,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: size.height * 0.06,
                          width: double.infinity,
                          color: const Color(0xff006ccf),
                          child: Center(
                            child: Text(
                              "CHECK OUT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: allsize * 0.014),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      //Promo Codes
                      Text(
                        "Apply Promo Code",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: allsize * 0.016),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.6,
                              child: TextFormField(),
                            ),
                            SizedBox(
                              width: size.width * 0.1,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Apply",
                                  style:
                                      TextStyle(fontSize: allsize * 0.015),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        "Use a Gift Card",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: allsize * 0.016),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.5,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "GC#",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: allsize * 0.013)),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.4,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "PIN #",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: allsize * 0.013)),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: size.height * 0.06,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff006ccf), width: 3)),
                          child: Center(
                            child: Text(
                              "APPLY GIFT CARD",
                              style: TextStyle(
                                  color: const Color(0xff006ccf),
                                  fontSize: allsize * 0.014),
                            ),
                          ),
                        ),
                      ),
                      //Shipping Cost Calculator
                      Text(
                        "Shipping Cost Calculator",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.015),
                      ),
                      Text(
                        "International Residents, Please Select your country",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w300,
                            fontSize: allsize * 0.012),
                      ),
                      //Dropdown
                      InkWell(
                        onTap: () {
                          provider.loginuserdata.isEmpty?
                          Get.to(const SignInScreen()):
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                insetPadding: EdgeInsets.symmetric(
                                    horizontal: allsize * 0.016,
                                    vertical: allsize * 0.04),
                                child: Scrollbar(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: provider.countries.map<Widget>((dynamic item) {
                                        return ListTile(
                                          title: Text(item['ct_name']),
                                          onTap: () async {
                                            setState(() {
                                              countryValue=item['ct_name'];
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Row(
                            children: [
                              Container(
                                height: size.height * 0.06,
                                width: size.width * 0.6,
                                decoration:
                                BoxDecoration(color: Colors.grey[300]),
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        countryValue,
                                        style: TextStyle(
                                            fontSize: allsize * 0.014),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: allsize * 0.02,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "APPLY",
                                    style: TextStyle(
                                        fontSize: allsize * 0.016,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 7),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         height: size.height * 0.06,
                      //         width: size.width * 0.7,
                      //         decoration:
                      //             BoxDecoration(color: Colors.grey[300]),
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               countryValue,
                      //               style: TextStyle(
                      //                   fontSize: allsize * 0.014),
                      //             ),
                      //             Icon(
                      //               Icons.arrow_drop_down,
                      //               size: allsize * 0.02,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: size.width * 0.05,
                      //       ),
                      //       TextButton(
                      //           onPressed: () {},
                      //           child: Text(
                      //             "APPLY",
                      //             style: TextStyle(
                      //                 fontSize: allsize * 0.016,
                      //                 fontWeight: FontWeight.bold),
                      //           ))
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      //List Of Product
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Row(
                          children: [
                            Text(
                              "Your Regular Item",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.019),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Text(
                              "$totalcart Items",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: allsize * 0.015),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xff006ccf),
                        thickness: 2,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartdatalist.length,
                          itemBuilder: (context, index) {
                            return DetailPageListViewWidget(
                              size: size,
                              cartdatalist: cartdatalist,
                              allsize: allsize,
                              index: index,
                            );
                          }),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const SubcribeWidget(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Footer(),
                      SizedBox(
                        height: size.height * 0.05,
                      )
                    ],
                  );
                }))),
      ),
    );
  }
}

class DetailPageListViewWidget extends StatefulWidget {
  DetailPageListViewWidget({
    super.key,
    required this.size,
    required this.cartdatalist,
    required this.allsize,
    required this.index,
  });

  final Size size;
  final List cartdatalist;
  final double allsize;
  int index;

  @override
  State<DetailPageListViewWidget> createState() =>
      _DetailPageListViewWidgetState();
}

class _DetailPageListViewWidgetState extends State<DetailPageListViewWidget> {
  String dropdownValue = "1";

  List<String> items = [];

  List<String> generateStringListFromInteger(int count) {
    List<String> stringList = ["-Remove-"];

    for (int i = 1; i <= count; i++) {
      stringList.add('$i');
    }

    return stringList;
  }

  @override
  void initState() {
    dropdownValue = int.parse(widget.cartdatalist[widget.index]['sc_qty']) == 0
        ? "1 in Cart"
        : '${widget.cartdatalist[widget.index]['sc_qty']} in Cart';
    if (int.parse(widget.cartdatalist[widget.index]['pr_qty']) > 25) {
      items = generateStringListFromInteger(25);
    } else {
      items = generateStringListFromInteger(
          int.parse(widget.cartdatalist[widget.index]['pr_qty']));
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StreamedDataProvider>(
        builder: (context, provider, child){
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.2,
                    offset: Offset(1, 1),
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Container(
                height: widget.size.height * 0.27,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widget.size.width * 0.32,
                        child: Column(
                          children: [
                            Flexible(
                              child: SizedBox(
                                  width: widget.size.width * 0.35,
                                  child: Image.network(
                                    "https://www.midtowncomics.com/images/PRODUCT/FUL/${widget.cartdatalist[widget.index]['pr_id']}_ful.jpg",
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
                                    // fit: BoxFit.fill,
                                  )),
                            ),
                            SizedBox(
                              height: widget.size.height * 0.01,
                            ),
                            Row(
                              children: [
                                const Text("Qty"),
                                SizedBox(
                                  width: widget.size.width * 0.03,
                                ),
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
                                              children:
                                              items.map<Widget>((String item) {
                                                return ListTile(
                                                  title: Text(item),
                                                  onTap: () async {
                                                    setState(() {
                                                      if (item == '-Remove-') {
                                                        dropdownValue = '1 in Cart';
                                                      }
                                                      dropdownValue = item;
                                                    });
                                                    Navigator.of(context).pop();
                                                    final streamedDataProvider =
                                                    Provider.of<
                                                        StreamedDataProvider>(
                                                        context,
                                                        listen: false);
                                                    var request = http.Request(
                                                        'GET',
                                                        Uri.parse(
                                                            'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=76367&pr_id=${widget.cartdatalist[widget.index]['pr_id']}&sc_qty=${item == "-Remove-" ? "0" : item}&app_id='));
                                                    http.StreamedResponse response =
                                                    await request.send();
                                                    if (response.statusCode == 200) {
                                                      // Provider.of<StreamedDataProvider>(
                                                      //     context,
                                                      //     listen: false)
                                                      //     .call(
                                                      //     widget.cartdatalist[widget
                                                      //         .index]['pr_id'],
                                                      //     item == "-Remove-"
                                                      //         ? "0"
                                                      //         : "1",
                                                      //     item.toString());
                                                      final data = await response
                                                          .stream
                                                          .bytesToString();
                                                      streamedDataProvider
                                                          .updateCartData(
                                                          jsonDecode(data));
                                                      Map<String, dynamic> datache =
                                                      jsonDecode(data);
                                                      debugPrint(datache['DATA']
                                                      ['cartList']);
                                                      Map<String, dynamic> refresh =
                                                      await ApiRequests()
                                                          .fetchData1(provider.loginuserdata.isEmpty?"":provider.loginuserdata['sh_id']);
                                                      streamedDataProvider
                                                          .updateData(refresh);
                                                    } else {
                                                      debugPrint(response.reasonPhrase);
                                                    }
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
                                    height: widget.size.height * 0.0365,
                                    width: widget.size.width * 0.22,
                                    decoration:
                                    BoxDecoration(color: Colors.grey[300]),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dropdownValue,
                                          style: TextStyle(
                                              fontSize: widget.allsize * 0.01),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: widget.allsize * 0.012,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.cartdatalist[widget.index]['pr_ttle'],
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
                                  const Text(
                                    "By ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    widget.cartdatalist[widget.index]['mn_name'],
                                    style: const TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: widget.size.height * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "\$${widget.cartdatalist[widget.index]['pr_price']}",
                                          style: TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              fontSize: widget.allsize * 0.011),
                                        ),
                                        SizedBox(
                                          height: widget.size.height * 0.005,
                                        ),
                                        Text(
                                          "\$${widget.cartdatalist[widget.index]['pr_lprice']}",
                                          style: TextStyle(
                                              fontSize: widget.allsize * 0.011),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: widget.size.height * 0.035,
                                      width: widget.size.width * 0.25,
                                      decoration: BoxDecoration(
                                          border:
                                          Border.all(color: Colors.red, width: 3),
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          "10% OFF",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: widget.allsize * 0.012,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: widget.size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "SHIP WITH\nPULL LIST",
                                        style: TextStyle(
                                            fontSize: widget.allsize * 0.008),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        final streamedDataProvider =
                                        Provider.of<StreamedDataProvider>(context,
                                            listen: false);
                                        var request = http.Request(
                                            'GET',
                                            Uri.parse(
                                                'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=76367&pr_id=${widget.cartdatalist[widget.index]['pr_id']}&sc_qty=0&app_id='));
                                        http.StreamedResponse response =
                                        await request.send();
                                        if (response.statusCode == 200) {
                                          Provider.of<StreamedDataProvider>(context,
                                              listen: false)
                                              .call(
                                              widget.cartdatalist[widget.index]
                                              ['pr_id'],
                                              "0",
                                              "1",widget.cartdatalist[widget.index]['addedtowl']);
                                          final data =
                                          await response.stream.bytesToString();
                                          streamedDataProvider
                                              .updateCartData(jsonDecode(data));
                                          Map<String, dynamic> datache =
                                          jsonDecode(data);
                                          debugPrint(datache['DATA']['cartList']);
                                          Map<String, dynamic> refresh =
                                          await ApiRequests().fetchData1(provider.loginuserdata.isEmpty?"":provider.loginuserdata['sh_id']);
                                          streamedDataProvider.updateData(refresh);
                                        } else {
                                          debugPrint(response.reasonPhrase);
                                        }
                                      },
                                      child: Text("Remove",
                                          style: TextStyle(
                                              fontSize: widget.allsize * 0.008))),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text("SAVE FOR\nLATER",
                                          style: TextStyle(
                                              fontSize: widget.allsize * 0.007))),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });

  }
}
