

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WeeklyReleaseProvider extends ChangeNotifier{
  bool weeklyreleaseindicator=false;
  changeindicator(bool data)
  {
    weeklyreleaseindicator=data;
    notifyListeners();
  }

  bool loadmore=false;
  updateloadmore(bool data)
  {
    loadmore=data;
    notifyListeners();
  }

  Map<String,dynamic>dates={};
  List<dynamic>dateslist=[];
  getdates(Map<String,dynamic>data)
  {
    dates=data;
    dateslist=data['DATA']['comicsDatesList'];
    // total=data['DATA']['totalCount']['gTotal'];
    final dateFormat = DateFormat("M/d/yyyy");
    DateTime dateTime = dateFormat.parse(data['DATA']['comicsDatesList'][0]['comicsdate']);
    DateTime dateOnly = DateTime(dateTime.year,
        dateTime.month, dateTime.day);
    selecteddate="${dateOnly.year}-${dateOnly.month}-${dateOnly.day}";
    notifyListeners();
  }


  String selecteddate="";
  changeselecteddate(String data){
    selecteddate=data;
    notifyListeners();
  }



  Map<String,dynamic>filter={};
  List<dynamic>filterlist=[];
  getfilters(Map<String,dynamic>data)
  {
    filter=data;
    filterlist=data['DATA']['weeklyReleaseFilters'];
    notifyListeners();
  }
  String total="";
  Map<String,dynamic>WeeklyReleaseData={};
  List<dynamic>dataweekly=[];
  getWeeklyReleaseData(Map<String,dynamic>data)
  {
    WeeklyReleaseData=data;
    dataweekly=data['DATA']['weeklyReleaseList'];
    total=data['DATA']['totalCount']['gTotal']??"";
    notifyListeners();
  }


  String sortby="TITLE";
  updatesortby(String data)
  {
    sortby=data;
    notifyListeners();
  }

  void updateweeklyrelease(String productId, String inCartValue, scQty,addedtowl) {
    for (var product in dataweekly) {
      if (product["pr_id"] == productId) {
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        break; // Exit the loop once the product is found and updated
      }
    }
    notifyListeners();
  }

  updateIsSubscribe(String id)
  {
    for( var product in dataweekly)
      {
        if(product['pr_id']==id)
        {
          product['issubscribe']="1";
        }
      }

    notifyListeners();
  }

  //Index
  int index = 0;
  updateindex(int data)
  {
    index=data;
    notifyListeners();
  }
}