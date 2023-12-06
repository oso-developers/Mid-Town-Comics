import 'package:midtowncomics/export.dart';
import 'package:midtowncomics/widget/addNewAdress.dart';
import 'package:midtowncomics/widget/editAddress.dart';
import 'package:midtowncomics/widget/searchList.dart';

import '../provider/addressprovider.dart';

class AddressBookScreen extends StatefulWidget {
  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ApiRequests().GetCountries(context);
    ApiRequests().GetState(context);
    final streamedDataProvider =
    Provider.of<StreamedDataProvider>(context,
        listen: false);
    ApiRequests().LoadAdress(streamedDataProvider.loginuserdata['sh_id'], context);
    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size(size.width*1,allsize*0.11),
          child: Header_Widget(
            ontap: () => scaffoldKey.currentState!.openDrawer(),
            searchcontroller:searchcontroller,
          ),),
        key: scaffoldKey,
        drawer: const Custom_drawer(),
        body: SingleChildScrollView(child:
            Consumer<AddressProvider>(builder: (context,address, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchList(searchcontroller: searchcontroller),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Address Book",
                    style: TextStyle(
                        fontFamily: 'oswald_bold',
                        fontSize: allsize * 0.02,
                        fontWeight: FontWeight.bold),
                  )),
              address.address.isEmpty?const Center(child: CircularProgressIndicator(),):
              ListView.builder(
              itemCount:address.address.length
              ,shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                return  ListViewWidgetAddress(allsize: allsize, size: size,index:index);

              }
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xff006ccf), width: 3)),
                    child: Center(
                      child: Text(
                        "ADD NEW ADDRESS",
                        style: TextStyle(
                            color: const Color(0xff006ccf),
                            fontSize: allsize * 0.015,
                            fontFamily: 'opensans_semibold',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AddNewAddress();
                    },
                  );
                },
              ),
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
        })),
      ),
    );
  }
}

class ListViewWidgetAddress extends StatefulWidget {
  const ListViewWidgetAddress({
    super.key,
    required this.allsize,
    required this.size,
    required this.index
  });

  final double allsize;
  final Size size;
  final index;

  @override
  State<ListViewWidgetAddress> createState() => _ListViewWidgetAddressState();
}

class _ListViewWidgetAddressState extends State<ListViewWidgetAddress> {
  bool defaultshipping=false;
  bool defaultbilling=false;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return  Consumer<AddressProvider>(builder: (context,address, child) {
      defaultbilling=address.address[widget.index]['sa_type']=="B"?true:false;
      defaultshipping=address.address[widget.index]['sa_type']=="S"?true:false;
      return Padding(
        padding:  EdgeInsets.symmetric(vertical: size.height*0.005,horizontal: size.width*0.01),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      address.address[widget.index]['sa_desc']??" ",
                      style: TextStyle(
                          color: const Color(0xff006ccf),
                          fontWeight: FontWeight.bold,
                          fontSize: widget.allsize * 0.0125),
                    ),
                    IconButton(
                        onPressed: () {
                          final streamedDataProvider =
                          Provider.of<StreamedDataProvider>(context,
                              listen: false);
                          ApiRequests().ProceedAddress(streamedDataProvider.loginuserdata['sh_id'],address.address[widget.index]['sa_id'],"","dl", context);
                        },
                        icon: Icon(
                          Icons.delete,
                          size: widget.allsize * 0.02,
                        ))
                  ],
                ),
                Text(
                  address.address[widget.index]['sa_fname']+" "+address.address[widget.index]['sa_lname'],
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: widget.allsize * 0.0125),
                ),
                Text(
                  address.address[widget.index]['sa_addr1']+" "+address.address[widget.index]['sa_addr2'],
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: widget.allsize * 0.0125),
                ),
                Text(
                  address.address[widget.index]['sa_cmpny']+" "+address.address[widget.index]['sa_city']+","+address.address[widget.index]['sa_state']
                      +" "+address.address[widget.index]['sa_zip'],
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: widget.allsize * 0.0125),
                ),
                Text(
                  address.address[widget.index]['ct_name'],
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: widget.allsize * 0.0125),
                ),
                SizedBox(
                  height: widget.size.height * 0.005,
                ),
                InkWell(
                  child: Container(
                    height: widget.size.height * 0.06,
                    width: double.infinity,
                    color: const Color(0xff006ccf),
                    child: Center(
                      child: Text(
                        "EDIT ADDRESS",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'opensans_semibold',
                            fontSize: widget.allsize * 0.014,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditAddress(data:address.address[widget.index], );
                      },
                    );
                  },
                ),
                SizedBox(height: size.height*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "DEFAULT SHIPPING",
                      style: TextStyle(
                          color: const Color(0xff006ccf),
                          fontSize: widget.allsize * 0.01),
                    ),
                    Transform.scale(
                      scale: widget.allsize * 0.0006,
                      child: Switch(
                          activeColor: const Color(0xff006ccf),
                          value: defaultshipping,
                          onChanged: (value) {
                            final streamedDataProvider =
                            Provider.of<StreamedDataProvider>(context,
                                listen: false);
                            setState(() {
                              defaultshipping = value;
                              ApiRequests().ProceedAddress(streamedDataProvider.loginuserdata['sh_id'],address.address[widget.index]['sa_id'],"S","df", context);
                            });
                          }),
                    ),
                    SizedBox(
                      height: widget.size.height * 0.03,
                    ),
                    Text(
                      "DEFAULT BILLING",
                      style: TextStyle(
                          color: const Color(0xff006ccf),
                          fontSize: widget.allsize * 0.01),
                    ),
                    Transform.scale(
                      scale: widget.allsize * 0.0006,
                      child: Switch(
                          activeColor: const Color(0xff006ccf),
                          value: defaultbilling,
                          onChanged: (value) {
                            final streamedDataProvider =
                            Provider.of<StreamedDataProvider>(context,
                                listen: false);
                            setState(() {
                              defaultbilling = value;
                              ApiRequests().ProceedAddress(streamedDataProvider.loginuserdata['sh_id'],address.address[widget.index]['sa_id'],"B","df", context);
                            });
                          }),
                    )
                  ],
                ),
                SizedBox(height: size.height*0.01,)
              ],
            ),
          ),
        ),
      );
    });
  }
}
