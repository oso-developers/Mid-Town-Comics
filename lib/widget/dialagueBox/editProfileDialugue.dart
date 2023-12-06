
import 'package:midtowncomics/export.dart';

class EditProfileDialague extends StatefulWidget {
  final firstName,lastName,dob,email;
  const EditProfileDialague({super.key,required this.firstName,required this.lastName,required this.dob,required this.email});

  @override
  State<EditProfileDialague> createState() => _EditProfileDialagueState();
}

class _EditProfileDialagueState extends State<EditProfileDialague> {
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController dobController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController confirmEmailController=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  bool birthdayEmail=false;
  bool marketingEmail=false;
  bool trackingInfoEmail=false;
  @override
  void initState() {
    setState(() {
      firstNameController.text=widget.firstName??"asif";
      lastNameController.text=widget.lastName;
      dobController.text=widget.dob;
      emailController.text=widget.email;
      confirmEmailController.text=widget.email;
    });
    print(firstNameController);
    // TODO: implement initState
    super.initState();
  }
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
                    child: Column(
                      children: [
                        Container(
                          height: size.height*0.05,
                          width: double.infinity,
                          color: const Color(0xff006ccf),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width*0.04,
                              vertical: size.height*0.01
                            ),
                            child: Text("Edit Profile",style: TextStyle(
                              color: Colors.white,
                              fontSize: allsize*0.015,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFieldWidget(
                                title: "First Name",
                                textEditingController: firstNameController,
                                optional: false, readOnly: false,
                              ),
                              TextFormFieldWidget(
                                title: "Last Name",
                                textEditingController: lastNameController,
                                optional: false, readOnly: false,
                              ),
                              TextFormFieldWidget(
                                title: "Date of Birth",
                                textEditingController: dobController,
                                optional: false, readOnly: false,
                              ),
                              TextFormFieldWidget(
                                title: "Email",
                                textEditingController: emailController,
                                optional: false, readOnly: false,
                              ),
                              TextFormFieldWidget(
                                title: "Confirm Email",
                                textEditingController: confirmEmailController,
                                optional: false, readOnly: false,
                              ),
                              TextFormFieldWidget(
                                title: "Password",
                                textEditingController: password,
                                optional: false, readOnly: false,
                              ),
                              TextFormFieldWidget(
                                title: "Confirm Password",
                                textEditingController: confirmPassword,
                                optional: false, readOnly: false,
                              ),
                              SizedBox(height: size.height*0.01,),
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: const Color(0xff006ccf),
                                      value: birthdayEmail, onChanged:(value){
                                      setState(() {
                                        birthdayEmail=value!;
                                      });
                                  }
                                  ),
                                  const Text("Birthday Emails")
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: const Color(0xff006ccf),
                                      value: marketingEmail, onChanged:(value){
                                      setState(() {
                                        marketingEmail=value!;
                                      });
                                  }
                                  ),
                                  const Text("Marketing Emails")
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: const Color(0xff006ccf),
                                      value:trackingInfoEmail, onChanged:(value){
                                      setState(() {
                                        trackingInfoEmail=value!;
                                      });
                                  }
                                  ),
                                  const Text("Tracking Info Emails")
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                 TextButton(onPressed: (){
                                   Navigator.pop(context);
                                 }, child: Text("CANCEL",style: TextStyle(color: Colors.red,fontSize: allsize*0.012,fontWeight: FontWeight.bold),)),
                                 TextButton(onPressed: (){
                                   final streamedDataProvider =
                                   Provider.of<StreamedDataProvider>(context,
                                       listen: false);
                                   ApiRequests().SaveProfileData( streamedDataProvider.loginuserdata['sh_id'],firstNameController.text,lastNameController.text,dobController.text,emailController.text,confirmEmailController.text,password.text,confirmPassword.text,birthdayEmail==true?"1":"0",marketingEmail==true?"1":"0",trackingInfoEmail==true?"1":"0", widget.email, context);
                                 }, child: Text("SAVE",style: TextStyle(color: const Color(0xff006ccf,),fontSize: allsize*0.012,fontWeight: FontWeight.bold),)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });

  }
}
