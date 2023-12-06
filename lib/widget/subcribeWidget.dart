
import 'package:midtowncomics/export.dart';

class SubcribeWidget extends StatelessWidget {
  const SubcribeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return Container(
      // height:  MediaQuery.of(context).size.shortestSide < 550?size.height * 0.21:size.height*0.23,
      width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius:0.3,
              offset: Offset(2, 2),
            ),
          ],
        ),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                 Text(
                "Get The Latest Scoop!",
                style: TextStyle(
                    color: const Color(0xff006ccf),
                    fontSize: allsize*0.025,
                    fontWeight: FontWeight.w600),
              ),
                  Text(
                "Subscribe To Our NewsLetter For Special Saving And Offers!",
                style: TextStyle(color: Colors.grey[700],fontSize: allsize*0.0115,fontWeight:FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height*0.007,),
              Center(
                child: InkWell(
                  onTap: (){
                    Get.to(const NewsLetterScreen());
                  },
                  child: Container(
                    height: size.height * 0.045,
                    width: size.width * 0.3,
                    decoration: const BoxDecoration(
                      color: Color(0xff006ccf),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(allsize*0.001),
                        child: Text(
                          "SUBSCRIBE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: allsize * 0.015,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                  ,
                ),
              ),
              SizedBox(height: size.height*0.01,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Weekly",style: TextStyle(color: Colors.grey[600],fontSize: allsize*0.0113),),
                  Text('Daily Deals',style: TextStyle(color: Colors.grey[600],fontSize: allsize*0.0113)),
                  Text("Back Issue",style: TextStyle(color: Colors.grey[600],fontSize: allsize*0.0113))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
