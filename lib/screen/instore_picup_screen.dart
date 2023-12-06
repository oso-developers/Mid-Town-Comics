
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/instorePickUpProvider.dart';
import 'package:midtowncomics/widget/searchList.dart';

class InStorePickupScreen extends StatefulWidget {
  const InStorePickupScreen({super.key});

  @override
  State<InStorePickupScreen> createState() => _InStorePickupScreenState();
}

class _InStorePickupScreenState extends State<InStorePickupScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize=size.height+size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size(size.width*1,allsize*0.11),
          child: Header_Widget(
            ontap: () => scaffoldKey.currentState!.openDrawer(),
            searchcontroller:searchController,
          ),),
        key: scaffoldKey,
        drawer: const Custom_drawer(),
        body: SingleChildScrollView(
            child:
            Consumer<InStorePickUpProvider>(
            builder: (context,inStore, child) {
              var document = parse(inStore.inStorePickupData['DATA']['instorePickup']['val']);
              String informationData=document.outerHtml.toString();
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SearchList(searchcontroller: searchController),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "IN-STORE PICKUP",
                      style: TextStyle(fontSize: 23,
                          fontFamily: 'oswald_bold',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: size.height*0.01,),
                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      inStore.inStorePickupData['DATA']['instorePickup']['subHeading'],
                      style: const TextStyle(fontSize: 17,
                          fontFamily: 'oswald_bold',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(height: size.height*0.01,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.01),
                    child: Html(
                      data: informationData,
                        style: {
                          "p":Style(
                            fontSize:FontSize(17)
                          ),
                          "h4":Style(
                            fontSize: FontSize(20),
                            fontWeight: FontWeight.bold
                          )
                        }
                    ),
                  ),
                  const SubcribeWidget(),
                  const Footer(),
                  SizedBox(
                    height: size.height * 0.05,
                  )
                ],
              );
            })

        ),
      ),
    );
  }
}
