// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:midtowncomics/export.dart';
class BackIssueListWidget extends StatefulWidget {
  // String title;

  const BackIssueListWidget(
      {super.key,
       });

  @override
  State<BackIssueListWidget> createState() => _BackIssueListWidgetState();
}

class _BackIssueListWidgetState extends State<BackIssueListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Consumer<StreamedDataProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          SizedBox(
            width: size.width * 0.445,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: size.height*0.28,
                    child: Image.network(
                           "https://www.midtowncomics.com/images/PRODUCT/FUL/1678020_ful.jpg",
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      fit: BoxFit.contain,
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                SizedBox(
                  height: size.height*0.05,
                  child: Text(
                         "A Force Vol 2",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: allsize * 0.013),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  height: size.height*0.06,
                  color: const Color(0xff008800),
                  child: Center(child: Text("VIEW ALL",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: allsize*0.014),),),
                )
              ],
            ),
          ),
        ],
      );
    });
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

class ButtonWidget extends StatefulWidget {
  String preorder, quan;

  ButtonWidget({super.key, required this.quan, required this.preorder});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    int quantity = int.parse(widget.quan);
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Container(
      height: size.height * 0.06,
      color: (widget.preorder == "1")
          ? const Color(0xff9048c4)
          : (quantity == 0 || quantity < 0)
          ? Colors.red
          : const Color(0xff006ccf),
      child: Center(
          child: Text(
            widget.preorder == "1"
                ? "PRE-ORDER"
                : (quantity == 0 || quantity < 0)
                ? "ADD TO WISH LIST"
                : "ADD TO CART",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: allsize * 0.012),
          )),
    );
  }
}
