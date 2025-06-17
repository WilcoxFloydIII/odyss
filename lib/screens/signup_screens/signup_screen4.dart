import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';

class SignupScreen4 extends StatefulWidget {
  const SignupScreen4({super.key});

  @override
  State<SignupScreen4> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen4> {
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
                          'Hmm, add a pic,',
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
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.blueGrey,
                                  ),
                                  image: DecorationImage(image: AssetImage('')),
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.3,
                                  ),
                                  color: const Color(0x83000000),
                                ),
                                child: Text(
                                  '+ share a little something about you',
                                  style: TextStyle(
                                    color: myColors.backgound,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 130,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.push('/signup5');
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
