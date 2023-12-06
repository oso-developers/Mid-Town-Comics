

import '../export.dart';

class AddressProvider extends ChangeNotifier {

  bool indicator=false;
  changeindicator(bool data)
  {
    indicator=data;
    notifyListeners();
  }

  Map<String,dynamic> Addressalldata={};
  List<dynamic>address=[];

  LoadAddressData(Map<String,dynamic>data)
  {
    Addressalldata=data;
    address=data['DATA']['addressList'];
    notifyListeners();
  }

}