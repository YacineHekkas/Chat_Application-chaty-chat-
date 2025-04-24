import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/Controller/auth.dart';
import '../../CustomUI/custom_text_field.dart';


class LoginScreen extends ConsumerStatefulWidget   {
  const LoginScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}
class _LoginScreenState extends ConsumerState<LoginScreen> {

 // late Response response;
  late TextEditingController countryNameController;
  late TextEditingController userNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phonNumberController;
  late TextEditingController emailController;



  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Algeria');
    countryCodeController = TextEditingController(text: '213');
    phonNumberController = TextEditingController();
    userNameController = TextEditingController();
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
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
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
                  controller: userNameController,
                  hintText: 'entre your user name',
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
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
                        controller: phonNumberController,
                        hintText: 'phone number',
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Carrier charges may apply',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(

            child: Consumer(builder: (context,ref, _){
              bool isLoading = ref.watch(authNotifierProvider);
              return isLoading ? const CircularProgressIndicator()
                  : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).indicatorColor),
                ),
                onPressed: () async {
                  if ((phonNumberController.text == "") || (emailController.text == "") || ( userNameController.text == "" )) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please fill all fields.'),
                    ));
                  }
                  else if (!isEmailValid(emailController.text)) {
                    // Display an error message if email format is invalid
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please enter a valid email address.'),
                    ));
                  }
                  else{
                    ref.read ( authNotifierProvider.notifier ).login(email: emailController.text, username : userNameController.text, context: context );
                  }

                },

                child: const Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              );
            },)
          ),
    );

  }

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }


  showCountryPickerBottomSheet() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['ET'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).backgroundColor,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: Colors.grey),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          prefixIcon: const Icon(
            Icons.language,
            color: Colors.red,
          ),
          hintText: 'Search country by code or name',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.2),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }
}


