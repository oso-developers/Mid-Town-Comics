
import 'package:flutter/cupertino.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/previewOrderProvider.dart';

class PreviewSortBy extends StatefulWidget {
  const PreviewSortBy({super.key,});

  @override
  State<PreviewSortBy> createState() => _PreviewSortByState();
}

class _PreviewSortByState extends State<PreviewSortBy> {
  int selectedValue = 0;

  Map<String, String> radioButtonData = {
    "tit": 'Title',
    "lp": 'Lowest Price',
    "hp": 'Highest Price'
  };



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<PreviewOrderProvider>(builder: (context, provider, child) {
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
                  groupValue: provider.sortByGroupValue,
                  onChanged: (value) async{
                    final login=Provider.of<StreamedDataProvider>(context,listen: false);
                    provider.updateSortByGroupValue(value!);
                    final streamedDataProvider = Provider.of<StreamedDataProvider>(context, listen: false);
                    ApiRequests().getPreviewItem(streamedDataProvider.loginuserdata['sh_id'],provider.filterData,provider.previewCodeValue,provider.searchValue,provider.sortByGroupValue,"1",provider.previewDataList.length,false);
                    Navigator.pop(context);
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
