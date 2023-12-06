// ignore_for_file: must_be_immutable, depend_on_referenced_packages
import 'package:midtowncomics/screen/ProductDetailPage.dart';
import 'package:http/http.dart'as http;
import 'package:midtowncomics/export.dart';

import 'dialagueBox/CustomProductDialugue.dart';

class FeatureNewRelease extends StatefulWidget {
  // String title;
  Map<String, dynamic> data;
  String? title, prce1, price2, image, pulllist, preorder, adultimage,parentid;
  int? quantity, incart, productquantity, qtycart,addedtowl;

  FeatureNewRelease(
      {super.key,
      this.title,
      this.preorder,
      this.prce1,
      this.price2,
      this.image,
      this.pulllist,
      this.quantity,
      this.adultimage,
      this.incart,
      this.productquantity,
      required this.qtycart,
      required this.data,
        required this.parentid,
      required this.addedtowl});

  @override
  State<FeatureNewRelease> createState() => _FeatureNewReleaseState();
}

class _FeatureNewReleaseState extends State<FeatureNewRelease> {
  bool cartupdate = false;
  String dropdownValue = '1 in Cart';
  List<String> item = [];
  bool change = false;
  bool showDropdown = false;
  bool showbutton = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      dropdownValue =
          widget.qtycart == 0 ? "1 in Cart" : '${widget.qtycart} in Cart';
      if (widget.productquantity! > 25) {
        item = FunctionClass().generateStringListFromInteger(25);
      } else {
        item = FunctionClass().generateStringListFromInteger(widget.productquantity!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<StreamedDataProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: () async {
          provider.chanddetai({});
          String value="";
           value=await showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPrdoductDiallugue(
               productid:widget.image!,
              );
            },
          );
           setState(() {
             dropdownValue=value;
           });
        },
        child: Stack(
          children: [
            SizedBox(
              width: size.width * 0.445,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: size.height * 0.18,
                      width: size.width * 0.3,
                      child: Image.network(
                        widget.adultimage == '0'
                            ? "https://www.midtowncomics.com/images/PRODUCT/FUL/${widget.image}_ful.jpg"
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
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.01,),
                  SizedBox(
                    height: size.height * 0.06,
                    child: InkWell(
                      onTap: () {
                        provider.chanddetai({});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetialPage(
                                      productid: widget.image!,
                                    )));
                        // Get.off(ProductDetialPage(
                        //   productid: widget.image!,
                        // ));
                      },
                      child: Text(
                        widget.title!.isNotEmpty
                            ? widget.title!
                            : "----------",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: allsize * 0.013,
                            fontWeight: FontWeight.w500,
                          fontFamily: ' oswald_bold'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  double.parse(widget.prce1!) == double.parse(widget.price2!)
                      ? Container(
                          height: size.height * 0.03,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${widget.prce1}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: ' oswald_bold',
                                  fontSize: allsize * 0.0135),
                            ),
                            InkWell(
                              onTap: (){
                                print(provider.recommendedforyou);
                              },
                              child: Container(
                                height: size.height * 0.033,
                                width: size.width * 0.24,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffe3483c), width: 3.4),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "${FunctionClass().findoff(widget.prce1!,widget.price2!)}% OFF",
                                    style: TextStyle(
                                        color: const Color(0xffe3483c),
                                        fontSize: allsize * 0.011,
                                        fontFamily: ' oswald_bold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    "\$${widget.price2}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: allsize * 0.0115),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  if (widget.incart == 0 || change || showbutton)
                    change
                        ? const Center(
                            child:
                                CircularProgressIndicator(), // Show a circular progress indicator while loading
                          ) :showDropdown
                        ?InkWell(
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
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: item.map<Widget>((String item) {
                                    return ListTile(
                                      title: Text(item),
                                      onTap: () async {
                                        setState(() {
                                          if (item == '-Remove-') {
                                            showDropdown = false;
                                            dropdownValue = '1 in Cart';
                                            provider.call(widget.image!, "0","1",widget.addedtowl.toString());
                                          }
                                          dropdownValue = item;

                                        });
                                        Navigator.of(context).pop();
                                        final streamedDataProvider =
                                        Provider.of<StreamedDataProvider>(
                                            context,
                                            listen: false);
                                        int value1 =
                                        FunctionClass(). extractIntegerBeforeSpace(item);
                                        var request = http.Request(
                                            'GET',
                                            Uri.parse(
                                                'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=76367&pr_id=${widget.image}&sc_qty=${ item == "-Remove-"
                                                    ? "0"
                                                    : value1}&app_id='));
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
                                        } else {
                                          debugPrint(
                                              response.reasonPhrase);
                                        }
                                        provider.call(widget.image!, "1",value1.toString(),widget.addedtowl.toString());
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
                        height: size.height * 0.06,
                        // Set the desired height of the custom dropdown button
                        width: 200,
                        // Set the desired width of the custom dropdown button
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
                      ),
                    ):
                    widget.quantity==0?
                    InkWell(
                      onTap: (){
                        if(widget.addedtowl!>0)
                          {
                            Get.to(const MyWishListScreen());
                          }
                        else{
                          final streamedDataProvider =
                          Provider.of<StreamedDataProvider>(context,
                              listen: false);
                          ApiRequests().saveToWishList(streamedDataProvider.loginuserdata['sh_id']
                              , widget.parentid);
                          provider.call(widget.image!,widget.data['in_cart'],widget.data['sc_qty'],"1");
                        }
                      },
                      child: Container(
                        height: size.height * 0.06,
                        color:widget.addedtowl!>0? Colors.grey:Colors.red,
                        child: Center(
                            child: Text(
                              widget.addedtowl!>0?"Added to Wish List": "Add to Wish List",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: allsize * 0.012),
                            )),
                      ),
                    )
                            : InkWell(
                                onTap: () async {
                                      if(provider.loginuserdata.isEmpty){
                                        Get.to(const SignInScreen());
                                  }
                                      else{
                                          provider.call(widget.image!, "1","1",widget.addedtowl.toString());
                                          debugPrint(widget.qtycart.toString());
                                          setState(() {
                                            change =
                                            true; // Set the loading flag to true
                                          });
                                          // Make your API request
                                          final streamedDataProvider =
                                          Provider.of<StreamedDataProvider>(context,
                                              listen: false);
                                          Map<String, dynamic> data =
                                          await ApiRequests()
                                              .Savedata( streamedDataProvider.loginuserdata['sh_id'],widget.image, 1, context);
                                          setState(() {
                                            change =
                                            false; // Set the loading flag to false when the API request is done
                                            showDropdown =
                                            true; // Show the dropdown after the button is pressed
                                          });
                                          streamedDataProvider.updateCartData(data);
                                      }
                                },
                                child: ButtonWidget(
                                  quan: widget.quantity.toString(),
                                  preorder: widget.preorder!,
                                ),
                              )
                  else
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
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: item.map<Widget>((String item) {
                                    return ListTile(
                                      title: Text(item),
                                      onTap: () async {
                                        setState(() {
                                          if (item == '-Remove-') {
                                            showDropdown = false;
                                            dropdownValue = '1 in Cart';
                                            provider.call(widget.image!, "0","1",widget.addedtowl.toString());
                                          }
                                          dropdownValue = item;

                                        });
                                        Navigator.of(context).pop();
                                        final streamedDataProvider =
                                            Provider.of<StreamedDataProvider>(
                                                context,
                                                listen: false);
                                        int value1 =
                                           FunctionClass(). extractIntegerBeforeSpace(item);
                                        var request = http.Request(
                                            'GET',
                                            Uri.parse(
                                                'https://www.midtowncomics.com/wcfmt/services/cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=${ streamedDataProvider.loginuserdata['sh_id']}&pr_id=${widget.image}&sc_qty=${ item == "-Remove-"
                                                    ? "0"
                                                    : value1}&app_id='));
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
                                        } else {
                                          debugPrint(
                                              response.reasonPhrase);
                                        }
                                        provider.call(widget.image!, "1",value1.toString(),widget.addedtowl.toString());
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
                        height: size.height * 0.06,
                        // Set the desired height of the custom dropdown button
                        width: 200,
                        // Set the desired width of the custom dropdown button
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
                      ),
                    ),
                ],
              ),
            ),
            widget.pulllist == '0'
                ? Container()
                : ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      height: size.height * 0.028,
                      width: size.width * 0.4,
                      color: const Color(0xff006ccf),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Padding(
                          padding: EdgeInsets.only(left:size.width*0.01),
                          child: Text(
                            "Available for pull list!",
                            style: TextStyle(
                                color: Colors.white, fontSize: allsize * 0.011),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      );
    });
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height); // Start from the top-left corner
    path.lineTo(size.width * 0.9, size.height); // Go to the bottom-right corner
    path.lineTo(size.width, 0); // Go to the top-right corner
    path.lineTo(0, 0); // Go back to the top-left corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
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
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Container(
      height: size.height * 0.06,
      color: (widget.preorder == "1")
          ? const Color(0xff9048c4)
              : const Color(0xff006ccf),
      child: Center(
          child: Text(
        widget.preorder == "1"
            ? "PRE-ORDER"
                : "ADD TO CART",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: allsize * 0.012),
      )),
    );
  }
}
