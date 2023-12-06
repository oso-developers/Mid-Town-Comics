import 'package:midtowncomics/export.dart';
class ViewMoreCustomDialugue extends StatelessWidget {
  ViewMoreCustomDialugue({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Dialog(
        child: SizedBox(
      height: size.height * 0.43,
      child: Center(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "View More",
                style: TextStyle(
                    fontSize: allsize * 0.012, fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              title: Text("Comics",
                  style: TextStyle(
                      fontSize: allsize * 0.012, fontWeight: FontWeight.w500)),
            ),
            ListTile(
              title: Text("Graphic Novels",
                  style: TextStyle(
                      fontSize: allsize * 0.012, fontWeight: FontWeight.w500)),
            ),
            ListTile(
              title: Text("Action Figures",
                  style: TextStyle(
                      fontSize: allsize * 0.012, fontWeight: FontWeight.w500)),
            ),
            ListTile(
              title: Text("Statues",
                  style: TextStyle(
                      fontSize: allsize * 0.012, fontWeight: FontWeight.w500)),
            ),
            ListTile(
              title: Text("Collectibles",
                  style: TextStyle(
                      fontSize: allsize * 0.012, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    ));
  }
}
