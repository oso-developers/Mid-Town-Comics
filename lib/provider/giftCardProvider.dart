
import '../export.dart';

class GiftCardProvider extends ChangeNotifier{
  Map<String,dynamic>giftCardData={};
  List<dynamic>giftCardList=[];
  updateGiftCardData(Map<String,dynamic>data)
  {
    giftCardData=data;
    giftCardList=data['DATA']['gcList'];
    notifyListeners();
  }

}