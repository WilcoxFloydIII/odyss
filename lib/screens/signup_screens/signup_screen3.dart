import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl_phone_field/countries.dart';

class SignupScreen3 extends StatefulWidget {
  const SignupScreen3({super.key});

  @override
  State<SignupScreen3> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen3> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final phoneFormatter = MaskTextInputFormatter(
    mask: '### ### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final nigeria = Country(
    minLength: 11,
    name: 'Nigeria',
    code: 'NG',
    dialCode: '+234',
    flag: '🇳🇬', 
    nameTranslations: {}, 
    maxLength: 20,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                        ),
                        Text(
                          'Tell us abt yourself,',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      padding: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 0,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email'),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'johndoe@gmail.com',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 0,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Phone number'),
                                IntlPhoneField(
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [phoneFormatter],
                                  disableLengthCheck: true,
                                  decoration: InputDecoration(
                                    hintText: '812 345 6789',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 11),
                                    counterText: '',
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  showCountryFlag: false,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  initialCountryCode: 'NG',
                                  onChanged: (phone) {
                                    print(
                                      phone.completeNumber,
                                    ); // e.g., +14155552671
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 130,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.push('/signup4');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Next',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
