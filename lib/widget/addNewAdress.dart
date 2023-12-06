
import 'package:midtowncomics/export.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  TextEditingController addressName=TextEditingController();
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController companyName=TextEditingController();
  TextEditingController addressOne=TextEditingController();
  TextEditingController addressTwo=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController postalCode=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController deliveryInstruction=TextEditingController();
  String countryCode="";
  List<String>country=['United State'];
  List<String>state=[];
  String countryvalue='--Select Country';
  String stateId="";
  String statevalue='--Select State--';
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var allsize =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    return
      Consumer<StreamedDataProvider>(
          builder: (context, provider, child) {
            return Dialog(
                insetPadding:EdgeInsets.symmetric(horizontal:allsize*0.012,vertical: allsize*0.01),
                child: SingleChildScrollView(
                  child: SizedBox(
                    // height: size.height*1,
                    child: Padding(
                      padding:EdgeInsets.all(allsize*0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Manage Address",style: TextStyle(fontSize:allsize*0.023,fontWeight: FontWeight.w600),),
                          SizedBox(height: size.height*0.015,),
                          TextFormFieldWidget(
                            title: "Address Name",
                            textEditingController: addressName,
                            optional: false, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title: "First Name",
                            textEditingController: firstName,
                            optional: false, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title: "LastNamE",
                            textEditingController: lastName,
                            optional: false, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title: "Care of / Company Name",
                            textEditingController: companyName,
                            optional: false, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title: "Address 1",
                            textEditingController: addressOne,
                            optional: false, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title:"Address 2",
                            textEditingController: addressTwo,
                            optional: true, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title:"City",
                            textEditingController:city,
                            optional: false, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title:"ZIP / Postal Code",
                            textEditingController:postalCode,
                            optional: false, readOnly: false,
                          ),
                          TextFormFieldWidget(
                            title:"Phone #",
                            textEditingController:phoneNumber,
                            optional: false, readOnly: false,
                          ),
                          Row(
                            children: [
                              Text("*",style:  TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: allsize*0.011),),
                              Flexible(child: Text("Country",style:  TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: allsize*0.012),)),
                            ],
                          ),
                          SizedBox(height: size.height*0.01,),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext
                                context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        allsize *
                                            0.016,
                                        vertical:
                                        allsize *
                                            0.04),
                                    child:
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize:
                                        MainAxisSize
                                            .min,
                                        children: provider.countries
                                            .map<Widget>(
                                                (dynamic
                                            item) {
                                              return ListTile(
                                                  title: Text(
                                                      item['ct_name']),
                                                  onTap:
                                                      () async {
                                                    setState(() {
                                                      countryvalue=item['ct_name'];
                                                      countryCode=item['ct_id'];
                                                      if(item['ct_id']=="840")
                                                        {
                                                          statevalue="--Select State--";
                                                        }
                                                      else{
                                                        state.clear();
                                                        state.add('--International--');
                                                        statevalue="--International--";
                                                      }
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height:
                              size.height * 0.045,
                              width: size.width*1,
                              decoration: BoxDecoration(
                                  color:
                                  Colors.grey[300]),
                              padding:
                              const EdgeInsets.all(
                                  8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    countryvalue,
                                    style: TextStyle(
                                        fontSize:
                                        allsize *
                                            0.012),
                                  ),
                                  Icon(
                                    Icons
                                        .arrow_drop_down,
                                    size:
                                    allsize * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: size.height*0.01,),
                          Row(
                            children: [
                              Text("*",style:  TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: allsize*0.011),),
                              Flexible(child: Text("State",style:  TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: allsize*0.012),)),
                            ],
                          ),
                          SizedBox(height: size.height*0.01,),
                          countryCode=="840"?
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext
                                context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        allsize *
                                            0.016,
                                        vertical:
                                        allsize *
                                            0.04),
                                    child:
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize:
                                        MainAxisSize
                                            .min,
                                        children: provider.state
                                            .map<Widget>(
                                                (dynamic
                                            item) {
                                              return ListTile(
                                                  title: Text(
                                                      item['st_name']),
                                                  onTap:
                                                      () async {
                                                    setState(() {
                                                      stateId=item['st_id'];
                                                      statevalue=item['st_name'];
                                                    });
                                                    Navigator.pop(context);

                                                  }
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height:
                              size.height * 0.045,
                              width: size.width*1,
                              decoration: BoxDecoration(
                                  color:
                                  Colors.grey[300]),
                              padding:
                              const EdgeInsets.all(
                                  8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    statevalue,
                                    style: TextStyle(
                                        fontSize:
                                        allsize *
                                            0.012),
                                  ),
                                  Icon(
                                    Icons
                                        .arrow_drop_down,
                                    size:
                                    allsize * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ):
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext
                                context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        allsize *
                                            0.016,
                                        vertical:
                                        allsize *
                                            0.04),
                                    child:
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize:
                                        MainAxisSize
                                            .min,
                                        children: state
                                            .map<Widget>(
                                                (String
                                            item) {
                                              return ListTile(
                                                  title: Text(
                                                      item),
                                                  onTap:
                                                      () async {
                                                    setState(() {
                                                      statevalue=item;
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height:
                              size.height * 0.045,
                              width: size.width*1,
                              decoration: BoxDecoration(
                                  color:
                                  Colors.grey[300]),
                              padding:
                              const EdgeInsets.all(
                                  8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    statevalue,
                                    style: TextStyle(
                                        fontSize:
                                        allsize *
                                            0.012),
                                  ),
                                  Icon(
                                    Icons
                                        .arrow_drop_down,
                                    size:
                                    allsize * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: size.height*0.01,),
                          TextFormFieldWidget(
                            title:"Delivery Instruction",
                            textEditingController:deliveryInstruction,
                            optional: false, readOnly: false,
                          ),
                          SizedBox(height: size.height*0.015,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("CANCEL",style: TextStyle(color: Colors.red,fontSize: allsize*0.012,fontWeight: FontWeight.bold),)),
                              SizedBox(width: size.width*0.06,),
                              TextButton(onPressed: (){
                                final streamedDataProvider =
                                Provider.of<StreamedDataProvider>(context,
                                    listen: false);
                                ApiRequests().SaveAddress(streamedDataProvider.loginuserdata['sh_id'],firstName.text,lastName.text,"0"," ",addressName.text,companyName.text,addressOne.text,addressTwo,city.text,stateId,postalCode.text,countryCode,"", phoneNumber.text, context);
                              }, child: Text("SAVE",style: TextStyle(color: const Color(0xff006ccf,),fontSize: allsize*0.012,fontWeight: FontWeight.bold),)),
                            ],
                          ),
                          SizedBox(height: size.height*0.015,),
                        ],
                      ),
                    ),
                  ),
                ));
          });

  }
}
