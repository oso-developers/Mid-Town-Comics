// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class FilterProvider extends ChangeNotifier {

  bool showoutofstock = false;
  void showoutof(bool data){
    showoutofstock=data;
    notifyListeners();
  }

  bool showpreorder = false;
  void showppre(bool data){
    showpreorder=data;
    notifyListeners();
  }

  int releaseweak = -1;
  void updatereleaseweak(int data){
    releaseweak=data;
    notifyListeners();
  }

  int releaseyear = -1;
  void updatereleaseyear(int data){
    releaseyear=data;
    notifyListeners();
  }

  int series = -1;
  void updateseries(int data){
    series=data;
    notifyListeners();
  }

  int relatedtitle = -1;
  void updaterelatedtitle(int data){
    relatedtitle=data;
    notifyListeners();
  }

  int category = -1;
  void updatecategory(int data){
    category=data;
    notifyListeners();
  }

  int Discount = -1;
  void updatediscount(int data){
    Discount=data;
    notifyListeners();
  }

  int manufacturer = -1;
  void updatemanufacturer(int data){
    manufacturer=data;
    notifyListeners();
  }

  int artist = -1;
  void updateartist(int data){
    artist=data;
    notifyListeners();
  }

  int writer = -1;
  void updatewriter(int data){
    writer=data;
    notifyListeners();
  }

  int price = -1;
  void updateprice(int data){
    price=data;
    notifyListeners();
  }

  int issueno = -1;
  void updateissue(int data){
    issueno=data;
    notifyListeners();
  }

  String releaseweaks = "";
  void updatereleasewealvalue(String data){
    releaseweaks=data;
    notifyListeners();
  }

  String releaseyears = "";
  void updatereleaseyearvalue(String data){
    releaseyears=data;
    notifyListeners();
  }

  String seriess = "";
  void updateseriesissuevalue(String data){
    seriess=data;
    notifyListeners();
  }

  String related = "";
  void updaterelatedtitlevale(String data){
    related=data;
    notifyListeners();
  }

  String startdiscounts = "";
  void updatestartdiscountvalue(String data){
    startdiscounts=data;
    notifyListeners();
  }

  String enddiscounts = "";
  void updateenddiscountvalue(String data){
    enddiscounts=data;
    notifyListeners();
  }

  String manufacturers = "";
  void updatmanufacturervalue(String data){
    manufacturers=data;
    notifyListeners();
  }

  String artists = "";
  void updateartistvalue(String data){
    artists=data;
    notifyListeners();
  }

  String writers = "";
  void updatewritervalue(String data){
    writers=data;
    notifyListeners();
  }

  String startprice = "";
  void updatestartpricevalue(String data){
    startprice=data;
    notifyListeners();
  }

  String endprice = "";
  void updateendpricevalue(String data){
    endprice=data;
    notifyListeners();
  }

  String seriesfilter = "";
  void updateseriesvalue(String data){
    seriesfilter=data;
    notifyListeners();
  }

  String newtitle = "";
  void updatenewtitle(String data){
    newtitle=data;
    notifyListeners();
  }

//Weekly Rlease Work
  int department = -1;
  void updatedepartmet(int data){
    releaseweak=data;
    notifyListeners();
  }

  String departmentvalue="";
  void updatedepartentvalue(String data)
  {
    departmentvalue=data;
    notifyListeners();
  }

  String departmentname="";
  void updatedepartentnamevalue(String data)
  {
    departmentname=data;
    notifyListeners();
  }

}