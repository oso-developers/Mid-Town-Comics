import 'package:midtowncomics/export.dart';
class DealOfTheDayText extends StatelessWidget {
  const DealOfTheDayText({
    super.key,
    required this.size,
    required this.allsize,
  });

  final Size size;
  final double allsize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height*0.08,
          width: size.width*0.14,
          decoration: const BoxDecoration(
              color: Color(0xff028701)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("OCT",style: TextStyle(color: Colors.white,fontSize: allsize*0.014,fontWeight: FontWeight.w600),),
              Text("25",style: TextStyle(color: Colors.white,fontSize: allsize*0.014,fontWeight: FontWeight.w600))
            ],),
        ),
        SizedBox(width: size.width*0.01,),
        Text(
          "DEAL",style: TextStyle(
            color: const Color(0xff028701),
            fontSize: allsize*0.032
        ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("OF",style: TextStyle(color: const Color(0xff028701),fontSize: allsize*0.014,fontWeight: FontWeight.w400),),
            Text("THE",style: TextStyle(color: const Color(0xff028701),fontSize: allsize*0.014,fontWeight: FontWeight.w400))
          ],),
        Text(
          "DAY",style: TextStyle(
            color: const Color(0xff028701),
            fontSize: allsize*0.032
        ),
        )
      ],
    );
  }
}