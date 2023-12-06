
import 'package:midtowncomics/export.dart';

class HomeScreenBanner extends StatelessWidget {
  const HomeScreenBanner({super.key,});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<StreamedDataProvider>(builder: (context, provider, child) {
      String imagedata= "";

      if(provider.headerList.isEmpty)
        {
          imagedata="";
        }
      else{
        imagedata=provider.headerList[0]['img_url'];
      }

      return
        provider.streamedData.isEmpty || imagedata==" "
            ?
        Container()
        // const Center(
        //   child: CircularProgressIndicator(),
        // )
            :
        SizedBox(
        height: size.height * 0.36,
        width: double.infinity,
        child: provider.streamedData.isEmpty || imagedata==" "
            ?
            Container()
        // const Center(
        //   child: CircularProgressIndicator(),
        // )
            :
        Image.network(
         imagedata,
          fit: BoxFit.fill,
          loadingBuilder:  ( context, child,  loadingProgress) {
            if(loadingProgress==null)
            {
              return child;
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          },
          errorBuilder: (context, exception, stackTrace) {
            return Image.asset('assets/images/imagecomingsoon_ful.jpg',fit: BoxFit.cover,);
          },
        ),
      );
    });
  }
}
