

import '../export.dart';

class CreditCardProvider extends ChangeNotifier {


  List<dynamic>month=[{
    "id":"1",
    "year":'January'
  },{
    "id":"2",
    "year":'February'
  },{
    "id":"3",
    "year":'March'
  },{
    "id":"4",
    "year":'April'
  },{
    "id":"5",
    "year":'May'
  },{
    "id":"6",
    "year":'June'
  },{
    "id":"7",
    "year":'July'
  },{
    "id":"8",
    "year":'August'
  },{
    "id":"9",
    "year":'September'
  },{
    "id":"10",
    "year":'October'
  },{
    "id":"11",
    "year":'November'
  },{
    "id":"12",
    "year":'December'
  }];

  List<dynamic>cardData=[{
    "id":"MC",
    "card":'MasterCard'
  }, {
    "id":"AX",
    "card":'American Express'
  },{
    "id":"DI",
    "card":'Discover'
  },{
    "id":"VI",
    "card":'Visa'
  },];

  bool showsearchlist = false;
  searchlist(bool show) {
    showsearchlist = show;
    notifyListeners();
  }
  Map<String,dynamic> creditcarddata={};
  List<dynamic>creditcardlist=[];
  LoadCreditCard(Map<String,dynamic>data){
    creditcarddata=data;
    creditcardlist=data['DATA']['ccList'];
    notifyListeners();
  }

}