
import '../export.dart';

class AccountSettingProvider extends ChangeNotifier{
  Map<String,dynamic>AccountSettingData={};

  //My Profile Data Handling
  Map<String,dynamic>profiledata={};

  //My Order Data Handling
  List<dynamic>orderinprocess=[];
  List<dynamic>Shippedorder=[];
  List<dynamic>declinedorder=[];
  List<dynamic>pullListItem=[];
  Map<String,dynamic>pullListSetting={};

  //***************Account Setting******************
  //Subscription Type
  List<dynamic>subscriptionType=[];
  List<dynamic>subscriptionExtra=[
    { "sub_type": "0",
      "sub_type_name": "Select Subscription Type"}
  ];

  //Shipping Frequency
  List<dynamic>shippingFrequency=[];
  List<dynamic>shippingFrequentExtra=[ {
    "ssbillcycle": "0",
    "ssbillcycle_value": "Select Shipping Frequency"
  }];
  List<dynamic>shippingFrequencyInStore=[
    {
      "ssbillcycle": "",
      "ssbillcycle_value": "Select Shipping Frequency"
    },
    {
      "ssbillcycle": "Weekly",
      "ssbillcycle_value": "Weekly"
    },
  ];

  //Location
  List<dynamic>location=[];
  List<dynamic>locationExtra=[
    {"ss_location": " ",
      "ss_location_address": "Select Shipping Address"}
  ];
  
  //Address
  List<dynamic>addressList=[];
  List<dynamic>addressExra=[
    {
      'full_address':'Select Address'
    }
  ];
  List<dynamic>shippingAddressInStore=[

  ];

  //Shipping Method
  List<dynamic>shippingMethodUSA=[
    {
      "id":"",
      "shipping_method":"Select Shipping Method"
    },
    {
      "id":"1",
      "shipping_method":"UPS Ground (Continental U.S. only) (3-5 days plus processing)"
    },
    {
      "id":"2",
      "shipping_method":"UPS 2nd DAY (Continental U.S. only)"
    },
    {
      "id":"3",
      "shipping_method":"UPS NEXT DAY (Continental U.S. only)"
    },
    {
      "id":"5",
      "shipping_method":"Economy Mail (USA Only) (3-12 days plus processing)"
    },
    {
      "id":"6",
      "shipping_method":"USPS Priority Mail (USA Only) (3-7 days plus processing)"
    },
  ];
  List<dynamic>shippingMethodInter=[
    {
      "id":"",
      "shipping_method":"Select Shipping Method"
    },
    {
      "id":"16",
      "shipping_method":"Priority Mail Express International™"
    },
    {
      "id":"17",
      "shipping_method":"Priority Mail International Flat Rate Envelope"
    },
    {
      "id":"21",
      "shipping_method":"Priority Mail International"
    },
  ];
  List<dynamic>shippingMethodExtra=[{
    "id":"",
    "shipping_method":"Select Shipping Method"
  },];
  List<dynamic>shippingMethodInStore=[ ];

  //Credit Card Value
  List<dynamic> creditCard=[];
  List<dynamic> creditCardExtra=[
    {
      "pm_cardnum":"Select Credit Card",
      "pm_id":""
    }
  ];

