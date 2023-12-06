import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midtowncomics/screen/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/apirequest.dart';

class StreamedDataProvider extends ChangeNotifier {
  bool showsearchlist = false;
  searchlist(bool show) {
    showsearchlist = show;
    notifyListeners();
  }

  //Circular Indicator
  bool changeindicator = false;

  change(bool indicator) {
    changeindicator = indicator;
    notifyListeners();
  }

  bool searchpagein = false;

  changesearchind(bool indicator) {
    searchpagein = indicator;
    notifyListeners();
  }

  //Button Indicator
  bool buttonindicator = false;

  changebutton(bool indicator) {
    buttonindicator = indicator;
    notifyListeners();
  }

  bool detailpageindicator = false;

  changedetailind(bool indicator) {
    changeindicator = indicator;
    notifyListeners();
  }

  //Search Dropdown
  String title = "All";

  //Sort by Value
  int selectedValue = 0;

  sorby(int data) {
    selectedValue = data;
    notifyListeners();
  }

  changetitle(String titl) {
    title = titl;
    notifyListeners();
  }

  //Home Screen Api
  Map<String, dynamic> _streamedData = {};

  Map<String, dynamic> get streamedData => _streamedData;
  List<dynamic>headerList=[];
  Map<String,dynamic> Pagebanner3={};
  Map<String,dynamic> Pagebanner4={};
  Map<String,dynamic> Pagebanner5={};
  Map<String,dynamic> Pagebanner6={};
  List<dynamic>slider1=[];
  List<dynamic> crossoverlist = [];
  List<dynamic> recommendedforyou = [];
  List<dynamic> featurenewrelease = [];
  List<dynamic> recomendedpreorder = [];
  List<dynamic> recomendedbackissue = [];
  List<dynamic> bestSeller = [];
  List<dynamic> exclusive = [];
  List<dynamic>Pagebannerlist1=[];
  List<dynamic>Pagebannerlist2=[];
  Map<String,dynamic>DODSummary={};
  Map<String,dynamic>shoppersummary={};
  Map<String,dynamic>featurenewrelease1={};
  Map<String,dynamic>weeklyReleasegrid={};
  Map<String,dynamic>pulllistSummary={};
  Map<String,dynamic>preorderSummary={};
  Map<String,dynamic>whishlistSummary={};
  Map<String,dynamic>featurenewreleasegrid={};
  Map<String,dynamic>featurenewrelease2={};
  Map<String,dynamic>featurenewrelease3={};
  Map<String,dynamic>featurenewrelease4={};
  void updateData(Map<String, dynamic> data) {
    _streamedData = data;
    headerList=data['DATA']['headerList'];
    crossoverlist = _streamedData['DATA']['sCrossOversList'];
    recommendedforyou =
        _streamedData['DATA']['recommendedForYouSection']['productList'];
    featurenewrelease =
        _streamedData['DATA']['newReleasesSection']['productList'];
    recomendedpreorder =
        _streamedData['DATA']['recommendedPreOrdersSection']['productList'];
    recomendedbackissue =
        _streamedData['DATA']['recommendedBISection']['productList'];
    bestSeller = _streamedData['DATA']['bestSellersSection']['productList'];
    exclusive = _streamedData['DATA']['mtExlusiveSection']['productList'];
    Pagebanner3=_streamedData['DATA']['pageBanner3'];
    Pagebanner4=_streamedData['DATA']['pageBanner4'];
    Pagebanner5=_streamedData['DATA']['pageBanner5'];
    Pagebanner6=_streamedData['DATA']['pageBanner6'];
    slider1=_streamedData['DATA']['sliderList'];
    Pagebannerlist1=_streamedData['DATA']['pageBanner1List'];
    Pagebannerlist2=_streamedData['DATA']['pageBanner2List'];
    DODSummary=_streamedData['DATA']['DODSummary'];
    shoppersummary=_streamedData['DATA']['shopperSummary'];
    weeklyReleasegrid=_streamedData['DATA']['weeklyReleaseSummary'];
    pulllistSummary=_streamedData['DATA']['pullListSummary'];
    preorderSummary=_streamedData['DATA']['preOrdersSummary'];
    whishlistSummary=_streamedData['DATA']['wishListSummary'];
    DODSummary=_streamedData['DATA']['DODSummary'];
    featurenewrelease2=_streamedData['DATA']['featureNewAdditionSection2'];
    featurenewrelease3=_streamedData['DATA']['featureNewAdditionSection3'];
    featurenewrelease4=_streamedData['DATA']['featureNewAdditionSection4'];
    featurenewreleasegrid=_streamedData['DATA']['featureNewAdditionSection1'];
    featurenewrelease1=_streamedData['DATA']['featureNewAdditionSection1'];
    notifyListeners();
  }

