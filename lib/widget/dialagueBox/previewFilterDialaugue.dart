import 'package:flutter/cupertino.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/previewOrderProvider.dart';

class PreviewFilter extends StatefulWidget {
  const PreviewFilter({Key? key}) : super(key: key);

  @override
  State<PreviewFilter> createState() => _PreviewFilterState();
}

class _PreviewFilterState extends State<PreviewFilter> {
  TextEditingController searchData=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<PreviewOrderProvider>(
      builder: (context, provider, child) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: allsize * 0.012, vertical: allsize * 0.01),
          child: SingleChildScrollView(
            child: Consumer<FilterProvider>(
              builder: (context, datam, child) {
                return Column(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      color: const Color(0xff006ccf),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                print(provider.previewFilterList);
                              },
                              child: Text(
                                "Filters",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: allsize * 0.015,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                CupertinoIcons.clear,
                                color: Colors.white,
                                size: allsize * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.05,
                      color: const Color(0xffececec),
                      child: Center(
                        child: Text(
                          "Search",
                          style: TextStyle(
                              color: const Color(0xff818181),
                              fontWeight: FontWeight.bold,
                              fontSize: allsize * 0.016),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.01,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:size.width*0.01),
                          child: Row(children: [
                      SizedBox(
                          width: size.width*0.7,
                          child: TextFormField(
                            controller: searchData,
                          ),
                      ),
                            TextButton(onPressed: (){
                              provider.updateSearchValue(searchData.text);
                              print(provider.searchValue);
                              final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                              ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],provider.filterData,provider.previewCodeValue,provider.searchValue,provider.sortByGroupValue,"1",provider.previewDataList.length,false);
                              Navigator.pop(context);
                            }, child: const Text("SEARCH",style: TextStyle(fontWeight: FontWeight.bold),))
                    ],),
                        ),
                    SizedBox(height: size.height*0.01,),
                    if (provider.previewFilterList.isNotEmpty)
                      Container(
                        height: size.height * 0.05,
                        color: const Color(0xffececec),
                        child: Center(
                          child: Text(
                            "Departments",
                            style: TextStyle(
                                color: const Color(0xff818181),
                                fontWeight: FontWeight.bold,
                                fontSize: allsize * 0.016),
                          ),
                        ),
                      ),
                    if (provider.previewFilterList.isNotEmpty)
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.previewFilterList.length,
                        itemBuilder: (context, index) {
                          return  Row(
                            children: [
                              Checkbox(
                                activeColor: const Color(0xff006ccf),
                                value: index == provider.selectedIndexChanged,
                                onChanged: (bool? value) async {
                                  if (value != null && value) {
                                    // Unselect the previously selected item
                                    if (provider.selectedIndexChanged != -1) {
                                      provider.updateSelectedIndex(provider.selectedIndexChanged);
                                      // provider.updateSelectedState(selectedIndexChanged, false);
                                    }

                                    if (provider.previewFilterList[index]['cg_counts'] == "") {
                                      Navigator.pop(context);
                                    } else {
                                      final login = Provider.of<StreamedDataProvider>(
                                        context,
                                        listen: false,
                                      );
                                      provider.updateFilterData(
                                        provider.previewFilterList[index]['cat_name'],
                                      );
                                      final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                                      ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],provider.filterData,provider.previewCodeValue,provider.searchValue,provider.sortByGroupValue,"1",provider.previewDataList.length,false);
                                      // Update the selected index
                                      provider.updateSelectedIndex(index);
                                      Navigator.pop(context);
                                      // provider.updateSelectedState(index, true);
                                    }
                                  }
                                },
                              ),
                              Text(
                                provider.previewFilterList[index]['cat_name'] +
                                    "(" +
                                    provider.previewFilterList[index]['totalcount'] +
                                    ")",
                                style: TextStyle(fontSize: allsize * 0.012),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
