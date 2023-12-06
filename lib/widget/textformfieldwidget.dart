// ignore_for_file: must_be_immutable
import 'package:midtowncomics/export.dart';

class TextFormFieldWidget extends StatelessWidget {
  bool optional;
  String title;
  bool readOnly;
  TextEditingController textEditingController;
  TextFormFieldWidget({super.key,required this.title,required this.textEditingController,required this.optional,required this.readOnly});
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
           children: [
             Text(optional==false?"*":"",style:  TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: allsize*0.011),),
             Flexible(child: Text(title,style:  TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: allsize*0.012),)),
           ],
         ),
        TextFormField(
          readOnly:readOnly,
          controller: textEditingController,
          style: TextStyle(fontSize: allsize*0.015,color: Colors.black),
        ),
        SizedBox(height: size.height*0.001,)
      ],
    );
  }
}
