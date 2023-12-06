// ignore_for_file: must_be_immutable

import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/previewOrderProvider.dart';
import 'package:midtowncomics/widget/dataNotFound.dart';
import 'package:midtowncomics/widget/dialagueBox/previewFilterDialaugue.dart';
import 'package:midtowncomics/widget/dialagueBox/previewSortBy.dart';
import 'package:midtowncomics/widget/preViewListView.dart';

import '../widget/searchList.dart';

class PreOrderScreen extends StatefulWidget {
  const PreOrderScreen({super.key});

  @override
  State<PreOrderScreen> createState() => _PreOrderScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _PreOrderScreenState extends State<PreOrderScreen> {
  int index = 1;
  TextEditingController searchcontroller = TextEditingController();

  getPreviewFilter()async{
    final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
    final preProvider=Provider.of<PreviewOrderProvider>(context,listen: false);
    ApiRequests().previewFilter(streamedDataProvider.loginuserdata['sh_id'], preProvider.previewCodeValue);
  }
  
  getPreViewList()async{
    final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
    final preProvider=Provider.of<PreviewOrderProvider>(context,listen: false);
    ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],"cg",preProvider.previewCodeValue,"","tit","1","10",false);
  }

  @override
  void initState() {
    getPreViewList();
    getPreviewFilter();
    // TODO: implement initState
    super.initState();
  }

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
              searchcontroller:searchcontroller,
            ),),
          key: scaffoldKey,
          drawer: const Custom_drawer(),
          backgroundColor: const Color(0xfff6f6f6),
          body: Consumer<StreamedDataProvider>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  child:  Consumer<PreviewOrderProvider>(
                    builder: (context, provider, child) {
                  String totalNumber = "";
                  if (provider.previewData['DATA'] != null) {
                totalNumber =
                provider.previewData['DATA']['totalCount']['gTotal'];
                  } else {
                totalNumber = "";
                  }

                  return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchList(searchcontroller: searchcontroller),
                  SizedBox(
                height: size.height * 0.01,
                  ),
                  Container(
                height: size.height * 0.06,
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
                              height: size.height * 0.06,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    //SORT BY
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return const PreviewSortBy();
                                          },
                                        );
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "SORT BY",
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize:
                                                allsize * 0.013),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Icon(
                                            Icons.sort,
                                            color: Colors.blueAccent,
                                            size: allsize * 0.02,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return const PreviewFilter();
                                          },
                                        );
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "FILTERS",
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize:
                                                allsize * 0.013),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.015,
                                          ),
                                          Image.asset(
                                              'assets/images/icon/filter.PNG',
                                              height: size.height * 0.022)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "NOW SHOWING $totalNumber NEW RELEASE ITEMS",
                  style: TextStyle(
                      color: const Color(0xff868686),
                      fontSize: allsize * 0.012),
                ),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.025),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "PREVIEWS FOR",
                                  style: TextStyle(
                                      fontSize: allsize * 0.015,
                                      fontFamily: 'oswald_semi_bold',
                                      fontWeight: FontWeight.bold),
                                ),
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
                                              children:provider.previewCodeList
                                                  .map<Widget>(
                                                      (dynamic
                                                  item) {
                                                    return ListTile(
                                                      title: Text(FunctionClass().convertToFullMonth(item['pre_code'])),
                                                      onTap:
                                                          () async {
                                                        final streamedDataProvider =
                                            Provider.of<
                                                    StreamedDataProvider>(
                                                context,
                                                listen: false);
                                        Navigator.of(context).pop();
                                        provider.updatePreviewCodeComplete(
                                            FunctionClass()
                                                .convertToFullMonth(
                                                    item[
                                                        'pre_code']));
                                        provider
                                            .updatePreviewCodeValue(
                                                item['pre_code']);
                                        await ApiRequests()
                                            .previewFilter(
                                                streamedDataProvider
                                                        .loginuserdata[
                                                    'sh_id'],
                                                provider
                                                    .previewCodeValue);
                                        ApiRequests().getPreviewItem(
                                            streamedDataProvider
                                                    .loginuserdata[
                                                'sh_id'],
                                            provider.filterData,
                                            provider.previewCodeValue,
                                            provider.searchValue,
                                            provider.sortByGroupValue,
                                            "1",
                                            "10",
                                            false);
                                        print(provider
                                            .previewFilterList);
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
                                    height:
                                    size.height * 0.043,
                                    width: size.width * 0.4,
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
                                          provider.previewCodeComplete,
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
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.025),
                            child: Container(
                              color: const Color(0xffe4e4e4),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        index=1;
                                      });
                                      final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                      ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],"cg",provider.previewCodeValue,provider.searchValue,provider.sortByGroupValue,"1",provider.previewDataList.length,false);
                                      provider.updateFilterData("cg");
                                      provider.updateFilterName("");
                                    },
                                    child: Container(
                                      height: size.height * 0.1,
                                      width: size.width * 0.234,
                                      color: Color(index == 1
                                          ? (0xff006ccf)
                                          : 0xffe4e4e4),
                                      child: Center(
                                          child: Text(
                                            "COMICS &\nGRAPHIC\nNOVELS",
                                            style: TextStyle(
                                                color: index == 1
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: allsize * 0.012,
                                              fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        index=2;
                                      });
                                      final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                      ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],"ib",provider.previewCodeValue,provider.searchValue,provider.sortByGroupValue,"1",provider.previewDataList.length,false);
                                      provider.updateFilterName("");
                                      provider.updateFilterData("ib");
                                    },
                                    child: Container(
                                      height: size.height * 0.1,
                                      width: size.width * 0.234,
                                      color: Color(index == 2
                                          ? (0xff006ccf)
                                          : 0xffe4e4e4),
                                      child: Center(
                                          child: Text(
                                            "INDIES,\nBOOKS\nMAGAZINES",
                                            style: TextStyle(
                                                color: index == 2
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: allsize * 0.012,
                                                fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        index=3;
                                      });
                                      final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                      ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],"at",provider.previewCodeValue,provider.searchValue,provider.sortByGroupValue,"1",provider.previewDataList.length,false);
                                      provider.updateFilterName("");
                                      provider.updateFilterData("at");
                                    },
                                    child: Container(
                                      height: size.height * 0.1,
                                      width: size.width * 0.234,
                                      color: Color(index == 3
                                          ? (0xff006ccf)
                                          : 0xffe4e4e4),
                                      child: Center(
                                          child: Text(
                                            "APPAREL",
                                            style: TextStyle(
                                                color: index == 3
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: allsize * 0.012,
                                                fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        index=4;
                                      });
                                      final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                      ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],"mm",provider.previewCodeValue,provider.searchValue,provider.sortByGroupValue,"1",provider.previewDataList.length,false);
                                      provider.updateFilterName("");
                                      provider.updateFilterData("mm");
                                    },
                                    child: Container(
                                      height: size.height * 0.1,
                                      width: size.width * 0.234,
                                      color: Color(index == 4
                                          ? (0xff006ccf)
                                          : 0xffe4e4e4),
                                      child: Center(
                                          child: Text(
                                            "MERCHANDISE & MORE",
                                            style: TextStyle(
                                                color: index == 4
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: allsize * 0.012,
                                                fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: size.height*0.01,),
                          Padding(padding: EdgeInsets.symmetric(horizontal: size.width*0.025),
                            child: Container(
                              height: size.height*0.07,
                              width: double.infinity,
                              color: const Color(0xff006ccf),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: size.height*0.022,
                                    bottom: size.height*0.022,
                                    left: size.width*0.025
                                ),
                                child: Text(index==1?"COMICS & GRAPHIC NOVELS":index==2?"INDIES,BOOKS,MAGAZINES":"MERCHANDISE,APPAREL & MORE",style:TextStyle(
                                    color: Colors.white,fontSize: allsize*0.015
                                ),),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height*0.01,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width*0.028),
                            child: Text(provider.filterName,style: TextStyle(color: const Color(0xff767676),fontSize: allsize*0.015,fontWeight: FontWeight.w500),),
                          ),
                          SizedBox(height: size.height*0.01,),
                          provider.changeindicator==false?
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.previewDataList.length,
                              itemBuilder: (context,index) {
                                return PreViewListView(index: index);
                              }
                          )
                              :const Center(child: CircularProgressIndicator(),),
                          SizedBox(height: size.height*0.01,),
                          provider.loadmore == true
                  ? const Center(
                      child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ))
                  : provider.previewData['DESCRIPTION'] ==
                          "data not found"
                      ? DataNotFound(
                          data: 'Pre Order List',
                        )
                      : InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: size.height * 0.06,
                              color: const Color(0xff006ccf),
                              child: Center(
                                child: Text(
                                  "LOAD MORE",
                                  style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                        allsize * 0.013),
                                  ),
                                ),
                              ),
                            ),
                            onTap: (){
                              final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                              ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],provider.filterData,provider.previewCodeValue,provider.searchValue,provider.sortByGroupValue,"1",provider.previewDataList.length+10,true);
                            },
                          ),
                          SizedBox(height: size.height*0.01,)
                        ],
                      );
                    })
                );
              })),
    );
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
