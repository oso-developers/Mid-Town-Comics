import '../export.dart';

class DataNotFound extends StatelessWidget {
  String data;
  DataNotFound({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize = size.height + size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Container(
        height: size.height * 0.13,
        width: double.infinity,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(1, 1),
              ),
            ],
          ),
        child: Container(
          color: Colors.white,
          height: size.height * 0.13,
          width: double.infinity,
          child: Row(
            children: [
              Image.asset('assets/images/confused_spidey.png',width: size.width*0.3,height:size.height * 0.13 ,fit: BoxFit.cover,),
              SizedBox(width:size.width*0.03,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Oops.",style: TextStyle(fontWeight: FontWeight.w900,fontSize: allsize*0.02,fontFamily: 'opensans_semibold'),),
                    Text("We Couldn't find $data\n Product(s)!",style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: allsize*0.012
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
