import '../export.dart';

class NewsLetterProvider extends ChangeNotifier{

  bool indicator=false;
  updateIndicator(bool data)
  {
    indicator=data;
    notifyListeners();
  }


  Map<String,dynamic>newsLetterList={};
  List<dynamic>newsLetterDataList=[];
  updateNewsLetterList(Map<String,dynamic> data)
  {
    newsLetterList=data;
    newsLetterDataList=data['DATA']['newsletterList'];
    notifyListeners();
  }

  updateSubscribeValue(bool value,int index)
  {
    newsLetterDataList[index]['isSubscribed']=value;
    notifyListeners();
  }

}