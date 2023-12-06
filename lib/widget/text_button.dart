// ignore_for_file: must_be_immutable

import 'package:midtowncomics/export.dart';
class TextButtonWidget extends StatelessWidget {
  Function() ontap;
  String title;
   TextButtonWidget({super.key,required this.ontap,required this.title});

  @override
  Widget build(BuildContext context) {
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return InkWell(
        onTap:ontap,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: allsize*0.0115,
            // fontFamily: 'opensans_semibold',
            fontWeight: FontWeight.w200
          ),
        ));
  }
}
