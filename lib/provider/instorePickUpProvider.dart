
import '../export.dart';

class InStorePickUpProvider extends ChangeNotifier{
  Map<String,dynamic>inStorePickupData={};
      updateInStorePickUpData(Map<String,dynamic>data)
      {
        inStorePickupData=data;
        notifyListeners();
      }
}