  getAccountSetting(Map<String,dynamic>data)
  {
    AccountSettingData=data;

    //My Profile Data Handling
    profiledata=data['DATA']['profile'];

    //My Order Data Handling
    orderinprocess=data['DATA']['pendingOrders'];
    Shippedorder=data['DATA']['shippedOrders'];
    declinedorder=data['DATA']['declinedOrders'];
    pullListItem=data['DATA']['pullListItems'];
    pullListSetting=data['DATA']['pullListSetting'];
    //***************Account Setting******************
    //Subscription Type
    subscriptionType=subscriptionExtra+data['DATA']['PullListTypes'];
    if(pullListSetting.isEmpty)
      {
        updateSubscriptionVariable('Select Subscription Type');
      }
    else{
      String smId=data['DATA']['pullListSetting']['sm_id'];
      if(smId=="10"||smId=="32"||smId=="40"||smId=="45"||smId=="64")
      {
        updateSubscriptionVariable("In-Store Pickup");
      }
      else if(subscriptionType.length==1)
      {
        updateSubscriptionVariable('Select Subscription Type');
      }
      else
      {
        updateSubscriptionVariable('Mail Order Delivery');
      }
    }

    //Shipping Frequency
    shippingFrequency=shippingFrequentExtra+data['DATA']['PullListShippingFrequency'];
    updateShippingFrequencyVariable(pullListSetting.isEmpty?"Select Shipping Frequency":data['DATA']['pullListSetting']['billcycle']);
    //Location
    location=locationExtra+data['DATA']['PullListStoreLocations'];
    //Shipping Address
    addressList=addressExra+data['DATA']['addressList'];
    if(addressList.length==2)
      {
        updateShippingAddressVariable("${data['DATA']['addressList'][0]['full_name']}\n${data['DATA']['addressList'][0]['sa_desc']} ${data['DATA']['addressList'][0]['sa_addr1']}\n"
            " ${data['DATA']['addressList'][0]['sa_addr2']}\n ${data['DATA']['addressList'][0]['sa_city']},${data['DATA']['addressList'][0]['sa_state']} ${data['DATA']['addressList'][0]['sa_zip']}\n"
            "${data['DATA']['addressList'][0]['country_name']}");
        updateBillingAddressVariable(("${data['DATA']['addressList'][0]['full_name']}\n${data['DATA']['addressList'][0]['sa_desc']} ${data['DATA']['addressList'][0]['sa_addr1']}\n"
            " ${data['DATA']['addressList'][0]['sa_addr2']}\n ${data['DATA']['addressList'][0]['sa_city']},${data['DATA']['addressList'][0]['sa_state']} ${data['DATA']['addressList'][0]['sa_zip']}\n"
            "${data['DATA']['addressList'][0]['country_name']}"));
      }
    else
      {
        updateShippingAddress(pullListSetting['sa_id_shp'],data['DATA']['addressList']);
        updateBillingAddress(pullListSetting['sa_id_bill'],data['DATA']['addressList']);
      }

    //Shipping Method
    shippingMethodInStore=shippingMethodExtra;
    if(pullListSetting.isEmpty)
      {
        updateShippingMethodVariable("Select Shipping Method");
      }
    else{
      updateShippingMethodVariable(data['DATA']['pullListSetting']['shipmeth']);
    }

    //Credit Card Value
    creditCard=creditCardExtra+data['DATA']['ccList'];
    if(pullListSetting.isEmpty)
      {
        updateCreditCardVariable("Select Credit Card");
      }
    else{
      updateCreditCardValue(data['DATA']['pullListSetting']['pm_id'], data['DATA']['ccList']);
    }


    //Preview Setting
    previewSetting=data['DATA']['previewSetting'];
    if(previewSetting.isEmpty)
      {
        updatePreviewBillingAddress("Select Address");
        updatePreviewShippingAddress("Select Address");
        updatePreviewShippingMethod("Select Shipping Method");
        updatePreviewShippingFrequency("Select Shipping Frequency");
        updatePreviewSettingCreditCard("Select Credit Card");
      }
    else{
      updatePreviewAddressBilling(data['DATA']['previewSetting']['sa_id_bill'],data['DATA']['addressList']);
      updatePeviewAddressShipping(data['DATA']['previewSetting']['sa_id_shp'],data['DATA']['addressList']);
      updatePreviewShippingMethodVariable(data['DATA']['previewSetting']['sm_desc']);
      updatePreviewShippingFrequency(data['DATA']['previewSetting']['billcycle']);
      updatePreviewCreditCardValue(data['DATA']['previewSetting']['pm_id'], data['DATA']['ccList']);
    }
    notifyListeners();
  }


  //************Account Setting***********
  //Variable Data Handling
  String subscriptionTypeVariable="";
  updateSubscriptionVariable(String data){
    subscriptionTypeVariable=data;
    if(data=="In-Store Pickup")
    {
      updateSubscriptionTypeApi('InStore');
    }
    else if(data=="Mail Order Delivery")
    {
      updateSubscriptionTypeApi('Mail');
    }
    else
    {
      updateSubscriptionTypeApi('0');
    }
    notifyListeners();
  }

  String shippingFrequencyVariable="";
  updateShippingFrequencyVariable(String data)
  {
    shippingFrequencyVariable=data;
    if(data=='Weekly')
      {
        updateShippingFrequencyApi('Weekly');
      }
    else if(data=="Bi-Weekly")
      {
        updateShippingFrequencyApi('Bi-Weekly');
      }
    else if(data=='Monthly')
      {
        updateShippingFrequencyApi('Monthly');
      }
    else{
      updateShippingFrequencyApi("");
    }
    notifyListeners();
  }

  String locationVariable="Select Store Location";
  updateLocation(String data){
    locationVariable=data;
    notifyListeners();
  }

  String shippingAddressVariable="";
  updateShippingAddressVariable(String data)
  {
    shippingAddressVariable=data;
    notifyListeners();
  }