  //Cart Api
  Map<String, dynamic> _cartstream = {};

  Map<String, dynamic> get cartdata => _cartstream;

  void updateCartData(Map<String, dynamic> data) {
    _cartstream = data;
    notifyListeners();
  }


  //Update Pull List Data
  Map<String, dynamic> _pullListData = {};
  Map<String, dynamic> get pullListData => _pullListData;

  void updatePullListData(Map<String, dynamic> data) {
    _pullListData = data;
    notifyListeners();
  }

  //Product Detail Page
  Map<String, dynamic> _productdetail = {};

  Map<String, dynamic> get productdetail => _productdetail;
  List<dynamic> writer = [];
  List<dynamic> artist = [];
  List<dynamic> recentlyview = [];
  List<dynamic> multiplecoverlist = [];
  Map<String, dynamic> detail = {};
  List<dynamic> grades = [];
  String groupvalue = "";

  void updateProductDetail(Map<String, dynamic> data) {
    _productdetail = data;
    writer = _productdetail['DATA']['writerList']??[];
    artist = _productdetail['DATA']['artistList'];
    recentlyview = _productdetail['DATA']['recentlyViewList'];
    multiplecoverlist = _productdetail['DATA']['multipleCoversList'];
    detail = _productdetail['DATA']['prDetail'];
    grades = _productdetail['DATA']['prDetail']['grades'];
    if (detail['grades'] == null) {
      groupvalue = "";
    } else {
      if (detail['pr_conditionflag'] == "1") {
        groupvalue = "Near Mint";
        notifyListeners();
      } else if (detail['pr_conditionflag'] == "3") {
        groupvalue = "Very Fine";
        notifyListeners();
      } else if (detail['pr_conditionflag'] == "4") {
        groupvalue = "Fine";
        notifyListeners();
      } else if (detail['pr_conditionflag'] == "5") {
        groupvalue = "Very Good";
        notifyListeners();
      } else if (detail['pr_conditionflag'] == "6") {
        groupvalue = "Good";
        notifyListeners();
      }
    }

    notifyListeners();
  }

  void updateDetailIsSubscriber()
  {
    detail['issubscribe']="1";
    notifyListeners();
  }

  setgroupvalue(String data) {
    groupvalue = data;
  }

  //Change Status
  void updatedetail(String data, scQty) {
    detail['pr_id'] = data;
    detail['sc_qty'] = scQty.toString();
    notifyListeners();
  }

  //Update for Wish List
  void updateWishListDetail()
  {
    detail['addedtowl']="1";
    notifyListeners();
  }

  void updatedetailongrades(Map<String, dynamic> data) {
    detail['pr_id'] = data['pr_id'];
    detail['pr_price'] = data['pr_price'];
    detail['pr_lprice'] = data['pr_lprice'];
    detail['pr_advord'] = data['pr_advord'];
    detail['pr_qty'] = data['pr_qty'];
    notifyListeners();
  }

  void chanddetai(Map<String, dynamic> data) {
    detail = data;
  }

  //Update Recomended For You
  void updateInreco(String productId, String inCartValue, scQty,addedtowl) {
    print('InCartValue');
    print(inCartValue);
    for (var product in recommendedforyou) {
      print(productId);
      if (product["pr_id"] == productId) {
        print("pr_id is availible");
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        notifyListeners();
        print(product['in_cart']);
        break; // Exit the loop once the product is found and updated
      }
    }
  }

