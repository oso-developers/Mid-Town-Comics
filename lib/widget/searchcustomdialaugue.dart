
import 'package:midtowncomics/export.dart';

class SearchDialugue extends StatelessWidget {
  const SearchDialugue({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return SizedBox(
      width: size.width*0.3,
      child: Dialog(
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
          child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title:  Text(
                  "All",
                  style: TextStyle(fontSize: allsize*0.011),
                ),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("All");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text("Comics",  style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Comics");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text("Back Issue",  style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Back Issues");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Graphic Novels",  style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Graphic Novels");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Books" , style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Books");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Magazines",style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Magazines");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Manga",style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Manga");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text("T-Shirt & Apparel",style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("T-Shirt & Apparel");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Statues",style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Statues");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text("Action Figure",style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Action Figure");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Collectible",  style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("All Comics");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Collectible",style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Gaming & Cards");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:  Text("DvD's",  style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("DvD's");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Supplies",  style: TextStyle(fontSize: allsize*0.011),),
                onTap: () {
                  Provider.of<StreamedDataProvider>(context, listen: false)
                      .changetitle("Supplies");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      )),
    );
  }
}
