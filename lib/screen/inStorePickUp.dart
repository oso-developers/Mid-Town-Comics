// ignore_for_file: library_private_types_in_public_api
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/shipingInformationProvider.dart';
import 'package:midtowncomics/widget/searchList.dart';

class loadInstorePickUp extends StatefulWidget {
  const loadInstorePickUp({super.key});

  @override
  State<loadInstorePickUp> createState() => _loadInstorePickUpState();
}

class _loadInstorePickUpState extends State<loadInstorePickUp> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                          SizedBox(height: size.height*0.3),
                          Html(
                            data: informationData,
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
