// ignore_for_file: must_be_immutable

import 'package:midtowncomics/widget/searchList.dart';

import '../widget/dialagueBox/filterdialugue.dart';
import '../widget/dialagueBox/sortbydialugue.dart';
import '../widget/searchListViewbuilderWidget.dart';
import 'package:midtowncomics/export.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchcontroller = TextEditingController();
  int noofsearcheditem = 0;
  int index = 1;
  bool change = false;
  bool showdialugue = false;
  String dropdownValue = '1 in Cart';
  List<String> item = [];
  bool data = false;

  Future<bool> _onWillPop() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

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
                  String totalNumber="0";
                  if(provider.returnproduct.isNotEmpty)
                    {
                      totalNumber=provider.returnproduct[0]['totalRecords'];
                    }
                  else
                    {
                      totalNumber="0";
                    }
              return SingleChildScrollView(
                child: provider.searchpagein == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(
                              child: CircularProgressIndicator()),
                        ],
                      )
                    : Column(
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
                                            return const SortByDialaugue();
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
                                                color: const Color(0xff0a5fa9),
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
                                            color: const Color(0xff0a5fa9),
                                            size: allsize * 0.02,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                index = 1;
                                              });
                                            },
                                            child: index == 1
                                                ? Image.asset(
                                                    'assets/images/icon/bluecolumnicon.PNG',
                                                    height: size.height *
                                                        0.022,
                                                  )
                                                : Image.asset(
                                                    'assets/images/icon/blackcolumnicon.PNG',
                                                    height: size.height *
                                                        0.022)),
                                        SizedBox(
                                          width: size.width * 0.05,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                index = 2;
                                              });
                                            },
                                            child: Icon(
                                              Icons.view_column,
                                              color: index == 2
                                                  ? const Color(0xff0a5fa9)
                                                  : Colors.black,
                                              size: allsize * 0.02,
                                            ))
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return const FilterDialaugue();
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
                                                color: const Color(0xff0a5fa9),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: InkWell(
                              onTap: () {
                                debugPrint(provider.searchselection);
                              },
                              child: Text(
                                  "$totalNumber RESULTS for ${provider.searchselection}",
                                  style: TextStyle(
                                      fontSize: allsize * 0.011,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600])),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          index == 1
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      provider.returnproduct.length,
                                  itemBuilder: (context, index) {
                                    return ListViewBuilderWidget(
                                      size: size,
                                      allsize: allsize,
                                      index: index,
                                    );
                                  })
                              : GridView.builder(
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 8.0,
                                          crossAxisSpacing: 8.0,
                                          childAspectRatio: 2 / 5),
                                  padding: const EdgeInsets.all(8.0),
                                  // padding around the grid
                                  itemCount:
                                      provider.returnproduct.length,
                                  // total number of items
                                  itemBuilder: (context, index) {
                                    return GridViewWidget(
                                      size: size,
                                      allsize: allsize,
                                      index: index,
                                    );
                                  },
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          provider.buttonindicator == true
                              ? const Center(
                                  child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ))
                              : noofsearcheditem ==
                                      provider.returnproduct.length
                                  ? Container()
                                  : InkWell(
                                      onTap: () async {
                                        final datam =
                                            Provider.of<FilterProvider>(
                                                context,
                                                listen: false);
                                        final streamedDataProvider =
                                        Provider.of<StreamedDataProvider>(context,
                                            listen: false);
                                        ApiRequests().SearchApi(
                                            streamedDataProvider.loginuserdata['sh_id']??" ",
                                            provider.searchselection,
                                            provider.title == "All"
                                                ? ""
                                                : provider.title,
                                            (provider.returnproduct
                                                        .length +
                                                    10)
                                                .toString(),
                                            provider.selectedValue
                                                .toString(),
                                            datam.showoutofstock == true
                                                ? "1"
                                                : '0',
                                            datam.releaseweaks,
                                            datam.releaseyears,
                                            datam.related,
                                            datam.startdiscounts,
                                            datam.enddiscounts,
                                            datam.manufacturers,
                                            datam.artists,
                                            datam.writers,
                                            datam.startprice,
                                            datam.endprice,
                                            datam.seriesfilter,
                                            true,
                                            datam.newtitle,
                                            context);
                                        noofsearcheditem =
                                            provider.returnproduct.length;
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(3.0),
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
                                    ),
                          SizedBox(
                            height: size.height * 0.01,
                          )
                        ],
                      ),
              );
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
            fontSize: allsize * 0.012),
      )),
    );
  }
}
