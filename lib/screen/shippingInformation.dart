// ignore_for_file: library_private_types_in_public_api
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/shipingInformationProvider.dart';
import 'package:midtowncomics/widget/searchList.dart';
import 'package:simple_html_css/simple_html_css.dart';

class ShippingInformation extends StatefulWidget {
  const ShippingInformation({super.key});

  @override
  State<ShippingInformation> createState() => _ShippingInformationState();
}

class _ShippingInformationState extends State<ShippingInformation> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchList(searchcontroller: searchController),
                  Consumer<ShippingInformationProvider>(
                  builder: (context, information, child) {
                    var document = parse(information.shippingInformation['DATA']['shippingInfo']['val']);
                    String informationData=document.outerHtml.toString();
                    print(informationData);
                  return Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Shipping Information",
                            style:
                            TextStyle(
                                fontSize: 23,
                                fontFamily: 'oswald_bold',
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: size.height*0.01),
                     Padding(
                       padding:EdgeInsets.symmetric(horizontal: size.width*0.03),
                       child:
                       RichText(
                         text: HTML.toTextSpan(
                             context,information.shippingInformation['DATA']['shippingInfo']['val'],
                           overrideStyle: {
                             "p":const TextStyle(fontSize: 17),
                             "h4":const TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20
                             ),
                             "h3":const TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20
                             ),
                             "div":const TextStyle(

                             )

                             // specify any tag not just the supported ones,
                             // and apply TextStyles to them and/override them
                           },
                         ),
                       )
                    //    Html(
                    //    data: informationData,
                    //     style: {
                    //     "p":Style(
                    //     fontSize:FontSize(17)
                    //     ),
                    //     "h4":Style(
                    //     fontSize: FontSize(20),
                    //     fontWeight: FontWeight.bold
                    //     ),
                    //       "h3":Style(
                    //           fontSize: FontSize(22),
                    //           fontWeight: FontWeight.bold
                    //       ),
                    //     }
                    // ),
                     )
                      // Text(FunctionClass().parseHtmlString(document.outerHtml))
                    ],
                  );
                  }),
                const SubcribeWidget(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Footer(),
                SizedBox(
                  height: size.height * 0.05,
                )
              ],
            )),
      ),
    );
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({required this.question, required this.answer});
}

class QuestionAnswerTile extends StatefulWidget {
  final QuestionAnswer questionAnswer;

  const QuestionAnswerTile({super.key, required this.questionAnswer});

  @override
  _QuestionAnswerTileState createState() => _QuestionAnswerTileState();
}

class _QuestionAnswerTileState extends State<QuestionAnswerTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(widget.questionAnswer.question),
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.questionAnswer.answer),
          ),
        ],
      ),
    );
  }
}
