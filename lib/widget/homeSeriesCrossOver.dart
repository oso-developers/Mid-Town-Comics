import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/screen/landingPage.dart';
import '../screen/ProductDetailPage.dart';
class HomeSeriesCrossOver extends StatefulWidget {

  List<dynamic>data;
  HomeSeriesCrossOver({super.key,required this.data});

  @override
  State<HomeSeriesCrossOver> createState() => _HomeSeriesCrossOverState();
}

class _HomeSeriesCrossOverState extends State<HomeSeriesCrossOver> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
    return RawScrollbar(
      thumbColor: Colors.grey,
      thickness: allsize * 0.003,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.03,
            horizontal: size.width * 0.03),
        child: ListView.builder(
            itemCount:
            widget.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (item, index) {
              return InkWell(
                onTap: (){
                  final provider=Provider.of<StreamedDataProvider>(context,listen: false);
                  if(widget.data[index]['url_type']=="P")
                  {
                    provider.chanddetai({});
                    Get.to(ProductDetialPage(productid:widget.data[index]['search_object']['pr_id']));
                  }
                  else if(widget.data[index]['url_type']=="S")
                  {
                    provider. updatesearchselextion(widget.data[index]['search_object']['q']);
                    final streamedDataProvider =
                    Provider.of<StreamedDataProvider>(context, listen: false);
                    ApiRequests().SearchApi(streamedDataProvider.loginuserdata.isEmpty ? "" :streamedDataProvider.loginuserdata['sh_id'],widget.data[index]['search_object']['q'],"","10","","","","","","", "","", "", "", "", "","",false,"", context);
                    Get.to(const SearchPage());
                  }
                  else if(widget.data[index]['url_type']=="L")
                  {
                    final provider=Provider.of<StreamedDataProvider>(context,listen: false);
                    ApiRequests().landingPage(provider
                        .loginuserdata
                        .isEmpty
                        ? ""
                        :provider
                        .loginuserdata['sh_id'],widget.data[index]['search_object']['pageName']);
                    Get.to(LandingPage());
                  }
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: size.height * 0.08,
                      width: size.width * 0.1,
                      child: Image.network(
                        widget.data[
                        index]['img_url'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
