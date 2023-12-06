
import 'package:flutter/cupertino.dart';
import 'package:midtowncomics/export.dart';

class WeeklyReleaseSortby extends StatefulWidget {
  const WeeklyReleaseSortby({super.key,});

  @override
  State<WeeklyReleaseSortby> createState() => _WeeklyReleaseSortbyState();
}

class _WeeklyReleaseSortbyState extends State<WeeklyReleaseSortby> {
  int selectedValue = 0;

  Map<String, String> radioButtonData = {
    "TITLE": 'Title',
    "lowp": 'Lowest Price',
    "hp": 'Highest Price'
  };



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<WeeklyReleaseProvider>(builder: (context, provider, child) {
      List<Widget> createRadioList() {
        List<Widget> widgets = [];
        radioButtonData.forEach((key, value) {
          widgets.add(Row(
            children: [
              Transform.scale(
                scale:
                allsize * 0.0007,
                child: Radio(
                  activeColor: const Color(0xff006ccf),
                  value: key,
                  groupValue: provider.sortby,
                  onChanged: (value) async{
                    final login=Provider.of<StreamedDataProvider>(context,listen: false);
                    provider.updatesortby(value!);
                    Navigator.pop(context);
                    await ApiRequests().GetWeeklyReleaseData(context,provider.selecteddate,"",value,(provider.dataweekly.length).toString(),false,login.loginuserdata.isEmpty ? "0" :login.loginuserdata['sh_id']);
                  },
                ),
              ),
              Text(value,style: TextStyle(fontSize: allsize*0.012),),
            ],
          ));
        });
        return widgets;
      }
      return  Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: allsize * 0.012, vertical: allsize * 0.01),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
          child:
          Consumer<StreamedDataProvider>(builder: (context, provider, child) {
            return Column(
              children: [
                Container(
                  height: size.height*0.06,
                  color: const Color(0xff006ccf),
                  width: double.infinity,
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal:size.width*0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sort By",style: TextStyle(color: Colors.white,fontSize: allsize*0.015,fontWeight: FontWeight.bold),),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:  Icon(CupertinoIcons.clear,color: Colors.white,size: allsize*0.02,))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.02),
                Column(
                    children:createRadioList()
                )
              ],
            );
          }));
    }
    );

  }
}
