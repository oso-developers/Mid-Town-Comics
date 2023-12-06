import '../export.dart';

class PreviewOrderProvider extends ChangeNotifier {

  bool changeindicator=false;
  updateChangeIndicator(bool data)
  {
    changeindicator=data;
    notifyListeners();
  }


  bool loadmore=false;
  updateLoadMore(bool data){
    loadmore=data;
    notifyListeners();
  }

  //Load Preview Code
  Map<String,dynamic>previewCode={};
  List<dynamic>previewCodeList=[];
  updatePreviewCode(Map<String,dynamic>data)
  {
    previewCode=data;
    previewCodeList=data['DATA']['preCodeList'];
    updatePreviewCodeComplete(FunctionClass().convertToFullMonth(data['DATA']['preCodeList'][0]['pre_code']));
    updatePreviewCodeValue(data['DATA']['preCodeList'][0]['pre_code']);
    notifyListeners();
  }
  
  String previewCodeComplete="";
  updatePreviewCodeComplete(String data)
  {
    previewCodeComplete=data;
    notifyListeners();
  }
  
  
  String previewCodeValue="";
  updatePreviewCodeValue(String data)
  {
    previewCodeValue=data;
    notifyListeners();
  }


  //Load Preview Filter
Map<String,dynamic>previewFilter={};
  List<dynamic>previewFilterList=[];
  updatePreviewFilter(Map<String,dynamic>data)
  {
    previewFilter=data;
    previewFilterList=data['DATA']['previewsFilters'];
    notifyListeners();
  }

  String filterData="";
  updateFilterData(String data)
  {
    filterData=data;
    notifyListeners();
  }


  //Preview Data
Map<String,dynamic>previewData={};
  List<dynamic>previewDataList=[];
  Map<String,dynamic>previewDataData={};
  updatePreviewData(Map<String,dynamic>data)
  {
    previewData=data;
    print(data);
    if(data['DESCRIPTION']=="data not found")
      {
        print("Data Not Found");
        previewDataList=[];
      }
    else{
      previewDataList=data['DATA']['previewsList'];
    }
    notifyListeners();
  }


  //String sort BY
String sortByGroupValue="tit";
  updateSortByGroupValue(String data)
  {
    sortByGroupValue=data;
    notifyListeners();
  }


  //Search Value
String searchValue="";
  updateSearchValue(String data){
    searchValue=data;
    notifyListeners();
  }


  //Manage Filter CheckBox
  int selectedIndexChanged = -1;
  updateSelectedIndex(int value)
  {
    selectedIndexChanged=value;
    notifyListeners();
  }

  //Update Filter Name
String filterName="";
  updateFilterName(String data)
  {
    filterName=data;
    notifyListeners();
  }


  //Update Preview List
  void updatePreViewList(String productId, String inCartValue, scQty,addedtowl) {
    for (var product in previewDataList) {
      if (product["pr_id"] == productId) {
        product["in_cart"] = inCartValue;
        product['sc_qty'] = scQty;
        product['addedtowl']=addedtowl;
        break; // Exit the loop once the product is found and updated
      }
    }
    notifyListeners();
  }
}