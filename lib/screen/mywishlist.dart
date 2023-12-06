import 'package:flutter/cupertino.dart';
import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/provider/wishListProvider.dart';
import 'package:midtowncomics/widget/wishListList.dart';

class MyWishListScreen extends StatefulWidget {
  const MyWishListScreen({super.key});

  @override
  State<MyWishListScreen> createState() => _MyWishListScreenState();
}

class _MyWishListScreenState extends State<MyWishListScreen> {
  TextEditingController mainSearchEditingController=TextEditingController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    searchController.addListener(() {
      final provider=Provider.of<WishListProvider>(context,listen: false);
      provider.updateSearchQuery(searchController.text);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final streamedDataProvider =
    Provider.of<StreamedDataProvider>(context,
        listen: false);
    final wProvider=Provider.of<WishListProvider>(context,listen: false);
    ApiRequests().loadWishListData(streamedDataProvider.loginuserdata['sh_id'],wProvider.sortByValue,wProvider.searchQuery,wProvider.filterByValue,"10","1" );
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size(size.width*1,allsize*0.11),
          child: Header_Widget(
            ontap: () => scaffoldKey.currentState!.openDrawer(),
            searchcontroller:searchController,
          ),),
        key: scaffoldKey,
        drawer: const Custom_drawer(),
        body: SingleChildScrollView(
            child:
            Consumer<WishListProvider>(
                builder: (context, provider, child) {
                  return
                  provider.loadSortByOptionList.isEmpty?
                      const Center(child: CircularProgressIndicator(),):
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height*0.065,
                        color: Colors.grey[200],
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: const Color(0xffd09102),
                                size: allsize * 0.02,
                              ),
                              Text(
                                "My Wish List",
                                style: TextStyle(
                                    fontFamily: 'oswald_bold',
                                    fontSize: allsize * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height*0.01,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          height: size.height * 0.06,
                          child: TextFormField(
                            controller: searchController,
                            onEditingComplete: (){
                              ApiRequests().loadWishListData(streamedDataProvider.loginuserdata['sh_id'],wProvider.sortByValue,wProvider.searchQuery,wProvider.filterByValue,"10","1" );
                            },
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.grey[300],
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: allsize * 0.02,
                                ),
                                suffix: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: IconButton(
                                    onPressed: () {
                                      provider.updateSearchQuery("");
                                      searchController.clear();
                                      FocusScope.of(context).unfocus();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.clear,
                                      size: allsize * 0.02,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Filter By:",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: allsize * 0.012),
                            ),
                            InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                    horizontal: allsize * 0.016,
                                    vertical: allsize * 0.04,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: provider.loadSortByOptionList.map<Widget>((dynamic item) {
                                        return ListTile(
                                          title: Text(item['sortOptionName']),
                                          onTap: () async {
                                            provider.updateFilterBy(item['sortOptionName'], item['sortOptionValue']);
                                            ApiRequests().loadWishListData(streamedDataProvider.loginuserdata['sh_id'],wProvider.sortByValue,wProvider.searchQuery,wProvider.filterByValue,"10","1" );
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: size.width * 0.3,
                            color: Colors.grey[200],
                            height: size.height * 0.035,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      provider.filterBy,style: TextStyle(fontSize: allsize*0.013),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                            Text("Sort By:",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: allsize * 0.012)),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.symmetric(
                                        horizontal: allsize * 0.016,
                                        vertical: allsize * 0.04,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: provider.loadCategoryList.map<Widget>((dynamic item) {
                                            return ListTile(
                                              title: Text(item['cg_name']),
                                              onTap: () async {
                                                provider.updateSortBy(item['cg_name'], item['cg_id']);
                                                ApiRequests().loadWishListData(streamedDataProvider.loginuserdata['sh_id'],wProvider.sortByValue,wProvider.searchQuery,wProvider.filterByValue,"10","1" );
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: size.width * 0.3,
                                color: Colors.grey[200],
                                height: size.height * 0.035,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          provider.sortBy,style: TextStyle(fontSize: allsize*0.013),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_drop_down)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          itemCount: provider.userWishListDataList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            return  WishListList(index: index);
                          }),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const SubcribeWidget(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Footer(),
                      SizedBox(
                        height: size.height * 0.015,
                      )
                    ],
                  );
                }),

        ),
      ),
    );
  }
}
