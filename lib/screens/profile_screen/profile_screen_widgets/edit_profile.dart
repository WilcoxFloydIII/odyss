import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/user_list_provider.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController insatgramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();

  @override
    void initState() {

      final users = ref.read(userListProvider);

      var user = users.firstWhere((element) => element.id == UID);

      super.initState();
      nickNameController = TextEditingController(text: user.nickName);
      firstNameController = TextEditingController(text: user.firstName);
      lastNameController = TextEditingController(text: user.lastName);
      bioController = TextEditingController(text: user.bio);
      tiktokController = TextEditingController(text: user.tiktok);
      insatgramController = TextEditingController(text: user.insta);
      twitterController = TextEditingController(text: user.x);
      facebookController = TextEditingController(text: user.fb);
    }

    @override
    void dispose() {
      nickNameController.dispose();
      firstNameController.dispose();
      lastNameController.dispose();
      bioController.dispose();
      tiktokController.dispose();
      insatgramController.dispose();
      twitterController.dispose();
      facebookController.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context,) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        child: Scaffold(
          backgroundColor: myColors.backgound,
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                0,
                MediaQuery.of(context).size.width * 0.05,
                0,
              ),
              color: myColors.backgound,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 25),
                        ),
                        
                        Text('Edit your profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 40,
                            runSpacing: 40,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.blueGrey.shade100,
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Image.asset(
                                      'assets/images/pen.png',
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueGrey.shade100,
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Image.asset(
                                      'assets/images/pen.png',
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text('Personal Info'),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nickname'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nickNameController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              fillColor: myColors.backgound,
                              hintText: 'Change your nickname',
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
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              hintText: 'Change your first name',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
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
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Last Name'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: lastNameController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Change your last name',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
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
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bio'),

                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: bioController,
                            maxLength: 250,
                            maxLines: 3,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),

                            decoration: InputDecoration(
                              hintText: 'Write a bio',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
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
                    SizedBox(height: 40),
                    Text('Social Media Info', textAlign: TextAlign.start),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tiktok'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: tiktokController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: '@tiktok',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
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
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Instagram'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: insatgramController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: '@instagram',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
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
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Twitter'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: twitterController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: '@twitter',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
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
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: myColors.primary),
                        borderRadius: BorderRadius.circular(20),
                        color: myColors.backgound,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Facebook'),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: facebookController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'https://facebook.com/facebook',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: myColors.backgound,
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(userListProvider.notifier)
                                  .updateUser(
                                    UID,
                                    nickName: nickNameController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    bio: bioController.text,
                                    tiktok: tiktokController.text,
                                    insta: insatgramController.text,
                                    x: twitterController.text,
                                    fb: facebookController.text,
                                  );
                              context.pop();
                            },
                            child: Text('Update'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
