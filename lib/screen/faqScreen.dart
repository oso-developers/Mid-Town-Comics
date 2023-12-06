// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/searchList.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQScreen extends StatefulWidget {
  List<dynamic>data=[];
  String faqTopic;
   FAQScreen({super.key,required this.data,required this.faqTopic});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  bool defaultshipping = true;
  bool defaultbilling = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
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
              Container(
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
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "FAQ",
                        style: TextStyle(
                            fontSize: allsize * 0.017,
                            fontFamily: 'oswald_bold',
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              SizedBox(
                height: size.height*0.01,
              ),
              Container(
                width: size.width*1,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  width: size.width*1,
                  color: const Color(0xffffffff),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height*0.01,),
                        Text(widget.faqTopic,style: TextStyle(
                            color: Colors.grey[600],
                            fontFamily: 'opensans_semibold',
                            fontWeight: FontWeight.w900,
                            fontSize: allsize*0.015
                        ),),
                        SizedBox(
                          height: size.height*0.01,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.data.length,
                          itemBuilder: (context, index) {
                            return Theme(
                              data: ThemeData(
                                  visualDensity: const VisualDensity(vertical: -4),
                                dividerColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                childrenPadding: EdgeInsets.zero,
                                tilePadding: EdgeInsets.zero,
                                trailing:const Text(""),
                                title: RichText(
                                  text: HTML.toTextSpan(
                                    context, widget.data[index]['question'],
                                    defaultTextStyle: TextStyle(
                                        fontSize: allsize * 0.011,
                                        fontFamily: 'opensans_semibold',
                                        color: const Color(0xff006ccf),
                                        fontWeight: FontWeight.w900
                                    ),
                                  ),
                                ),
                                onExpansionChanged: (value) {
                                },
                                children:[
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: RichText(
                                        text: HTML.toTextSpan(
                                          context,widget.data[index]['answer'],
                                            linksCallback: (link) async{
                                              if (!await launchUrl(Uri.parse(link))) {
                                              throw Exception('Could not launch ${Uri.parse(link)}');
                                              }
                                            },
                                          defaultTextStyle: TextStyle(
                                              fontSize: allsize * 0.012
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ),
              SizedBox(height: size.height*0.03,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("Note:We reserve the right to cancel any order at our discretion",style: TextStyle(
                  fontSize: allsize*0.011,
                  fontStyle: FontStyle.italic
                ),),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const SubcribeWidget(),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Footer(),
              SizedBox(
                height: size.height * 0.015,
              )
            ],
          ),),
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
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        trailing: Container(
          width: 0,
        ),
        title: Text(
          widget.questionAnswer.question,
          style: TextStyle(
              fontSize: allsize * 0.013,
              color: const Color(0xff006ccf),
              fontWeight: FontWeight.w600),
        ),
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.questionAnswer.answer,
                style: TextStyle(fontSize: allsize * 0.012)),
          ),
        ],
      ),
    );
  }
}