  String shippingMethodVariable="";
  updateShippingMethodVariable(String data)
  {
    shippingMethodVariable=data;
    if(data=="UPS Ground (Continental U.S. only) (3-5 days plus processing)")
    {
      updateShippingMethodApi('1');
    }
    else if(data=="UPS 2nd DAY (Continental U.S. only)")
    {
      updateShippingMethodApi('2');
    }
    else if(data=="UPS NEXT DAY (Continental U.S. only)")
    {
      updateShippingMethodApi('3');
    }
    else if(data=="Economy Mail (USA Only) (3-12 days plus processing)*")
    {
      updateShippingMethodApi('5');
    }
    else if(data=="USPS Priority Mail (USA Only) (3-7 days plus processing)")
    {
      updateShippingMethodApi('6');
    }
    else if(data=="Priority Mail Express International™")
    {
      updateShippingMethodApi('16');
    }
    else if(data=="Priority Mail International Flat Rate Envelope")
    {
      updateShippingMethodApi('17');
    }
    else if(data=="Priority Mail International")
    {
      updateShippingMethodApi('21');
    }
    else
    {
      updateShippingMethodApi('');
    }
    notifyListeners();
  }

  addShippingMethod(dynamic data)
  {
    shippingMethodInStore.add(data);
    notifyListeners();
  }

  String billingAddressVariable="";
  updateBillingAddressVariable(String data)
  {
    billingAddressVariable=data;
    notifyListeners();
  }

  String creditCardVariable="";
  updateCreditCardVariable(String data)
  {
    creditCardVariable=data;
    notifyListeners();
  }

  //Api Value Handling
  String subscriptionTypeApi="";
  updateSubscriptionTypeApi(String data){
    subscriptionTypeApi=data;
    notifyListeners();
  }

  String  shippingFrequencyApi="";
  updateShippingFrequencyApi(String data)
  {
    shippingFrequencyApi=data;
    notifyListeners();
  }

  String shippingAddressApi="";
  updateShippingAddressApi(String data)
  {
    shippingAddressApi=data;
    notifyListeners();
  }

  String shippingMethodApi="";
  updateShippingMethodApi(String data)
  {
    shippingMethodApi=data;
    notifyListeners();
  }

  String locationApi="";
  updateLocationApi(String data){
    locationApi=data;
    notifyListeners();
  }

  String billingAddressApi="";
  updateBillingAddressApi(String data)
  {
    billingAddressApi=data;
    notifyListeners();
  }

  String creditCardApi="";
  updateCreditCardApi(String data)
  {
    creditCardApi=data;
    notifyListeners();
  }




  //Extra Functionalities
  updateShippingAddress(id,address){
    for (var product in address)
    {
      if (product["sa_id"] == id)
      {
        updateShippingAddressVariable("${product['full_name']}\n${product['sa_desc']} ${product['sa_addr1']}\n"
            " ${product['sa_addr2']}\n ${product['sa_city']},${product['sa_state']} ${product['sa_zip']}\n"
            "${product['country_name']}");
        updateShippingAddressVariable(product['full_address']);
        updateShippingAddressApi(product['sa_id']);
      }
    }
  }

  updateBillingAddress(id,address){
    for (var product in address)
    {
      if (product["sa_id"] == id)
      {
        updateBillingAddressVariable("${product['full_name']}\n${product['sa_desc']} ${product['sa_addr1']}\n"
            " ${product['sa_addr2']}\n ${product['sa_city']},${product['sa_state']} ${product['sa_zip']}\n"
            "${product['country_name']}");
        updateBillingAddressApi(product['sa_id']);
      }
    }
  }

  updateCreditCardValue(id,ccList){
    for (var product in ccList)
    {
      if (product["pm_id"] == id)
      {
        updateCreditCardVariable(product['pm_cardnum']);
        updateCreditCardApi(product["pm_id"]);
      }
    }
  }


  //Preview Setting Management
  Map<String,dynamic>previewSetting={};

  String previewSettingCreditCard="";
  updatePreviewSettingCreditCard(String data)
  {
    previewSettingCreditCard=data;
    notifyListeners();
  }

  String previewSettingBillingAddress="";
  updatePreviewBillingAddress(String data)
  {
    previewSettingBillingAddress=data;
    notifyListeners();
  }

  String previewSettingShippingFrequency="";
  updatePreviewShippingFrequency(String data)
  {
    previewSettingShippingFrequency=data;
    notifyListeners();
  }

