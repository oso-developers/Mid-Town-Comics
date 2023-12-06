import 'package:midtowncomics/export.dart';

class WeeklyReleaseCard extends StatefulWidget {
  const WeeklyReleaseCard({super.key});

  @override
  State<WeeklyReleaseCard> createState() => _WeeklyReleaseCardState();
}

class _WeeklyReleaseCardState extends State<WeeklyReleaseCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: Center(
                    child: Image.asset("assets/images/dealoftheday.jpg")),
              ),
              SizedBox(
                width: size.width * 0.005,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      height: size.height * 0.028,
                      width: size.width * 0.38,
                      color: const Color(0xff006ccf),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Available for pull list!",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  const Text(
                    "Killer Queens",
                    style: TextStyle(
                        color: Color(0xff7f7f7f),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(height: size.height*0.001,),
                  const Row(children: [
                    Text("By:",style: TextStyle(color: Color(0xff8b8b8b),fontSize: 13),),
                    Text("Dark Horse",style: TextStyle(color: Color(0xff4383bd),fontSize: 13),)
                  ],),
                  const Row(children: [
                    Text("Release Date:",style: TextStyle(color: Color(0xff8b8b8b),fontSize: 13),),
                    Text("09/20/2023",style: TextStyle(color: Color(0xff4383bd),fontSize: 13),)
                  ],),
                  SizedBox(height: size.height*0.005,),
                  const Text("\$3.99",style: TextStyle(color: Color(0xff8b8b8b),fontSize: 13,decoration: TextDecoration.lineThrough)),
                  SizedBox(height: size.height*0.005,),
                    Row(
                      children: [
                    const Text("\$3.99",style: TextStyle(color: Colors.black,fontSize: 13)),
                    SizedBox(width: size.width*0.2,),
                    Container(
                      height: size.height * 0.035,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 3),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          "10% OFF",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],),
                  SizedBox(height: size.height*0.009,),
                  Container(
                    height: size.height * 0.06,
                    width: size.width*0.55,
                    color: const Color(0xff006ccf),
                    child: const Center(
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(height: size.height*0.009,),
                  Container(
                    height: size.height * 0.06,
                    width: size.width*0.55,
                    decoration: BoxDecoration(
                      border: Border.all(color:const Color(0xff006ccf))
                    ),
                    child: const Center(
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(
                              color: Color(0xff006ccf), fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height); // Start from the top-left corner
    path.lineTo(size.width * 0.9, size.height); // Go to the bottom-right corner
    path.lineTo(size.width, 0); // Go to the top-right corner
    path.lineTo(0, 0); // Go back to the top-left corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
