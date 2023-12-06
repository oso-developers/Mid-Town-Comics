// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, depend_on_referenced_packages


import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:midtowncomics/constant/api.dart';
import 'package:midtowncomics/provider/LandingPageProvider.dart';
import 'package:midtowncomics/provider/creditcardprovider.dart';
import 'package:midtowncomics/provider/giftCardProvider.dart';
import 'package:midtowncomics/provider/instorePickUpProvider.dart';
import 'package:midtowncomics/provider/newsLetterProvider.dart';
import 'package:midtowncomics/provider/orderprovider.dart';
import 'package:midtowncomics/provider/previewOrderProvider.dart';
import 'package:midtowncomics/provider/shipingInformationProvider.dart';
import 'package:midtowncomics/provider/wishListProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/addressprovider.dart';
import '../provider/settingProvider.dart';
import '../screen/homescreen.dart';
import 'package:midtowncomics/export.dart';

class ApiRequests {
  //Get All Data First Time
  Future<Map<String, dynamic>> fetchData() async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}midtownprocess.svc/load-page-data-vr1?apiKey=ProductApiKey@8879kiop!&mtUser=AppUserMT@123!&mtPass=MTC007@8847!&sh_id=&pgn=home&rvl=1000,1002,1003&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // await Future.delayed(const Duration(seconds: 3));
      Get.off(const HomeScreen());
      final data = await response.stream.bytesToString();
      datai = jsonDecode(data);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Get all data
  Future<Map<String, dynamic>> fetchData1(String sh1id) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}midtownprocess.svc/load-page-data-vr1?apiKey=ProductApiKey@8879kiop!&mtUser=AppUserMT@123!&mtPass=MTC007@8847!&sh_id=$sh1id&pgn=home&rvl=1000,1002,1003&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // streamedDataProvider.change(false);
      final data = await response.stream.bytesToString();
      datai = jsonDecode(data);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Load Cart Data
  Future<Map<String, dynamic>> loadcartdata(shid) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}cart.svc/load-by-shopper?apiKey=&mtUser=&mtPass=&sh_id=$shid&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();

      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Save To Cart
  Future<Map<String, dynamic>> Savedata(sh_id,
      productid, quantity, BuildContext context) async {
    Map<String, dynamic> datai = {};
    final streamedDataProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    streamedDataProvider.change(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}cart.svc/save?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&pr_id=$productid&sc_qty=$quantity&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      streamedDataProvider.change(false);
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
    } else {
      debugPrint(response.reasonPhrase);
    }
    return datai;
  }

  //Product Detail Page
  Future<Map<String, dynamic>> ProductDetail(
      sh_id,
      poductid, BuildContext context) async {
    Map<String, dynamic> datai = {};
    final streamedDataProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    streamedDataProvider.changedetailind(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}product.svc/load-detail-by-parent-vr1?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&pr_id=$poductid&app_id="));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      streamedDataProvider.changedetailind(false);
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
    } else {
      debugPrint(response.reasonPhrase);
    }
    return datai;
  }

  //Login Api
  Future<Map<String, dynamic>> LoginUser(
      String email, String password,bool remember_me, BuildContext context) async {
    Map<String, dynamic> datai = {};
    final streamedDataProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    streamedDataProvider.change(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}midtownprocess.svc/load-login?apiKey=&mtUser=&mtPass=&sh_lgid=$email&sh_pass=$password&app_id="));
    http.StreamedResponse response = await request.send();
    streamedDataProvider.change(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      streamedDataProvider.updateLogingData(datache,remember_me);

      if(datai['CODE']=="1")
        {

        }
      else{
        Navigator.pop(context);
      }
      // Navigator.of(context).popUntil((route) => route.isFirst);
      // // Obtain shared preferences.
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);

    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

//Search Api
  Future<Map<String, dynamic>> SearchApi(
      String sh_id,
      String query,
      String categorie,
      String pp,
      String sb,
      outofstock,
      startdate,
      releaseyear,
      relatedttle,
      startdiscountvalue,
      enddiscountvalue,
      manufacturer,
      artist,
      writer,
      startprice,
      endprice,
      series,
      bool? search,
      seriestitle,
      BuildContext context) async {
    Map<String, dynamic> datai = {};
    final streamedDataProvider =
        Provider.of<StreamedDataProvider>(context, listen: false);
    streamedDataProvider.changesearchind(search == true ? false : true);
    streamedDataProvider.changebutton(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}search.svc/load-search?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&q=$query&pp=$pp&pj=1&cat=$categorie&scat=&mn$manufacturer=&sp=$startprice&ep$endprice=&rel=&art$artist=&wrt$writer=&os=$outofstock&sb=$sb&sd=$startdate&ed=&sdisc$startdiscountvalue=&edisc$enddiscountvalue=&di$releaseyear=&si=$series&genre=&cfr=&nt$seriestitle=&rt$relatedttle=&clr=&ustmp=&prids=&pr_condition=&app_id="));
    http.StreamedResponse response = await request.send();
    streamedDataProvider.changesearchind(false);
    streamedDataProvider.changebutton(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      streamedDataProvider.updatesearchdata(datache);
      // // Obtain shared preferences.
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
    } else {
      debugPrint(response.reasonPhrase);
    }
    return datai;
  }

  Future<Map<String, dynamic>>GetDates(BuildContext context) async {
    Map<String, dynamic> datai = {};
    final streamedDataProvider =
    Provider.of<WeeklyReleaseProvider>(context, listen: false);
    streamedDataProvider.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}comicsdate.svc/load-dates?apiKey=&mtUser=&mtPass=&app_id="));
    http.StreamedResponse response = await request.send();
    // streamedDataProvider.change(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      streamedDataProvider.getdates(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }
  Future<Map<String, dynamic>>GetProductFilters(BuildContext context,String date,sh_id) async {
    Map<String, dynamic> datai = {};
    final streamedDataProvider =
    Provider.of<WeeklyReleaseProvider>(context, listen: false);
    streamedDataProvider.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}weeklyrelease.svc/load-filters?apiKey=&mtUser=&mtPass=&wdate=$date&sh_id=$sh_id&app_id="));
    http.StreamedResponse response = await request.send();
    // streamedDataProvider.change(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      streamedDataProvider.getfilters(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }
  Future<Map<String, dynamic>>GetWeeklyReleaseData(BuildContext context,String date,cg_id,sortby,pagesize,bool button,String sha1) async {
    Map<String, dynamic> datai = {};
    final streamedDataProvider =
    Provider.of<WeeklyReleaseProvider>(context, listen: false);
    streamedDataProvider.updateloadmore(button==true?true:false);
    streamedDataProvider.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}weeklyrelease.svc/load-body?apiKey=&mtUser=&mtPass=&cg_id=$cg_id&wdate=$date&sh_id=$sha1&sortby=$sortby&currentPage=1&pageSize=$pagesize&app_id="));
    http.StreamedResponse response = await request.send();
    streamedDataProvider.changeindicator(false);
   streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      streamedDataProvider.getWeeklyReleaseData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  //Get Account Setting
  Future<Map<String, dynamic>>GetAccountSettings(String sha1,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final accountsettinprovider =
    Provider.of<AccountSettingProvider>(context, listen: false);
    // streamedDataProvider.updateloadmore(button==true?true:false);
    // streamedDataProvider.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}accountsettings.svc/load-my-account-settings?apiKey=&mtUser=&mtPass=&sh_id=$sha1&app_id="));
    http.StreamedResponse response = await request.send();
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      accountsettinprovider.getAccountSetting(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>GetOrder(String sha1,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final accountsettinprovider =
    Provider.of<OrderProvider>(context, listen: false);
    // streamedDataProvider.updateloadmore(button==true?true:false);
    // streamedDataProvider.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}orders.svc/load-by-shopper?apiKey=&mtUser=&mtPass=&sh_id=$sha1&app_id="));
    http.StreamedResponse response = await request.send();
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      accountsettinprovider.getOrder(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>LoadCreditCard(String sha1,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final credit =
    Provider.of<CreditCardProvider>(context, listen: false);
    credit.searchlist(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}cc.svc/load-by-shopper?apiKey=&mtUser=&mtPass=&sh_id=$sha1&app_id="));
    http.StreamedResponse response = await request.send();
    credit.searchlist(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      credit.LoadCreditCard(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>LoadAdress(String sha1,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}address.svc/load-by-shopper?apiKey=&mtUser=&mtPass=&sh_id=$sha1&sa_type=&app_id="));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      // print(datache);
      address.LoadAddressData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>SaveProfileData(String sha1,fname,lname,dob,email,cemail,password,cpassword,beemail,meemail,teemail,oldemail,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}accountsettings.svc/save-profile?apiKey=&mtUser=&mtPass=&sh_id=$sha1&sh_fname=$fname&sh_lname=$lname&sh_dob=$dob&email=$email&cemail=$cemail&password=$password&cpassword=$cpassword&bemail=$beemail&memail=$meemail&temail=$teemail&oemail=$oldemail&opt=set&app_id="));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      if(datache['CODE']=="0")
        {
          await GetAccountSettings(sha1,context);
        }
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>SaveCardData(String sha1,fname,lname,pm_id,pm_cardtype,pm_cardnum,pm_expmnth,pm_expyear,BuildContext context) async {
    Map<String, dynamic> datai = {};
    // String lastTwoDigits =  pm_expyear.substring(pm_expyear.length - 2);
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
          "${Api().baseURL}cc.svc/save?apiKey=&mtUser=&mtPass=&sh_id=$sha1&pm_id=$pm_id&first_name=$fname&last_name=$lname&pm_cardtype=$pm_cardtype&pm_cardnum=$pm_cardnum&pm_expmnth=$pm_expmnth&pm_expyear=${ pm_expyear.substring(pm_expyear.length - 2)}&app_id="
        ));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      if(datache['CODE']=="0")
        {
          Navigator.pop(context);
        }
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>SaveAddress(String sha1,fname,lname,sa_id,sa_type,sa_desc,sa_cmpny,sa_addr1,sa_addr2,sa_city,sa_state,sa_zip ,sa_cntry,sa_verify,phone,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}address.svc/save?apiKey=&mtUser=&mtPass=&sh_id=$sha1&sa_id=$sa_id&sa_type=$sa_type&sa_desc=$sa_desc&sa_fname=$fname&sa_lname=$lname&sa_cmpny=$sa_cmpny&sa_addr1=$sa_addr1&sa_addr2=&sa_city=$sa_city&sa_state=$sa_state&sa_zip=$sa_zip&sa_cntry=$sa_cntry&sa_phone=$phone&sa_verify=&sa_di=&app_id="));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      if(datache['CODE']=="0")
        {
          Navigator.pop(context);
          ApiRequests().LoadAdress(sha1, context);
        }
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>>ProceedCard(String sha1,pm_id,action,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}cc.svc/process-cc?apiKey=&mtUser=&mtPass=&sh_id=$sha1&pm_id=$pm_id&action=$action&app_id="));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      await LoadCreditCard(sha1, context);
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>>ProceedAddress(String sha1,sa_id,sa_type,action,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}address.svc/process-address?apiKey=&mtUser=&mtPass=&sh_id=$sha1&sa_id=$sa_id&sa_type=$sa_type&action=$action&app_id="));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      await LoadAdress(sha1, context);
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>SavePullListSetting(String sha1,sub_type,ss_billcycle,sm_id,sa_id,ba_id,pm_id,ss_location,sub_status,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}pulllist.svc/confirm-save?apiKey=&mtUser=&mtPass=&sh_id=$sha1&sub_type=$sub_type&ss_billcycle=$ss_billcycle&sm_id=$sm_id&sa_id=$sa_id&ba_id=$ba_id&pm_id=$pm_id&ss_location=$ss_location&sub_status=$sub_status&app_id={app_id}"));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>SavePreviewSetting(String sh_id,pm_id,sa_id_bill,ss_bill_cycle,sa_id_ship,sm_id,BuildContext context) async {

    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}accountsettings.svc/save-previews-setting?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&pm_id=$pm_id&sa_id_bill=$sa_id_bill&ss_bill_cycle=$ss_bill_cycle&sa_id_ship=$sa_id_ship&sm_id=$sm_id&app=_id="));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>RegisterUser(String sh_lgid,sh_lgid_confirm,sa_desc,sh_fname,sh_lname,sh_dob,sa_cmpny,sa_addr1,sa_addr2,sa_city,sa_zip,sa_phone1,sh_pass,sh_pass_confirm,sa_cntry,sa_state,BuildContext context) async {

    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}midtownprocess.svc/register-shopper?apiKey=&mtUser=&mtPass=&sh_lgid=$sh_lgid&sh_lgid_confirm=$sh_lgid_confirm&sa_desc=$sa_desc&sh_fname=$sh_fname&sh_lname=$sh_lname&sh_dob=$sh_dob&sa_cmpny=$sa_cmpny&sa_addr1=$sa_addr1&sa_addr2=$sa_addr2&sa_city=$sa_city&sa_zip=$sa_zip&sa_phone1=$sa_phone1&sh_pass=$sh_pass&sh_pass_confirm=$sh_pass_confirm&sa_cntry=$sa_cntry&sa_state=$sa_state&app_id="));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
      Navigator.pop(context);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }
  //Upcoming pULL lIST
  Future<Map<String, dynamic>>upcomingPullList(String sh_id,pr_id,fetch_type,su_id,susp,BuildContext context) async {

    Map<String, dynamic> datai = {};
    final address =
    Provider.of<AddressProvider>(context, listen: false);
    address.changeindicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}accountsettings.svc/manage-upcoming-title?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&pr_id=$pr_id&fetch_type=$fetch_type&su_id=$su_id&susp=$susp&app_id="));
    http.StreamedResponse response = await request.send();
    address.changeindicator(false);
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      ApiRequests().GetAccountSettings(sh_id, context);
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      Fluttertoast.showToast(
          msg: datache['DESCRIPTION'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Get All Countries
  Future<Map<String, dynamic>>GetCountries(BuildContext context) async {

    Map<String, dynamic> datai = {};
    final provider =
    Provider.of<StreamedDataProvider>(context, listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}country.svc/load-all?apiKey=&mtUser=&mtPass=&app_id="));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateCountriesData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Get State
  Future<Map<String, dynamic>>GetState(BuildContext context) async {

    Map<String, dynamic> datai = {};
    final provider =
    Provider.of<StreamedDataProvider>(context, listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}state.svc/load-by-country?apiKey=&mtUser=&mtPass=&sa_cntry=840&app_id="));
    http.StreamedResponse response = await request.send();
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateStateData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>>SavePullList(String sh_id,su_id,sd_qty,isRemove,pr_id,BuildContext context) async {
    Map<String, dynamic> datai = {};
    final provider =
    Provider.of<StreamedDataProvider>(context, listen: false);
    final provider2=
    Provider.of<WeeklyReleaseProvider>(context, listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            "${Api().baseURL}pulllist.svc/save?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&su_id=$su_id&sd_qty=$sd_qty&isRemove=$isRemove&app_id="));
    http.StreamedResponse response = await request.send();
    // streamedDataProvider.changeindicator(false);
    // streamedDataProvider.updateloadmore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      Map<String,dynamic>pullListData=await loadPullList(sh_id);
      provider.updatePullListData(pullListData);
      if(provider.detail.isNotEmpty)
        {
         provider.updateDetailIsSubscriber();
        }
      if(provider2.dataweekly.isNotEmpty)
        {
          provider2.updateIsSubscribe(pr_id);
        }
      if(provider.returnproduct.isNotEmpty)
        {
          provider.updateIsSubscribe(pr_id);
        }
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>> loadPullList(shid) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}pulllist.svc/load-quick-list?apiKey=&mtUser=&mtPass=&sh_id=$shid&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();

      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Get Gift Card Data
  Future<Map<String, dynamic>> getGiftCardData(sh_id) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}gc.svc/load-by-shopper?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final provider=Provider.of<GiftCardProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
      final data = await response.stream.bytesToString();

      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateGiftCardData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>> claimGiftCard(sh_id,gc_num,gc_pin) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}gc.svc/assign-to-shopper?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&gc_num=$gc_num&gc_pin=$gc_pin&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      Fluttertoast.showToast(
        msg: datache['DESCRIPTION'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        fontSize: 16.0,
        backgroundColor: Colors.white,
      );
     getGiftCardData(sh_id);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Sve to Wish List
  Future<Map<String, dynamic>> saveToWishList(sh_id,pr_parentid) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}wishlist.svc/save?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&pr_parentid=$pr_parentid&qty=1&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      Fluttertoast.showToast(
        msg: datache['DESCRIPTION'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Load Sort By Option of Wish List
  Future<Map<String, dynamic>> loadSortByOption(sh_id,) async {
    Map<String, dynamic> datai = {};
    final provider=Provider.of<WishListProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}wishlist.svc/load-sorting-options?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateLoadSortByOption(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Load Wish List Category
  Future<Map<String, dynamic>> loadCategory(sh_id,) async {
    Map<String, dynamic> datai = {};
    final provider=Provider.of<WishListProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}/wishlist.svc/load-category?apiKey=&mtUser=&mtPass=&sh_id=76367&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateLoadCategory(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Get User Wish List Data
  Future<Map<String, dynamic>> loadWishListData(sh_id,cg_id,q,order_by,rpp,pageno,) async {
    Map<String, dynamic> datai = {};
    final provider=Provider.of<WishListProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}wishlist.svc/load-by-shopper?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&q=&cg_id=$cg_id&order_by=$order_by&rpp=$rpp&pageno=$pageno&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateUserWishListData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>> deleteWishList(sh_id,pr_parentid) async {
    Map<String, dynamic> datai = {};
    final provider=Provider.of<WishListProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}wishlist.svc/delete-by-parent?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&pr_parentid=$pr_parentid&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      loadWishListData(sh_id,provider.sortByValue,provider.searchQuery,provider.filterByValue,"10", "1");
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }


  Future<Map<String, dynamic>> loadNewsLetterList(sh_id,email) async {
    Map<String, dynamic> datai = {};
    final provider=Provider.of<NewsLetterProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}midtownnewsletter.svc/load-all?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&sh_lgid=$email&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateNewsLetterList(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>> subscribeToNewsLetter(sh_id,sh_lgid,sh_lgid_confirm,sh_fname,sh_lname,List<dynamic>nllist) async {
    Map<String, dynamic> datai = {};
    final provider=Provider.of<NewsLetterProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    provider.updateIndicator(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}midtownnewsletter.svc/subscribe-nl?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&sh_lgid=$sh_lgid&sh_lgid_confirm=$sh_lgid_confirm&sh_fname=$sh_fname&sh_lname=$sh_lname&nllist=$nllist&app_id='));
    http.StreamedResponse response = await request.send();
    provider.updateIndicator(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      Fluttertoast.showToast(
        msg: datache['DESCRIPTION'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        fontSize: 16.0,
        backgroundColor: Colors.white,
      );
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>> loadShippingInformation(sh_id,) async {
    Map<String, dynamic> datai = {};
    final provider=Provider.of<ShippingInformationProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}midtownprocess.svc/load-shipping-info?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateShippingInformation(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>> loadInStorePickUpInfo(sh_id,) async {
    Map<String, dynamic> datai = {};
    final provider=Provider.of<InStorePickUpProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}midtownprocess.svc/load-instore-pickup?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateInStorePickUpData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>> faqApi(sh_id,section_name) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}midtownprocess.svc/load-faq?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&section_name=$section_name&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //Landing Page
  Future<Map<String, dynamic>>landingPage(sh_id,page_name) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}landingpage.svc/load-by-name?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&page_name=$page_name&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final provider=Provider.of<LandingPageProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updateLandingPageData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  //PreviewPreCode
  Future<Map<String, dynamic>>previewPreCode() async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}previews.svc/load-codes?apiKey=&mtUser=&mtPass=&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final provider=Provider.of<PreviewOrderProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updatePreviewCode(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>>previewFilter(String sh_id,pre_code) async {
    Map<String, dynamic> datai = {};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}previews.svc/load-filters?apiKey=&mtUser=&mtPass=&pre_code=$pre_code&sh_id=$sh_id&app_id='));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final provider=Provider.of<PreviewOrderProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updatePreviewFilter(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }

  Future<Map<String, dynamic>>getPreviewItem(String sh_id,pre_cat,pre_code,pre_sw,sortby,currentPage,pageSize,bool loadMore) async {
    final provider=Provider.of<PreviewOrderProvider>(NavigationService.navigatorKey.currentContext!,listen: false);
    Map<String, dynamic> datai = {};
    if(loadMore==true)
      {
        provider.updateLoadMore(true);
      }
    else{
      provider.updateChangeIndicator(true);
    }
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Api().baseURL}previews.svc/load-body?apiKey=&mtUser=&mtPass=&sh_id=$sh_id&pre_cat=$pre_cat&pre_code=$pre_code&pre_sw=$pre_sw&sortby=$sortby&currentPage=$currentPage&pageSize=$pageSize&app_id='));
    http.StreamedResponse response = await request.send();
    provider.updateChangeIndicator(false);
    provider.updateLoadMore(false);
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      Map<String, dynamic> datache = jsonDecode(data);
      datai = datache;
      provider.updatePreviewData(datache);
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
    return datai;
  }



}
