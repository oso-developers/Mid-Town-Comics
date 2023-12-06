import 'package:flutter/cupertino.dart';
import 'package:midtowncomics/export.dart';

class WeeklyReleaseFilter extends StatefulWidget {
  const WeeklyReleaseFilter({Key? key}) : super(key: key);

  @override
  State<WeeklyReleaseFilter> createState() => _WeeklyReleaseFilterState();
}

class _WeeklyReleaseFilterState extends State<WeeklyReleaseFilter> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<WeeklyReleaseProvider>(
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
                                print(provider.filterlist);
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
                    if (provider.filterlist.isNotEmpty)
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
                    if (provider.filterlist.isNotEmpty)
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.filterlist.length,
                        itemBuilder: (context, index) {
                          return  Row(
                            children: [
                              Checkbox(
                                // fillColor: MaterialStateProperty.all<Color>(
                                //     const Color(0xff006ccf)),
                                activeColor:const Color(0xff006ccf),
                                value: datam.departmentvalue ==
                                    provider.filterlist[index]['cg_id'],
                                onChanged: (bool? value) async {
                                  if (value != null && value) {
                                    if( provider.filterlist[index]['cg_counts']=="0")
                                      {
                                       Navigator.pop(context);
                                      }
                                    else{
                                      final login=Provider.of<StreamedDataProvider>(context,listen: false);
                                      datam.updatedepartentvalue(provider.filterlist[index]['cg_id']);
                                      datam.updatedepartentnamevalue(provider.filterlist[index]['cg_name']);
                                      provider.updateindex(0);
                                      Navigator.pop(context);
                                      await ApiRequests().GetWeeklyReleaseData(
                                          context,
                                          provider.selecteddate,
                                          datam.departmentvalue,
                                          provider.sortby,
                                          provider.dataweekly.length.toString(),false,login.loginuserdata.isEmpty ? "0" :login.loginuserdata['sh_id']);
                                    }
                                  }
                                },
                              ),
                              Text(
                                provider.filterlist[index]['cg_name'] +
                                    "(" +
                                    provider.filterlist[index]['cg_counts'] +
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
