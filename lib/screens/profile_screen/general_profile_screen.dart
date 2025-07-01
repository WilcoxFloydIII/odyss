import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
//import 'package:odyss/core/providers/ride_list_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
//import 'package:odyss/data/models/ride_model.dart';

class GeneralProfileScreen extends ConsumerStatefulWidget {
  const GeneralProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<GeneralProfileScreen> createState() =>
      _GeneralProfileScreenState();
}

class _GeneralProfileScreenState extends ConsumerState<GeneralProfileScreen> {
  bool switchPic = false;

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    final userListAsync = ref.watch(userListProvider);

    if (userListAsync is AsyncLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (userListAsync is AsyncError) {
      return Scaffold(
        body: Center(
          child: Text('Failed to load user data: ${userListAsync.error}'),
        ),
      );
    }

    final users = userListAsync.value ?? [];
    final user = users.firstWhere((element) => element.id == widget.userId);

    showPic() {
      if (switchPic == false) {
        return Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(75),
            color: Colors.blueGrey.shade100,
            image: DecorationImage(
              image: NetworkImage(user.picture),
              fit: BoxFit.cover,
            ),
          ),
        );
      } else {
        return Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.blueGrey.shade100,
          ),
        );
      }
    }

    // List<RideModel> rides = allRides
    //     .where((element) => element.memberIds.contains(widget.userId))
    //     .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.width * 0.2),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.width * 0.05,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: myColors.backgound,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    Text(
                      "${user.nickName}'s profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  decoration: BoxDecoration(color: myColors.backgound),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          showPic(),
                          Positioned(
                            left: 90,
                            top: 3,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  switchPic = !switchPic;
                                });
                              },
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.all(10),
                                ),
                                shape: WidgetStatePropertyAll(CircleBorder()),
                                elevation: WidgetStateProperty.resolveWith((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return 0;
                                  }
                                  return 10;
                                }),
                                backgroundColor: WidgetStatePropertyAll(
                                  myColors.backgound,
                                ),
                                foregroundColor: WidgetStatePropertyAll(
                                  myColors.primary,
                                ),
                              ),
                              child: Icon(Icons.sync_outlined),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        user.nickName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        width: 260,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.all(0),
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Image.asset(
                                'assets/images/tiktok_logo.png',
                                height: 25,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.all(0),
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Image.asset(
                                'assets/images/instagram_logo.png',
                                height: 25,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.all(0),
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Image.asset(
                                'assets/images/x_logo.png',
                                height: 25,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.all(0),
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Image.asset(
                                'assets/images/facebook_logo.png',
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.bio,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                Text(
                                  'Vibe: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                  ),
                                ),
                                ...List.generate(user.vibes.length, (index) {
                                  return Text.rich(
                                    TextSpan(
                                      text: '${user.vibes[index]}, ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
