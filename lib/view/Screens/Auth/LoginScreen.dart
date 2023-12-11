import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../CustomUI/custom_elevated_button.dart';
import '../../CustomUI/custom_text_field.dart';
import '../VerificationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController emailController;

  sendCodeToPhone() {
    // final phoneNumber = phoneNumberController.text;
    // final countryName = countryNameController.text;
    // final countryCode = countryCodeController.text;
    //
    // if (phoneNumber.isEmpty) {
    //   return showAlertDialog(
    //     context: context,
    //     message: "Please enter your phone number",
    //   );
    // } else if (phoneNumber.length < 9) {
    //   return showAlertDialog(
    //     context: context,
    //     message:
    //     'The phone number you entered is too short for the country: $countryName\n\nInclude your area code if you haven\'t',
    //   );
    // } else if (phoneNumber.length > 10) {
    //   return showAlertDialog(
    //     context: context,
    //     message:
    //     "The phone number you entered is too long for the country: $countryName",
    //   );
    // }
    //
    // ref.read(authControllerProvider).sendSmsCode(
    //   context: context,
    //   phoneNumber: "+$countryCode$phoneNumber",
    // );
  }

  showCountryPickerBottomSheet() {
    // showCountryPicker(
    //   context: context,
    //   showPhoneCode: true,
    //   favorite: ['ET'],
    //   countryListTheme: CountryListThemeData(
    //     bottomSheetHeight: 600,
    //     backgroundColor: Theme.of(context).backgroundColor,
    //     flagSize: 22,
    //     borderRadius: BorderRadius.circular(20),
    //     textStyle: TextStyle(color: context.theme.greyColor),
    //     inputDecoration: InputDecoration(
    //       labelStyle: TextStyle(color: context.theme.greyColor),
    //       prefixIcon: const Icon(
    //         Icons.language,
    //         color: Coloors.greenDark,
    //       ),
    //       hintText: 'Search country by code or name',
    //       enabledBorder: UnderlineInputBorder(
    //         borderSide: BorderSide(
    //           color: context.theme.greyColor!.withOpacity(.2),
    //         ),
    //       ),
    //       focusedBorder: const UnderlineInputBorder(
    //         borderSide: BorderSide(
    //           color: Coloors.greenDark,
    //         ),
    //       ),
    //     ),
    //   ),
    //   onSelect: (country) {
    //     countryNameController.text = country.name;
    //     countryCodeController.text = country.phoneCode;
    //   },
    // );
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Ethiopia');
    countryCodeController = TextEditingController(text: '251');
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: Text(
              'Enter your Email',
              style: TextStyle(
                color:Theme.of(context).indicatorColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'WhatsApp will need to verify your email. ',
                    style: TextStyle(
                      color: Colors.black54,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: "What's my email?",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomTextField(
                  onTap: showCountryPickerBottomSheet,
                  controller: countryNameController,
                  readOnly: true,
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child:  CustomTextField(
                  controller: emailController,
                  hintText: 'entre your email',
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: CustomTextField(
                        onTap: showCountryPickerBottomSheet,
                        controller: countryCodeController,
                        prefixText: '+',
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        // controller: phoneNumberController,
                        hintText: 'phone number',
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Carrier charges may apply',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            margin: EdgeInsets.all(20),
            height: 42,
            width: 90 ,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).indicatorColor),
              ),
              onPressed: (){
                if(emailController.text != ""){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => VerificationScreen() ),
                  );
                  //TODO : add logic
                }

              },
              child: const Text(
                  "Next",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
    );
  }
}