  String previewSettingShippingAddress="";
  updatePreviewShippingAddress(String data)
  {
    previewSettingShippingAddress=data;
    notifyListeners();
  }

  String previewSettingShippingMethod="";
  updatePreviewShippingMethod(String data)
  {
    previewSettingShippingMethod=data;
    notifyListeners();
  }

//Shipping Method Api Value
  String previewSettingCreditCardValue="";
  updatePreviewSettingCreditCardValue(String data)
  {
    previewSettingCreditCardValue=data;
    notifyListeners();
  }

  String previewSettingBillingAddressValue="";
  updatePreviewBillingAddressValue(String data)
  {
    previewSettingBillingAddressValue=data;
    notifyListeners();
  }

  String previewSettingShippingFrequencyValue="";
  updatePreviewShippingFrequencyValue(String data)
  {
    previewSettingShippingFrequency=data;
    notifyListeners();
  }

  String previewSettingShippingAddressValue="";
  updatePreviewShippingAddressValue(String data)
  {
    previewSettingShippingAddressValue=data;
    notifyListeners();
  }


  String previewSettingShippingMethodValue="";
  updatePreviewShippingMethodValue(String data)
  {
    previewSettingShippingMethodValue=data;
    notifyListeners();
  }


  //Extra Handle About Preview Setting
  updatePreviewAddressBilling(id,address){
    for (var product in address)
    {
      if (product["sa_id"] == id)
      {
        updatePreviewBillingAddress("${product['full_name']}\n${product['sa_desc']} ${product['sa_addr1']}\n"
            " ${product['sa_addr2']}\n ${product['sa_city']},${product['sa_state']} ${product['sa_zip']}\n"
            "${product['country_name']}");
        updatePreviewBillingAddressValue(product['sa_id']);
      }
    }
  }

  updatePeviewAddressShipping(id,address){
    for (var product in address)
    {
      if (product["sa_id"] == id)
      {
        updatePreviewShippingAddress("${product['full_name']}\n${product['sa_desc']} ${product['sa_addr1']}\n"
            " ${product['sa_addr2']}\n ${product['sa_city']},${product['sa_state']} ${product['sa_zip']}\n"
            "${product['country_name']}");
        updatePreviewShippingAddressValue(product['sa_id']);
      }
    }
  }

  updatePreviewCreditCardValue(id,ccList){
    for (var product in ccList)
    {
      if (product["pm_id"] == id)
      {
        updatePreviewSettingCreditCard(product['pm_cardnum']);
        updatePreviewSettingCreditCardValue(product["pm_id"]);
      }
      else{
        updatePreviewSettingCreditCard(product['pm_cardnum']);
      }
    }
  }

  updatePreviewShippingMethodVariable(String data)
  {
    shippingMethodVariable=data;
    if(data=="Economy Mail (USA Only) (3-12 days plus processing)*")
    {
      updatePreviewShippingMethod('Economy Mail (USA Only) (3-12 days plus processing)*');
      updatePreviewShippingMethodValue('1');
    }
    else if(data=="UPS 2nd DAY (Continental U.S. only)")
    {
      updatePreviewShippingMethod('UPS 2nd DAY (Continental U.S. only)');
      updatePreviewShippingMethodValue('2');
    }
    else if(data=="UPS NEXT DAY (Continental U.S. only)")
    {
      updatePreviewShippingMethod('UPS NEXT DAY (Continental U.S. only)');
      updatePreviewShippingMethodValue('3');
    }
    else if(data=="Economy Mail (USA Only) (3-12 days plus processing)* * *")
    {
      updatePreviewShippingMethod('Economy Mail (USA Only) (3-12 days plus processing)* * *');
      updatePreviewShippingMethodValue('5');
    }
    else if(data=="USPS Priority Mail (USA Only) (3-7 days plus processing)")
    {
      updatePreviewShippingMethod('USPS Priority Mail (USA Only) (3-7 days plus processing)');
      updatePreviewShippingMethodValue('6');
    }
    else if(data=="Priority Mail Express International™")
    {
      updatePreviewShippingMethod('Priority Mail Express International™');
      updatePreviewShippingMethodValue('16');
    }
    else if(data=="Priority Mail International Flat Rate Envelope")
    {
      updatePreviewShippingMethod('Priority Mail International Flat Rate Envelope');
      updatePreviewShippingMethodValue('17');
    }
    else if(data=="Priority Mail International")
    {
      updatePreviewShippingMethod('Priority Mail International');
      updatePreviewShippingMethodValue('21');
    }
    else
    {
      updateShippingMethodApi('');
    }
    notifyListeners();
  }


}