import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/providers/circles_list.dart';
import 'package:odyss/core/providers/user_list_provider.dart';
import 'package:odyss/data/models/circle_model.dart';
import 'package:odyss/data/models/user_model.dart';

class CircleMembersScreen extends ConsumerStatefulWidget {
  const CircleMembersScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  ConsumerState<CircleMembersScreen> createState() =>
      _CircleMembersScreenState();
}

class _CircleMembersScreenState extends ConsumerState<CircleMembersScreen> {
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    List<CircleModel> allCircles = ref.watch(CircleListProvider);

    List<UserModel> allUsers = ref.watch(userListProvider);

    CircleModel circle = allCircles.firstWhere(
      (circle) => circle.id == widget.id,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            height: 80,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 20),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () {
                    context.pop();
                  },
                ),
                Container(
                  width: 45,
                  height: 45,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: myColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: myColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: myColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: myColors.primary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 250,
                  child: Text(
                    circle.name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ), // Placeholder for the back button
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  circle.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: circle.users.length,
                  itemBuilder: (context, index) {
                    String user = circle.users[index];
                    UserModel memberModel = allUsers.firstWhere(
                      (element) => element.id == user,
                    );
                    return ListTile(
                      onTap: () {
                        context.push('/profile/$user');
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      title: Text(
                        '${memberModel.firstName} ${memberModel.lastName}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          ),
                        ),
                        child: Text(
                          'Invite to trip',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
