// ignore_for_file: non_constant_identifier_names
import 'package:midtowncomics/export.dart';
import 'package:intl/intl.dart';
import 'package:midtowncomics/widget/searchList.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController r_email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController companyname = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController c_password = TextEditingController();
  TextEditingController searchController=TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _showDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) => {
      setState(() {
        // _date = value!;
        dob.text = DateFormat('MM/dd/yyyy').format(value!);
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var allsize=MediaQuery.of(context).size.height+MediaQuery.of(context).size.width;
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
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SearchList(searchcontroller:searchController),
                 Text(
                  "Join Us At Midtown",
                  style:
                      TextStyle(fontSize:allsize*0.02, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextFormFieldWidget(
                  title: "Email Address",
                  textEditingController: email,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "Reenter Email Address",
                  textEditingController: r_email,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "Address Name",
                  textEditingController: address,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "First Name",
                  textEditingController: firstname,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "Last Name",
                  textEditingController: lastname,
                  optional: false, readOnly: false,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width*0.77,
                      child: TextFormFieldWidget(
                        title: "Date of Birth",
                        textEditingController: dob,
                        optional: false, readOnly: true,
                      ),
                    ),
                    IconButton(onPressed:_showDatePicker, icon:Icon(Icons.calendar_today,size: allsize*0.02,))
                  ],
                ),
                TextFormFieldWidget(
                  title: "Care of/Company Name(Optional)",
                  textEditingController: companyname,
                  optional: true, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "Address 1 (Street address,P.O. Box)",
                  textEditingController: address1,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title:
                      "Address 2 (Apartment suite,unit,building,floor,etc. Optional)",
                  textEditingController: address2,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "City",
                  textEditingController: city,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "Zip/Postal Code",
                  textEditingController: zip,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "Phone",
                  textEditingController: phone,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "Password",
                  textEditingController: password,
                  optional: false, readOnly: false,
                ),
                TextFormFieldWidget(
                  title: "Reenter Password",
                  textEditingController: c_password,
                  optional: false, readOnly: false,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.4,
                      child: Center(
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              color: const Color(0xff006ccf),
                              fontWeight: FontWeight.bold,
                              fontSize: allsize*0.016),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        ApiRequests().RegisterUser(email.text,r_email.text,address.text,firstname.text,lastname.text,dob.text,companyname.text,address1.text,address2.text,city.text,zip.text,phone.text,password.text,c_password.text,"840","NY", context);
                      },
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 0.4,
                        color: const Color(0xff006ccf),
                        child:  Center(
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:allsize*0.016),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