  //Feature New Release
  void updatefeature(String productId, String inCartValue, scQty,addedtowl) {
    for (var product in featurenewrelease) {
      if (product["pr_id"] == productId) {
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        notifyListeners();
        break; // Exit the loop once the product is found and updated
      }
    }
  }

  //Recomended Pre Order
  void updatepreorder(String productId, String inCartValue, scQty,addedtowl) {
    for (var product in recomendedpreorder) {
      if (product["pr_id"] == productId) {
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        notifyListeners();
        break; // Exit the loop once the product is found and updated
      }
    }
  }

  //Recomended Back Issue
  void updateback(String productId, String inCartValue, scQty,addedtowl) {
    for (var product in recomendedbackissue) {
      if (product["pr_id"] == productId) {
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        notifyListeners();
        break; // Exit the loop once the product is found and updated
      }
    }
  }

  //Best Seller
  void updatebest(String productId, String inCartValue, scQty,addedtowl) {
    for (var product in bestSeller) {
      if (product["pr_id"] == productId) {
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        notifyListeners();
        break; // Exit the loop once the product is found and updated
      }
    }
  }

  //Exclusive
  void updateexclusive(String productId, String inCartValue, scQty,addedtowl) {
    for (var product in exclusive) {
      if (product["pr_id"] == productId) {
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        notifyListeners();
        break; // Exit the loop once the product is found and updated
      }
    }
  }

  //Call All Methods
  void call(String productId, String inCartValue, scQty,addedtowl) {
    print("-------InCart Value------");
    print(inCartValue);
    updateInreco(productId, inCartValue, scQty,addedtowl);
    updatefeature(productId, inCartValue, scQty,addedtowl);
    updatepreorder(productId, inCartValue, scQty,addedtowl);
    updateback(productId, inCartValue, scQty,addedtowl);
    updatebest(productId, inCartValue, scQty,addedtowl);
    updateexclusive(productId, inCartValue, scQty,addedtowl);
  }

  //Login Data Management
  Map<String, dynamic> loindata = {};
  Map<String, dynamic> loginuserdata = {};

  updateLogingData(Map<String, dynamic> data,bool remember) async {
    loindata = data;
    if(remember==true)
      {
        loginuserdata={
          "sh_id":data['DATA']['shDetail']['sh_id'],
          "sh_lgid":data['DATA']['shDetail']['sh_lgid'],
          "sh_fname":data['DATA']['shDetail']['sh_fname'],
          "sh_lname": data['DATA']['shDetail']['sh_lname']
        };
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sh_id', data['DATA']['shDetail']['sh_id']);
        await prefs.setString('sh_lgid', data['DATA']['shDetail']['sh_lgid']);
        await prefs.setString('sh_fname', data['DATA']['shDetail']['sh_fname']);
        await prefs.setString('sh_lname', data['DATA']['shDetail']['sh_lname']);
      }
    else{
      loginuserdata={
        "sh_id":data['DATA']['shDetail']['sh_id'],
        "sh_lgid":data['DATA']['shDetail']['sh_lgid'],
        "sh_fname":data['DATA']['shDetail']['sh_fname'],
        "sh_lname": data['DATA']['shDetail']['sh_lname']
      };
    }
    Map<String, dynamic> datacart = await ApiRequests()
        .loadcartdata(loginuserdata.isEmpty ? "" : loginuserdata['sh_id']);
    updateCartData(datacart);
    Map<String, dynamic> dataPullList = await ApiRequests()
        .loadPullList(loginuserdata.isEmpty ? "" : loginuserdata['sh_id']);
    updatePullListData(dataPullList);
    Map<String, dynamic> datahome = await ApiRequests()
        .fetchData1(loginuserdata.isEmpty ? "" : loginuserdata['sh_id']);
    updateData(datahome);
    notifyListeners();
  }

