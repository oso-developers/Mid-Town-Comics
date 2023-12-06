// ignore_for_file: must_be_immutable

import 'package:intl/intl.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';

import '../widget/dialagueBox/weeklyreleasefilter.dart';
import '../widget/dialagueBox/weeklyreleasesortby.dart';
import '../widget/weeklyreleaselistview.dart';

class WeeklyReleasePage extends StatefulWidget {
  const WeeklyReleasePage({super.key});

  @override
  State<WeeklyReleasePage> createState() => _WeeklyReleasePageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _WeeklyReleasePageState extends State<WeeklyReleasePage> {
  int noofsearcheditem = 0;
  TextEditingController searchcontroller = TextEditingController();

  Future<bool> _onWillPop() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

  fetchdateandfilter() async {
    final provider = Provider.of<WeeklyReleaseProvider>(context, listen: false);
    final login = Provider.of<StreamedDataProvider>(context, listen: false);
    ApiRequests().GetProductFilters(context, provider.selecteddate, login.loginuserdata.isEmpty ? "0" : login.loginuserdata['sh_id']);
    ApiRequests().GetWeeklyReleaseData(context, provider.selecteddate, "", "TITLE", 10, false, login.loginuserdata.isEmpty ? "0" : login.loginuserdata['sh_id']);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      fetchdateandfilter();
    });
    // TODO: implement initState
    super.initState();
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
              return SafeArea(
                  child: SingleChildScrollView(
                    child: provider.searchpagein == true
                        ? const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: CircularProgressIndicator()),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SearchList(searchcontroller: searchcontroller),
                              provider.showsearchlist == true
                                  ? provider.returnproduct.isEmpty
                                      ? Container()
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              provider.returnproduct.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  searchcontroller.text =
                                                      provider.returnproduct[
                                                          index]['pr_ttle'];
                                                });
                                                provider.updatesearchselextion(
                                                    provider.returnproduct[
                                                        index]['pr_ttle']);
                                              },
                                              child: Container(
                                                color: index % 2 == 0
                                                    ? const Color(0xffececec)
                                                    : Colors.white,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      allsize * 0.005),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                          fontSize:
                                                              allsize * 0.012,
                                                          color:
                                                              Colors.black),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                "${provider.returnproduct[index]['pr_ttle']}-",
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff818181))),
                                                        TextSpan(
                                                            text: provider
                                                                        .returnproduct[
                                                                    index]
                                                                ['cg_name'],
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff217fda))),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                  : Container(),
                              Consumer<WeeklyReleaseProvider>(
                                  builder: (context, providerweekly, child) {
                                return providerweekly
                                                .weeklyreleaseindicator ==
                                            true &&
                                        providerweekly.loadmore == false
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.04,
                                          ),
                                          const Center(
                                            child:
                                                CircularProgressIndicator(),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    //SORT BY
                                                    InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (BuildContext
                                                                  context) {
                                                            return const WeeklyReleaseSortby();
                                                          },
                                                        );
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "SORT BY",
                                                            style: TextStyle(
                                                                color: const Color(0xff1169bf),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    allsize *
                                                                        0.013),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                size.width *
                                                                    0.01,
                                                          ),
                                                          Icon(
                                                            Icons.sort,
                                                            color: const Color(0xff1169bf),
                                                            size: allsize *
                                                                0.02,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (BuildContext
                                                                  context) {
                                                            return const WeeklyReleaseFilter();
                                                          },
                                                        );
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "FILTERS",
                                                            style: TextStyle(
                                                                color: const Color(0xff1169bf),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    allsize *
                                                                        0.013),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                size.width *
                                                                    0.015,
                                                          ),
                                                          Image.asset(
                                                              'assets/images/icon/filter.PNG',
                                                              height:
                                                                  size.height *
                                                                      0.022)
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
                                            padding: const EdgeInsets.only(
                                                left: 8),
                                            child: Text(
                                              "NOW SHOWING ${providerweekly.total} NEW RELEASE ITEMS",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff868686),
                                                  fontSize: allsize * 0.012),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.012,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    size.width * 0.025),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "WEEKLY RELEASE FOR",
                                                  style: TextStyle(
                                                      fontSize:
                                                          allsize * 0.015,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                              children: providerweekly
                                                                  .dateslist
                                                                  .map<Widget>(
                                                                      (dynamic
                                                                          item) {
                                                                final dateFormat = DateFormat("M/d/yyyy");
                                                                DateTime dateTime = dateFormat.parse(item['comicsdate']);
                                                                DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
                                                                return ListTile(
                                                                  title: Text(
                                                                      "${dateOnly.year}-${dateOnly.month}-${dateOnly.day}"),
                                                                  onTap:
                                                                      () async {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    providerweekly
                                                                        .changeselecteddate(
                                                                            "${dateOnly.year}-${dateOnly.month}-${dateOnly.day}");
                                                                    final datam = Provider.of<
                                                                            FilterProvider>(
                                                                        context,
                                                                        listen:
                                                                            false);
                                                                    await ApiRequests().GetWeeklyReleaseData(
                                                                        context,
                                                                        providerweekly
                                                                            .selecteddate,
                                                                        datam
                                                                            .departmentvalue,
                                                                        providerweekly
                                                                            .sortby,
                                                                        (providerweekly.dataweekly.length)
                                                                            .toString(),
                                                                        false,
                                                                        provider.loginuserdata.isEmpty
                                                                            ? ""
                                                                            : provider.loginuserdata['sh_id']);
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
                                                        size.height * 0.04,
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
                                                          providerweekly
                                                              .selecteddate,
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
                                                horizontal:
                                                    size.width * 0.025),
                                            child: Container(
                                              color: const Color(0xffe4e4e4),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      providerweekly
                                                          .updateindex(1);
                                                      final datam = Provider
                                                          .of<FilterProvider>(
                                                              context,
                                                              listen: false);
                                                      await ApiRequests().GetWeeklyReleaseData(
                                                          context,
                                                          providerweekly
                                                              .selecteddate,
                                                          "77,127,71,105,140,141,74,112,75,110,249",
                                                          providerweekly
                                                              .sortby,
                                                          (providerweekly
                                                                  .dataweekly
                                                                  .length)
                                                              .toString(),
                                                          false,
                                                          provider.loginuserdata
                                                                  .isEmpty
                                                              ? "0"
                                                              : provider
                                                                      .loginuserdata[
                                                                  'sh_id']);
                                                      datam.updatedepartentvalue(
                                                          "77,127,71,105,140,141,74,112,75,110,249");
                                                      datam
                                                          .updatedepartentnamevalue(
                                                              "");
                                                    },
                                                    child: Container(
                                                      height:
                                                          size.height * 0.1,
                                                      width:
                                                          size.width * 0.315,
                                                      color: Color(
                                                          providerweekly
                                                                      .index ==
                                                                  1
                                                              ? (0xff006ccf)
                                                              : 0xffe4e4e4),
                                                      child: Center(
                                                          child: Text(
                                                        "COMICS &\nGRAPHIC\nNOVELS",
                                                        style: TextStyle(
                                                            color: providerweekly
                                                                        .index ==
                                                                    1
                                                                ? Colors.white
                                                                : Colors
                                                                    .black,
                                                            fontSize: allsize * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      providerweekly
                                                          .updateindex(2);
                                                      final datam = Provider
                                                          .of<FilterProvider>(
                                                              context,
                                                              listen: false);
                                                      await ApiRequests().GetWeeklyReleaseData(
                                                          context,
                                                          providerweekly
                                                              .selecteddate,
                                                          "113,78,202,194,173,189",
                                                          providerweekly
                                                              .sortby,
                                                          (providerweekly
                                                                  .dataweekly
                                                                  .length)
                                                              .toString(),
                                                          false,
                                                          provider.loginuserdata
                                                                  .isEmpty
                                                              ? "0"
                                                              : provider
                                                                      .loginuserdata[
                                                                  'sh_id']);
                                                      datam.updatedepartentvalue(
                                                          "113,78,202,194,173,189");
                                                      datam
                                                          .updatedepartentnamevalue(
                                                              "");
                                                    },
                                                    child: Container(
                                                      height:
                                                          size.height * 0.1,
                                                      width:
                                                          size.width * 0.315,
                                                      color: Color(
                                                          providerweekly
                                                                      .index ==
                                                                  2
                                                              ? (0xff006ccf)
                                                              : 0xffe4e4e4),
                                                      child: Center(
                                                          child: Text(
                                                        "INDIES,BOOKS\nMAGAZINES",
                                                        style: TextStyle(
                                                            color: providerweekly
                                                                        .index ==
                                                                    2
                                                                ? Colors.white
                                                                : Colors
                                                                    .black,
                                                            fontSize: allsize * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      providerweekly
                                                          .updateindex(3);
                                                      final datam = Provider
                                                          .of<FilterProvider>(
                                                              context,
                                                              listen: false);
                                                      await ApiRequests().GetWeeklyReleaseData(
                                                          context,
                                                          providerweekly
                                                              .selecteddate,
                                                          "63,65,66,181,176,67",
                                                          providerweekly
                                                              .sortby,
                                                          (providerweekly
                                                                  .dataweekly
                                                                  .length)
                                                              .toString(),
                                                          false,
                                                          provider.loginuserdata
                                                                  .isEmpty
                                                              ? "0"
                                                              : provider
                                                                      .loginuserdata[
                                                                  'sh_id']);
                                                      datam.updatedepartentvalue(
                                                          "63,65,66,181,176,67");
                                                      datam
                                                          .updatedepartentnamevalue(
                                                              "");
                                                    },
                                                    child: Container(
                                                      height:
                                                          size.height * 0.1,
                                                      width:
                                                          size.width * 0.315,
                                                      color: Color(
                                                          providerweekly
                                                                      .index ==
                                                                  3
                                                              ? (0xff006ccf)
                                                              : 0xffe4e4e4),
                                                      child: Center(
                                                          child: Text(
                                                        "MARCHANDIES,\nAPPAREL &\nMORE",
                                                        style: TextStyle(
                                                            color: providerweekly
                                                                        .index ==
                                                                    3
                                                                ? Colors.white
                                                                : Colors
                                                                    .black,
                                                            fontSize: allsize * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          providerweekly.index == 1 ||
                                                  providerweekly.index == 2 ||
                                                  providerweekly.index == 3
                                              ? Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(
                                                          horizontal:
                                                              size.width *
                                                                  0.025),
                                                  child: Container(
                                                    height:allsize*0.045,
                                                    width: double.infinity,
                                                    color: const Color(
                                                        0xff006ccf),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: size.height *
                                                              0.022,
                                                          bottom:
                                                              size.height *
                                                                  0.022,
                                                          left: size.width *
                                                              0.025),
                                                      child: Text(
                                                        providerweekly
                                                                    .index ==
                                                                1
                                                            ? "COMICS & GRAPHIC NOVELS"
                                                            : providerweekly
                                                                        .index ==
                                                                    2
                                                                ? "INDIES,BOOKS,MAGAZINES"
                                                                : "MERCHANDISE,APPAREL & MORE",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontSize:
                                                                allsize *
                                                                    0.013),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    size.width * 0.028),
                                            child: Text(
                                              // "",
                                              Provider.of<FilterProvider>(
                                                              context,
                                                              listen: false)
                                                          .departmentname ==
                                                      ""
                                                  ? ""
                                                  : Provider.of<
                                                              FilterProvider>(
                                                          context,
                                                          listen: false)
                                                      .departmentname,
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff767676),
                                                  fontSize: allsize * 0.015,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    size.width * 0.025),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: providerweekly
                                                    .dataweekly.length,
                                                itemBuilder:
                                                    (context, index) {
                                                  return Column(
                                                    children: [
                                                      WeeklyRelaseListView(
                                                        index: index,
                                                      ),
                                                      SizedBox(
                                                        height: size.height *
                                                            0.01,
                                                      )
                                                    ],
                                                  );
                                                }),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          providerweekly.loadmore == true
                                              ? const Center(
                                                  child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child:
                                                      CircularProgressIndicator(),
                                                ))
                                              :
                                              InkWell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      height:
                                                          size.height * 0.06,
                                                      color: const Color(
                                                          0xff006ccf),
                                                      child: Center(
                                                        child: Text(
                                                          "LOAD MORE",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  allsize *
                                                                      0.013),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    final datam = Provider.of<
                                                            FilterProvider>(
                                                        context,
                                                        listen: false);
                                                    await ApiRequests().GetWeeklyReleaseData(
                                                        context,
                                                        providerweekly
                                                            .selecteddate,
                                                        datam.departmentvalue,
                                                        providerweekly.sortby,
                                                        (providerweekly
                                                                    .dataweekly
                                                                    .length +
                                                                10)
                                                            .toString(),
                                                        true,
                                                        provider.loginuserdata
                                                                .isEmpty
                                                            ? "0"
                                                            : provider
                                                                    .loginuserdata[
                                                                'sh_id']);
                                                    setState(() {
                                                      noofsearcheditem =
                                                          providerweekly
                                                              .dataweekly
                                                              .length;
                                                    });
                                                  },
                                                ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          )
                                        ],
                                      );
                              })
                            ],
                          ),
                  ));
            })),
      ),
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
            fontSize: allsize * 0.011),
      )),
    );
  }
}
