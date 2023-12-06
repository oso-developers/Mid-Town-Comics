import 'package:flutter/cupertino.dart';
import 'package:midtowncomics/export.dart';

class FilterDialaugue extends StatefulWidget {
  const FilterDialaugue({
    super.key,
  });

  @override
  State<FilterDialaugue> createState() => _FilterDialaugueState();
}

class _FilterDialaugueState extends State<FilterDialaugue> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<StreamedDataProvider>(builder: (context, provider, child) {
      return Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: allsize * 0.012, vertical: allsize * 0.01),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Consumer<StreamedDataProvider>(
              builder: (context,value, child) {
            return SingleChildScrollView(child: Consumer<FilterProvider>(
                builder: (context,datam, child) {
              return Column(
                children: [
                  Container(
                    height: size.height * 0.06,
                    color: const Color(0xff006ccf),
                    width: double.infinity,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filters",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: allsize * 0.015,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child:  Icon(
                                CupertinoIcons.clear,
                                color: Colors.white,
                                size: allsize*0.02,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale:
                              allsize * 0.0007,
                              child: Checkbox(
                                  // fillColor:
                                  //     const MaterialStatePropertyAll<Color>(
                                  //         Color(0xff006ccf)),
                                  activeColor: Colors.white,
                                  value: datam.showoutofstock,
                                  onChanged: (value) async {
                                    datam.showoutof(value!);
                                    // setState(() {
                                    //   showoutofstock = value!;
                                    // });
                                    if (value == true) {
                                      Navigator.pop(context);
                                      ApiRequests().SearchApi(
                                          provider.loginuserdata['sh_id']??"",
                                          provider.searchselection,
                                          provider.title == "All"
                                              ? ""
                                              : provider.title,
                                          (provider.returnproduct.length)
                                              .toString(),
                                          provider.selectedValue.toString(),
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
                                          false,
                                          datam.newtitle,
                                          context);
                                    }
                                    else{
                                      Navigator.pop(context);
                                      ApiRequests().SearchApi(
                                          provider.loginuserdata['sh_id']??"",
                                          provider.searchselection,
                                          provider.title == "All"
                                              ? ""
                                              : provider.title,
                                          (provider.returnproduct.length)
                                              .toString(),
                                          provider.selectedValue.toString(),
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
                                          false,
                                          datam.newtitle,
                                          context);
                                    }
                                  }),
                            ),
                            Text("Show Out of Stock",style: TextStyle(fontSize: allsize*0.012))
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale:
                              allsize * 0.0007,
                              child: Checkbox(
                                  // fillColor:
                                  //     const MaterialStatePropertyAll<Color>(
                                  //         Color(0xff006ccf)),
                                  activeColor: Colors.white,
                                  value:datam.showpreorder,
                                  onChanged: (value) {
                                    datam.showppre(value!);
                                    Navigator.pop(context);
                                    // setState(() {
                                    //   showpreorder = value!;
                                    // });
                                  }),
                            ),
                             Text("Show Pre-Orders",style: TextStyle(fontSize: allsize*0.012))
                          ],
                        )
                      ],
                    ),
                  ),
                  //Release Weak
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.weeklyRekease.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Release Weak",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  // initialize to a value that doesn't correspond to any index
                  provider.weeklyRekease.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.weeklyRekease.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.releaseweak == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updatereleaseweak(index);
                                  // releaseweak = index;
                                  datam.updatereleasewealvalue(provider.weeklyRekease[index]
                                  ['weekName']);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                } else {
                                  datam.updatereleaseweak(-1);
                                  datam.updatereleasewealvalue("");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Text(provider.weeklyRekease[index]['weekName'],style: TextStyle(fontSize: allsize*0.012)),
                        ],
                      );
                    },
                  ),
                  //Release Year
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.releaseyear.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Release Year",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.releaseyear.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.releaseyear.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.releaseyear == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updatereleaseyear(index);
                                  // releaseyear = index;
                                  datam.updatereleaseyearvalue(provider.releaseyear[index]
                                  ['yearValue']);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                } else {
                                  datam.updatereleaseyear(-1);
                                  datam.updatereleaseyearvalue("");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Text(provider.releaseyear[index]['yearName'],style: TextStyle(fontSize: allsize*0.012)),
                        ],
                      );
                    },
                  ),
                  //Series Title lIst
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.series.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Series",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.series.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.series.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.series == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updateseries(index);
                                  datam.updatenewtitle(provider.series[index]['seriesTitleName']);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                  // series = index;
                                } else {
                                  datam.updateseries(-1);
                                  datam.updatenewtitle("");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child: Text(
                                  provider.series[index]['seriesTitleName'],style: TextStyle(fontSize: allsize*0.012))),
                        ],
                      );
                    },
                  ),
                  //Related Title
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.relatedtitle.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Related Title",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.relatedtitle.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.relatedtitle.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.relatedtitle == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updaterelatedtitle(index);
                                  // relatedtitle = index;
                                  datam.updaterelatedtitlevale(provider.relatedtitle[index]
                                  ['relatedTitleValue']);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                } else {
                                  datam.updaterelatedtitle(-1);
                                  datam.updaterelatedtitlevale(" ");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child: Text(provider.relatedtitle[index]
                                  ['relatedTitleName'],style: TextStyle(fontSize: allsize*0.012))),
                        ],
                      );
                    },
                  ),
                  //Catagory
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.catagory.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Category",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.catagory.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.catagory.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.category == index,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value != null && value) {
                                    datam.updatecategory(index);
                                    // category = index;
                                    provider.changetitle(
                                        provider.catagory[index]['cgName']);
                                    Navigator.pop(context);
                                    ApiRequests().SearchApi(
                                        provider.loginuserdata['sh_id']??"",
                                        provider.searchselection,
                                        provider.title == "All"
                                            ? ""
                                            : provider.title,
                                        (provider.returnproduct.length)
                                            .toString(),
                                        provider.selectedValue.toString(),
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
                                        false,
                                        datam.newtitle,
                                        context);
                                    debugPrint("Check");
                                  } else {
                                    datam.updatecategory(-1);
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            ),
                          ),
                          Flexible(
                              child: Text(provider.catagory[index]['cgName'],style: TextStyle(fontSize: allsize*0.012))),
                        ],
                      );
                    },
                  ),
                  //Discount
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.discount.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Discount",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.discount.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.discount.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.Discount == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updatediscount(index);
                                  datam.updatestartdiscountvalue(provider.discount[index]['discountStartValue']);
                                  datam.updateenddiscountvalue(provider.discount[index]['discountEndValue']);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                  // Discount = index;
                                } else {
                                  datam.updatediscount(-1);
                                  datam.updatestartdiscountvalue("");
                                  datam.updateenddiscountvalue("");
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child: Text(
                                  provider.discount[index]['discountName'],style: TextStyle(fontSize: allsize*0.012))),
                        ],
                      );
                    },
                  ),
                  //Manufacturer
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.manufacturer.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Manufacturer",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.manufacturer.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.manufacturer.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.manufacturer == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updatemanufacturer(index);
                                  datam. updatmanufacturervalue(provider.manufacturer[index]
                                  ['manufacturerName']);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                } else {
                                  datam.updatemanufacturer(-1);
                                  datam. updatmanufacturervalue("");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child: Text(provider.manufacturer[index]
                                  ['manufacturerName'],style: TextStyle(fontSize: allsize*0.012))),
                        ],
                      );
                    },
                  ),
                  //Artist
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.artistf.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Artist",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.artistf.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.artistf.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.artist == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                 datam.updateartist(index);
                                 datam.updateartistvalue(provider.artistf[index]['artistName']);
                                 Navigator.pop(context);
                                 ApiRequests().SearchApi(
                                     provider.loginuserdata['sh_id']??"",
                                     provider.searchselection,
                                     provider.title == "All"
                                         ? ""
                                         : provider.title,
                                     (provider.returnproduct.length)
                                         .toString(),
                                     provider.selectedValue.toString(),
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
                                     false,
                                     datam.newtitle,
                                     context);
                                } else {
                                  datam.updateartist(-1);
                                  datam.updateartistvalue("");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child:
                                  Text(provider.artistf[index]['artistName'],style: TextStyle(fontSize: allsize*0.012))),
                        ],
                      );
                    },
                  ),
                  //Writer
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.writerf.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Writer",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.writerf.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.writerf.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.writer == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updateartistvalue(provider.writerf[index]['writerName']);
                                  datam.updatewriter(index);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                } else {
                                  datam.updatewriter(-1);
                                  datam.updateartistvalue("");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child:
                                  Text(provider.writerf[index]['writerName'],style: TextStyle(fontSize: allsize*0.012))),
                        ],
                      );
                    },
                  ),
                  //Price
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.price.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Price",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.price.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.price.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.price == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updateprice(index);
                                  datam.updatestartpricevalue(provider.price[index]['priceStart']);
                                  datam.updateendpricevalue(provider.price[index]['priceEnd']);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                } else {
                                  datam.updateprice(-1);
                                  datam.updatestartpricevalue("");
                                  datam.updateendpricevalue("");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child: Text(provider.price[index]['priceName'],style: TextStyle(fontSize: allsize*0.012))),
                        ],
                      );
                    },
                  ),
                  //Issue No
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  provider.Issueno.isEmpty?Container():
                  Container(
                    height: size.height * 0.05,
                    color: const Color(0xffececec),
                    child: Center(
                      child: Text(
                        "Issue No",
                        style: TextStyle(
                            color: const Color(0xff818181),
                            fontWeight: FontWeight.bold,
                            fontSize: allsize * 0.016),
                      ),
                    ),
                  ),
                  provider.Issueno.isEmpty?Container():
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.25,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.Issueno.length,
                    itemBuilder: (context, index) {
                      debugPrint(provider.weeklyRekease.length.toString());
                      return Row(
                        children: [
                          Transform.scale(
                            scale:
                            allsize * 0.0007,
                            child: Checkbox(
                              // fillColor: MaterialStateProperty.all<Color>(
                              //     const Color(0xff006ccf)),
                              activeColor: Colors.white,
                              value: datam.issueno == index,
                              onChanged: (bool? value) {
                                if (value != null && value) {
                                  datam.updateissue(index);
                                  datam.updateseriesvalue(provider.Issueno[index]['seriesValue']);
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                } else {
                                  datam.updateissue(-1);
                                  datam.updateseriesvalue("");
                                  Navigator.pop(context);
                                  ApiRequests().SearchApi(
                                      provider.loginuserdata['sh_id']??"",
                                      provider.searchselection,
                                      provider.title == "All"
                                          ? ""
                                          : provider.title,
                                      (provider.returnproduct.length)
                                          .toString(),
                                      provider.selectedValue.toString(),
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
                                      false,
                                      datam.newtitle,
                                      context);
                                }
                              },
                            ),
                          ),
                          Flexible(
                              child:
                                  Text(provider.Issueno[index]['seriesName'],style: TextStyle(fontSize: allsize*0.012),)),
                        ],
                      );
                    },
                  ),
                ],
              );
            }));
          }));
    });
  }
}
