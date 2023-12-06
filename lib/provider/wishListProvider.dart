
import '../export.dart';

class WishListProvider extends ChangeNotifier{



//Sort by Option
  Map<String,dynamic>loadSortByOption={};
  List<dynamic>loadSortByOptionList=[];
  void updateLoadSortByOption(Map<String,dynamic>data)
  {
    loadSortByOption=data;
    loadSortByOptionList=data['DATA']['sortingOptionsList'];
    updateFilterBy(data['DATA']['sortingOptionsList'][0]['sortOptionName'],data['DATA']['sortingOptionsList'][0]['sortOptionValue']);
    notifyListeners();
  }

  //Load Category

  Map<String,dynamic>loadCategory={};
  List<dynamic>loadCategoryList=[];
  void updateLoadCategory(Map<String,dynamic>data)
  {
    loadCategory=data;
    loadCategoryList=data['DATA']['categoryList'];
    updateSortBy(data['DATA']['categoryList'][0]['cg_name'],data['DATA']['categoryList'][0]['cg_id']);
    notifyListeners();
  }

  //Get User Wish List Data
  Map<String,dynamic>userWishListData={};
  List<dynamic>userWishListDataList=[];
  void updateUserWishListData(Map<String,dynamic>data)
  {
    userWishListData=data;
    if(data['DESCRIPTION']=="data not found")
      {
        userWishListDataList=[];
      }
    else
      {
        if(data['DATA']['wishList']==null)
          {
            userWishListDataList=[];
          }
        else{
          userWishListDataList=data['DATA']['wishList'];
        }
      }
    notifyListeners();
  }
  void updateUserWishListDataList(List<dynamic>data)
  {
    userWishListDataList=data;
    notifyListeners();
  }


  String filterBy="All";
  updateFilterBy(String data,value)
  {
    filterBy=data;
    updateFilterByValue(value);
    notifyListeners();
  }


  String sortBy="Most Recent";
  updateSortBy(String data,value)
  {
    sortBy=data;
    updateSortByValue(value);
    notifyListeners();
  }

  String filterByValue="0";
  updateFilterByValue(String data)
  {
    filterByValue=data;
    notifyListeners();
  }


  String sortByValue="reldt";
  updateSortByValue(String data)
  {
    sortByValue=data;
    notifyListeners();
  }

  String searchQuery="";
  updateSearchQuery(String data)
  {
    searchQuery=data;
    notifyListeners();
  }
}