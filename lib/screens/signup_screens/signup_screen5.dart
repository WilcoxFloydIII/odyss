import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:odyss/core/colors.dart';
import 'package:odyss/screens/signup_screens/signup_screens_widgets/signup5_button.dart';

class SignupScreen5 extends StatefulWidget {
  const SignupScreen5({super.key});

  @override
  State<SignupScreen5> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen5> {
  @override
  Widget build(BuildContext context) {
    // final myColors = Theme.of(context).extension<MyColors>()!;
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
                            context.push('/signup4');
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.87,
                          child: Text(
                            overflow: TextOverflow.clip,
                            "Almost done...\nWhat's your vibe?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      padding: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: [VibeButton(text: 'sing-along'),
                                VibeButton(text: 'chatty'),
                                VibeButton(text: 'quiet'),
                                VibeButton(text: 'social media'),
                                VibeButton(text: 'explore'),
                                VibeButton(text: 'games'),
                                VibeButton(text: 'movies'),
                              ])
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 130,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.go('/rides');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Done',
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
                        context.go('/login');
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
