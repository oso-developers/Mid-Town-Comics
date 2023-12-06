
import '../export.dart';

class ShippingInformationProvider extends ChangeNotifier{
Map<String,dynamic>shippingInformation={};

updateShippingInformation(Map<String,dynamic>data)
{
  shippingInformation=data;
  notifyListeners();
}

}