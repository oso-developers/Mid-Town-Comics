import 'package:midtowncomics/export.dart';
class SearchList extends StatefulWidget {
  TextEditingController searchcontroller;
  SearchList({super.key,required this.searchcontroller});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return  Consumer<StreamedDataProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              provider.showsearchlist == true
                  ? provider.returnproduct.isEmpty
                  ? Container()
                  : ListView.builder(
                  physics:
                  const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                  provider.returnproduct.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          widget.searchcontroller
                              .text = provider
                              .returnproduct[index]
                          ['pr_ttle'];
                        });
                        provider.updatesearchselextion(
                            provider.returnproduct[
                            index]['pr_ttle']);
                      },
                      child: Container(
                        color: index % 2 == 0
                            ? const Color(0xffececec)
                            : Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(
                              allsize * 0.005),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize:
                                  allsize * 0.012,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    "${provider.returnproduct[index]['pr_ttle']}-",
                                    style: const TextStyle(
                                        color: Color(
                                            0xff818181))),
                                TextSpan(
                                    text:
                                    provider.returnproduct[
                                    index]
                                    ['cg_name'],
                                    style: const TextStyle(
                                        color: Color(
                                            0xff217fda))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                  : Container(),
            ],
          );
        });
  }
}
