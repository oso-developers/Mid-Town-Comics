
import 'package:flutter/cupertino.dart';
import 'package:midtowncomics/export.dart';

class SortByDialaugue extends StatefulWidget {
  const SortByDialaugue({super.key,});

  @override
  State<SortByDialaugue> createState() => _SortByDialaugueState();
}

class _SortByDialaugueState extends State<SortByDialaugue> {
  int selectedValue = 0;

  Map<int, String> radioButtonData = {
    0: 'New Releases',
    1: 'Title',
    2: 'Lowest Price',
    3: 'Highest Price'
  };

 

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<StreamedDataProvider>(builder: (context, provider, child) {
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
                  groupValue: provider.selectedValue,
                  onChanged: (value) async{
                    final provider= Provider.of<StreamedDataProvider>(context,listen: false);
                    final datam=Provider.of<FilterProvider>(context,listen: false);
                   provider.sorby(value as int );
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
