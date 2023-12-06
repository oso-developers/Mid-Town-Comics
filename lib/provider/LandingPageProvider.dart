
import '../export.dart';

class LandingPageProvider extends ChangeNotifier{

  Map<String,dynamic>landingPageData={};
  Map<String,dynamic>pageSummary={};
  List<dynamic>featuredData=[];
  List<dynamic>categoryList=[];
  updateLandingPageData(Map<String,dynamic>data)
  {
    landingPageData=data;
    pageSummary=data['DATA']['pageSummary'];
    featuredData=data['DATA']['featuredList'];
    categoryList=data['DATA']['categoryList'];
    notifyListeners();
  }
}