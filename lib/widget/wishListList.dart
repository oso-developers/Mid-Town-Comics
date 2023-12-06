
import 'package:midtowncomics/export.dart';

import '../provider/wishListProvider.dart';

class WishListList extends StatefulWidget {
  final int index;
  const WishListList({super.key,required this.index});

  @override
  State<WishListList> createState() => _WishListListState();
}

class _WishListListState extends State<WishListList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<WishListProvider>(
        builder: (context,wishList, child) {
      return  Container(
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
                        wishList.userWishListDataList[widget.index]['hideadultimage'] == '0'
                            ? "https://www.midtowncomics.com/images/PRODUCT/FUL/${wishList.userWishListDataList[widget.index]['pr_id']}_ful.jpg"
                            :
                        'https://www.midtowncomics.com/images/PRODUCT/FUL/adults_ful.jpg',
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                                child: Image.asset(
                                    'assets/images/imagecomingsoon_ful.jpg')
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
                        wishList.userWishListDataList[widget.index]["su_id"] == "0"
                            ? Container()
                            :
                        ClipPath(
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
                          wishList.userWishListDataList[widget.index]['pr_ttle'],
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
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: size.width*0.13,left: size.width*0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${wishList.userWishListDataList[widget.index]['pr_lprice']}",
                                style: TextStyle(
                                    fontSize: allsize * 0.011,
                                    fontWeight: FontWeight.bold),
                              ),
                              wishList.userWishListDataList[widget.index]['pr_price'] ==
                                  wishList.userWishListDataList[widget.index]['pr_lprice']
                                  ? Container()
                                  :
                              Text(
                                "${wishList.userWishListDataList[widget.index]['pr_price']}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: allsize * 0.011),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        wishList.userWishListDataList[widget.index]['pr_price'] ==
                            wishList.userWishListDataList[widget.index]['pr_lprice']
                            ? Container()
                            :
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:size.width*0.01),
                          child: Container(
                            height: size.height * 0.038,
                            width: size.width * 0.54,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.red, width: 3),
                                borderRadius:
                                BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                "${FunctionClass().findoff(wishList.userWishListDataList[widget.index]['pr_price'], wishList.userWishListDataList[widget.index]['pr_lprice'])}"
                                    "% OFF",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: allsize * 0.012,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        wishList.userWishListDataList[widget.index]["su_id"] == "0"
                            ? Container()
                            : wishList.userWishListDataList[widget.index]['issubscribe'] ==
                                    "0"
                                ?
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
                          onTap: () async {
                            debugPrint(wishList.userWishListDataList.toString());
                            // final streamedDataProvider =
                            //     Provider.of<StreamedDataProvider>(
                            //         context,
                            //         listen: false);
                            // if (streamedDataProvider
                            //     .loginuserdata.isEmpty) {
                            //   Get.to(const SignInScreen());
                            // } else {
                            //   await ApiRequests().SavePullList(
                            //       streamedDataProvider
                            //           .loginuserdata['sh_id'],
                            //       provider.dataweekly[widget.index]
                            //           ['su_id'],
                            //       "1",
                            //       "0",
                            //       provider.dataweekly[widget.index]
                            //           ['pr_id'],
                            //       context);
                            //
                            //   // print( provider.dataweekly[widget.index]);
                            // }
                          },
                        )
                        : InkWell(
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
                            onTap: () {
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
                          ),
                        SizedBox(height: size.height*0.01,),
                        TextButton(onPressed: (){
                          final streamedDataProvider =
                          Provider.of<StreamedDataProvider>(context,
                              listen: false);
                          final weekly=Provider.of<WeeklyReleaseProvider>(context,listen: false);
                          ApiRequests().deleteWishList(streamedDataProvider.loginuserdata['sh_id'],wishList.userWishListDataList[widget.index]['pr_parentid']);
                          streamedDataProvider.call(wishList.userWishListDataList[widget.index]['pr_id'],wishList.userWishListDataList[widget.index]['in_cart'], wishList.userWishListDataList[widget.index]['sc_qty'],"0");
                          weekly.updateweeklyrelease(wishList.userWishListDataList[widget.index]['pr_id'],wishList.userWishListDataList[widget.index]['in_cart'],wishList.userWishListDataList[widget.index]['sc_qty'],"0");
                        }, child:  Text("Remove",style: TextStyle(color: const Color(0xff006ccf),fontSize: allsize*0.012,fontWeight: FontWeight.bold)))
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
