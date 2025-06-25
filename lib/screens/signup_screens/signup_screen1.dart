import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';

class SignupScreen1 extends StatefulWidget {
  const SignupScreen1({super.key});

  @override
  State<SignupScreen1> createState() => _SignupPage1State();
}

class _SignupPage1State extends State<SignupScreen1> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  GlobalKey signup1Key = GlobalKey();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2009),
      firstDate: DateTime(1930), // minimum date
      lastDate: DateTime(2010), // maximum date
    );
    if (picked != null) {
      dateController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: Container(
            child: Form(
              key: signup1Key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: Icon(Icons.arrow_back_ios_rounded, size: 25),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tell us abt yourself,',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Just the basics - your name, your birthday and were good to go.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                runAlignment: WrapAlignment.spaceBetween,
                                runSpacing: 20,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.43,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Firstname'),
                                        TextFormField(
                                          keyboardType: TextInputType.name,
                                          controller: firstNameController,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter firstname',
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
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.43,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Lastname'),
                                        TextFormField(
                                          keyboardType: TextInputType.name,
                                          controller: lastNameController,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Enter lastname',
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Date of birth'),
                                        TextFormField(
                                          keyboardType: TextInputType.datetime,
                                          controller: dateController,
                                          textInputAction: TextInputAction.next,
                                          readOnly: true,
                                          onTap: () => _selectDate(context),
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '2025-02-34',
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
                                      if (firstNameController.text.isEmpty ||
                                          firstNameController.text.length < 3) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 2),
                                            backgroundColor: myColors.backgound,
                                            content: Text(
                                              'First name cannot be less than 3 letters long',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        if (lastNameController.text.isEmpty ||
                                            lastNameController.text.length <
                                                3) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              duration: Duration(seconds: 2),
                                              backgroundColor:
                                                  myColors.backgound,
                                              content: Text(
                                                'Last name cannot be less than 3 letters long',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          if (dateController.text.isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                duration: Duration(seconds: 2),
                                                backgroundColor:
                                                    myColors.backgound,
                                                content: Text(
                                                  'You must give a valid date of birth',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            newUser['firstName'] =
                                                firstNameController.text;
                                            newUser['lastName'] =
                                                lastNameController.text;
                                            context.push('/signup2');
                                            newUser['DOB'] = dateController.text;
                                          }
                                        }
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
      ),
    );
  }
}
