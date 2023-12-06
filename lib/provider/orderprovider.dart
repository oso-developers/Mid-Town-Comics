
import '../export.dart';

class OrderProvider extends ChangeNotifier {

  Map<String,dynamic>CompleteOrderData={};
  List<dynamic>inProcessOrder=[];
  List<dynamic>shippedOrder=[];
  List<dynamic>declinedOrder=[];
  List<dynamic>CancelOrder=[];
  List<dynamic>ArchieveOrder=[];
  getOrder(Map<String,dynamic>data)
  {
    CompleteOrderData=data;
    inProcessOrder=data['DATA']['inProcessOrders'];
    shippedOrder=data['DATA']['shippedOrders'];
    declinedOrder=data['DATA']['declinedOrders'];
    CancelOrder=data['DATA']['cancelledOrders'];
    ArchieveOrder =data['DATA']['archivedOrders'];
    notifyListeners();
  }

}