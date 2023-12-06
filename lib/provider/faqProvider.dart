import '../export.dart';

class FAQProvider extends ChangeNotifier{

  //Shipping Information
  Map<String,dynamic>shippingInformation={};
  updateShippingInformation(Map<String,dynamic>data)
  {
    shippingInformation=data;
    notifyListeners();
  }

  //General Information
Map<String,dynamic>generalInformation={};
  List<dynamic>generalInforamtionList=[];
  updateGeneralInformation(Map<String,dynamic>data)
  {
    generalInformation=data;
    generalInforamtionList=data['DATA']['faqList'][0]['section_detail'];
    notifyListeners();
  }

  //Payment Information sECTION
Map<String,dynamic>paymentInformation={};
  updatePayementInformation(Map<String,dynamic>data)
  {
    paymentInformation=data;
    notifyListeners();
  }

  //General Order Information Section
Map<String,dynamic>orderInformationSection={};
  updateOrderInformationSection(Map<String,dynamic>data)
  {
    orderInformationSection=data;
    notifyListeners();
  }

  //PreviewInformationSection
Map<String,dynamic>previewInformationSection={};
  List<dynamic>preViewInformationSectionList=[];
  updatePreviewIInformationSection(Map<String,dynamic>data)
  {
    previewInformationSection=data;
    preViewInformationSectionList=data['DATA']['faqList'][0]['section_detail'];
    notifyListeners();
  }
//Pull List InformationSection
  Map<String,dynamic>pullListInformationSection={};
  List<dynamic>pullListInformationSectionList=[];
  updatePullListInformationSection(Map<String,dynamic>data)
  {
    pullListInformationSection=data;
    pullListInformationSectionList=data['DATA']['faqList'][0]['section_detail'];
    notifyListeners();
  }

  //BackIssues Polices Section
Map<String,dynamic>backIssuePolicesSection={};
  updateBackIssuePolicesSection(Map<String,dynamic>data)
  {
    backIssuePolicesSection=data;
    notifyListeners();
  }
}