// ignore_for_file: must_be_immutable
import 'package:midtowncomics/export.dart';

class MyProfileRow extends StatelessWidget {
  String title,value;
  MyProfileRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10),
      child: Row(
        children: [
          SizedBox(
            width: size.width*0.3,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: allsize*0.012),
            ),
          ),
          Text(value,style: TextStyle(color: Colors.grey,fontSize: allsize*0.012),)
        ],
      ),
    );
  }
}
