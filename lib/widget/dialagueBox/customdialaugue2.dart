// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:midtowncomics/export.dart';

class CustomDialougue2 extends StatelessWidget {
  const CustomDialougue2({super.key,});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Dialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: allsize * 0.012, vertical: allsize * 0.01),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
        child:
            Consumer<StreamedDataProvider>(builder: (context, provider, child) {
              List<dynamic>cartdatalist=provider.cartdata['DATA']==null?[]:provider.cartdata['DATA']['cartList'];
              String totalcart=provider.cartdata['DATA']==null?"0":cartdatalist[0]['cart_total_qty'];
              double totalprice = double.parse(provider.cartdata['DATA']==null?"0":cartdatalist[0]['cart_total']);
              int convert = totalprice.toInt();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Cart ($totalcart)",
                        style: TextStyle(fontSize: allsize * 0.011),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            CupertinoIcons.clear,
                            color: Colors.black,
                            size: allsize * 0.02,
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                height: size.height * 0.1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$$totalprice",
                        style: TextStyle(
                            color: Colors.grey[600], fontSize: allsize * 0.011,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Spend \$89 to receive Free Shipping ",
                              style: TextStyle(fontSize: allsize * 0.011),
                            ),
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            SizedBox(
                              width: size.width * 0.5,
                              child: LinearProgressIndicator(
                                value: convert / 89,
                                color: const Color(0xff006ccf),
                                backgroundColor: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "\$89",
                        style: TextStyle(
                            color: Colors.grey[600], fontSize: allsize * 0.011,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.57,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: ListView.builder(
                        itemCount: cartdatalist.length,
                        itemBuilder: (context, index) {
                          double quantity =
                              double.parse(cartdatalist[index]['pr_price']);
                          int quant = quantity.toInt();
                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.15,
                                        width: size.width * 0.20,
                                        child: Image.network(
                                          "https://www.midtowncomics.com/images/PRODUCT/FUL/${cartdatalist[index]['pr_id']}_ful.jpg",
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
                                          // fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.38,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartdatalist[index]['pr_ttle'],
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: allsize * 0.01),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                provider.call(cartdatalist[index]['pr_id'], "0","1",cartdatalist[index]['addedtowl']);
                                                final streamedDataProvider =
                                                Provider.of<
                                                    StreamedDataProvider>(
                                                    context,
                                                    listen: false);
                                                var request = http.Request(
                                                    'GET',
                                                    Uri.parse(
                                                        'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${streamedDataProvider.loginuserdata['sh_id']}&pr_id=${cartdatalist[index]['pr_id']}&sc_qty=0&app_id='));
                                                http.StreamedResponse
                                                response =
                                                await request.send();
                                                if (response.statusCode ==
                                                    200) {
                                                  final data = await response
                                                      .stream
                                                      .bytesToString();
                                                  streamedDataProvider
                                                      .updateCartData(
                                                      jsonDecode(data));
                                                  Map<String, dynamic>
                                                  datache =
                                                  jsonDecode(data);
                                                  // Map<String,dynamic>refresh=await ApiRequests().fetchData1(context);
                                                  // streamedDataProvider.updateData(refresh);
                                                } else {
                                                  debugPrint(
                                                      response.reasonPhrase);
                                                }
                                              },

                                              child: Text(
                                                'Remove',
                                                style: TextStyle(
                                                    fontSize: allsize * 0.013,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "QTY ${cartdatalist[index]['sc_qty']}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: allsize * 0.011),
                                            ),
                                            Text(
                                              "\$$quant",
                                              style: TextStyle(
                                                  fontSize: allsize * 0.011),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        })),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              fontSize: allsize * 0.022),
                        ),
                        Text(
                          "\$$totalprice",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              fontSize: allsize * 0.022),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        Get.to(const CartDetail());
                      },
                      child: Container(
                        height: size.height * 0.065,
                        width: double.infinity,
                        color: const Color(0xff006ccf),
                        child: Center(
                          child: Text(
                            "VIEW CART",
                            style: TextStyle(
                                color: Colors.white, fontSize: allsize * 0.018,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }));
  }
}