  updateSharedPrefrenceData(String sh_id,email,f_name,l_name)
  async{
    loginuserdata={
      "sh_id":sh_id,
      "sh_lgid":email,
      "sh_fname":f_name,
      "sh_lname": l_name
    };
    Map<String, dynamic> datacart = await ApiRequests()
        .loadcartdata(loginuserdata.isEmpty ? "" : loginuserdata['sh_id']);
    updateCartData(datacart);
    Map<String, dynamic> dataPullList = await ApiRequests()
        .loadPullList(loginuserdata.isEmpty ? "" : loginuserdata['sh_id']);
    updatePullListData(dataPullList);
    Map<String, dynamic> datahome = await ApiRequests()
        .fetchData1(loginuserdata.isEmpty ? "" : loginuserdata['sh_id']);
    updateData(datahome);
    Get.off(const HomeScreen());
    notifyListeners();
}

  removelogindata() {
    loindata = {};
    loginuserdata = {};
    notifyListeners();
  }

  //Search Code
  Map<String, dynamic> searchdata = {};
  List<dynamic> returnproduct = [];
  List<dynamic> weeklyRekease = [];
  List<dynamic> releaseyear = [];
  List<dynamic> series = [];
  List<dynamic> relatedtitle = [];
  List<dynamic> catagory = [];
  List<dynamic> discount = [];
  List<dynamic> manufacturer = [];
  List<dynamic> artistf = [];
  List<dynamic> writerf = [];
  List<dynamic> price = [];
  List<dynamic> Issueno = [];
  List<String> manageimage = [];

  updatesearchdata(Map<String, dynamic> data) {
    searchdata = data;
    returnproduct = data['DATA']['productList'] ?? [];
    weeklyRekease = data['DATA']['releaseWeekList'] ?? [];
    releaseyear = data['DATA']['releaseYearList'] ?? [];
    series = data['DATA']['seriesTitleList'] ?? [];
    relatedtitle = data['DATA']['relatedTitlesList'] ?? [];
    catagory = data['DATA']['cgList'] ?? [];
    discount = data['DATA']['discountList'] ?? [];
    manufacturer = data['DATA']['manufacturerList'] ?? [];
    artistf = data['DATA']['artistList'] ?? [];
    writerf = data['DATA']['writerList'] ?? [];
    price = data['DATA']['priceList'] ?? [];
    Issueno = data['DATA']['seriesList'] ?? [];
    for (var product in returnproduct) {
      manageimage.add(product['pr_id']);
    }
    notifyListeners();
  }

  removesearchdata() {
    searchdata = {};
    returnproduct = [];
    notifyListeners();
  }

//Search Selection
  String searchselection = "";

  updatesearchselextion(String data) {
    searchselection = data;
    notifyListeners();
  }

  void updatereturnproduct(String productId, String inCartValue, scQty,addedtowl) {
    for (var product in returnproduct) {
      if (product["pr_id"] == productId) {
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        break; // Exit the loop once the product is found and updated
      }
    }
    notifyListeners();
  }

  void updatereturnproductforgrade(
      orprid, prid, prprice, prlprice, pradvard, prqty) {
    for (var product in returnproduct) {
      if (product["pr_id"] == orprid) {
        product["pr_id"] = prid;
        product["pr_price"] = prprice;
        product["pr_lprice"] = prlprice;
        product["pr_qty"] = prqty;
        notifyListeners();
        break; // Exit the loop once the product is found and updated
      }
    }
    notifyListeners();
  }


  //Countries
Map<String,dynamic>countriesData={};
  List<dynamic>countries=[];
  void updateCountriesData(Map<String,dynamic>data) {
   countriesData=data;
   countries=data['DATA']['countryList'];
   notifyListeners();
  }


  Map<String,dynamic>stateData={};
  List<dynamic>state=[];
  void updateStateData(Map<String,dynamic>data)
  {
    stateData=data;
    state=data['DATA']['statesList'];
    notifyListeners();
  }

  updateIsSubscribe(String id)
  {
    for( var product in returnproduct)
    {
      if(product['pr_id']==id)
      {
        product['issubscribe']="1";
      }
    }

    notifyListeners();
  }


}
