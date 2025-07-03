import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/list_providers/ride_list_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
import 'package:odyss/data/models/ride_model.dart';
import 'package:odyss/screens/bottom_app_bar.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:odyss/screens/profile_screen/profile_screen_widgets/video_player_loop_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  VideoPlayerController? _controller;
  // File? _lastFile;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.refresh(userListProvider);
    ref.refresh(ridesListProvider);
  }

  bool switchPic = false;
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    final userListAsync = ref.watch(userListProvider);
    final ridesListAsync = ref.watch(ridesListProvider);

    if (userListAsync is AsyncLoading || ridesListAsync is AsyncLoading) {
      return Scaffold(
        body: const Center(child: CircularProgressIndicator()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const FloatingButtonWidget(),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadiusGeometry.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomAppBarWidget(
            toggle1: false,
            toggle2: false,
            toggle3: false,
            toggle4: true,
          ),
        ),
      );
    }

    if (userListAsync is AsyncError) {
      // Print the full error for debugging
      if (kDebugMode) {
        print('User data error: ${userListAsync.error}');
      }
      return Scaffold(
        body: ErrorDialogWidget(
          error: userListAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButtonWidget(),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomAppBarWidget(
            toggle1: false,
            toggle2: false,
            toggle3: false,
            toggle4: true,
          ),
        ),
      );
    }

    if (ridesListAsync is AsyncError) {
      // Print the full error for debugging
      print('Rides data error: ${ridesListAsync.error}');
      return Scaffold(
        body: ErrorDialogWidget(
          error: 'Failed to load rides data.',
          onRetry: () => setState(() {}),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButtonWidget(),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomAppBarWidget(
            toggle1: false,
            toggle2: false,
            toggle3: false,
            toggle4: true,
          ),
        ),
      );
    }

    final users = userListAsync.value ?? [];
    final user = users.firstWhere((element) => element.id == UID);

    final allRides = ridesListAsync.value ?? [];

    Future<String?> getUserPicture() async {
      final imagePath = user.picture;
      return imagePath.isNotEmpty ? imagePath : null;
    }

    Widget showPic() {
      if (switchPic == false) {
        return FutureBuilder<String?>(
          future: getUserPicture(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.blueGrey.shade100,
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              return Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.blueGrey.shade100,
                  image: DecorationImage(
                    image: NetworkImage(snapshot.data!),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              return Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.blueGrey.shade100,
                ),
                child: const Icon(Icons.person, size: 75, color: Colors.grey),
              );
            }
          },
        );
      } else {
        return VideoPlayerLoop(url: user.video);
      }
    }

    List<RideModel> rides = allRides
        .where((element) => element.memberIds.contains(UID))
        .toList();

    return Scaffold(
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
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      bottom: BorderSide(
                        width: 2,
                        color: Colors.blueGrey.shade100,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
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
                      SizedBox(
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
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                context.push('/editProfile');
                              },
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                ),
                                foregroundColor: WidgetStateColor.resolveWith((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return myColors.backgound;
                                  }
                                  return myColors.primary;
                                }),
                                backgroundColor: WidgetStateColor.resolveWith((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return myColors.primary;
                                  }
                                  return myColors.backgound;
                                }),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      35,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                side: WidgetStatePropertyAll(
                                  BorderSide(width: 2, color: myColors.primary),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/pen.png',
                                      height: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Edit Profile'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Text('Tickets'),
                      SizedBox(height: 10),
                      Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: (300 * rides.length).toDouble(),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: rides.length,
                          itemBuilder: (context, index) {
                            bool dayCheck =
                                rides[index].departureDate.day
                                    .toString()
                                    .length ==
                                2;
                            if (rides.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.confirmation_num_rounded,
                                      size: 64,
                                      color: Colors.grey.shade400,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No tickets or trips yet',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Your tickets and trips will appear here.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black26,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('ID: ${rides[index].id} '),
                                            TextButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 20,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    WidgetStateColor.resolveWith(
                                                      (states) {
                                                        if (states.contains(
                                                          WidgetState.pressed,
                                                        )) {
                                                          return myColors
                                                              .primary;
                                                        }
                                                        return myColors
                                                            .backgound;
                                                      },
                                                    ),
                                                foregroundColor:
                                                    WidgetStateColor.resolveWith(
                                                      (states) {
                                                        if (states.contains(
                                                          WidgetState.pressed,
                                                        )) {
                                                          return myColors
                                                              .backgound;
                                                        }
                                                        return myColors.primary;
                                                      },
                                                    ),
                                                side: WidgetStatePropertyAll(
                                                  BorderSide(
                                                    width: 2,
                                                    color: myColors.primary,
                                                  ),
                                                ),
                                                elevation:
                                                    WidgetStatePropertyAll(0),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 70,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(Icons.circle, size: 13),
                                                  Text(
                                                    '|',
                                                    style: TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Text(
                                                    '|',
                                                    style: TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Text(
                                                    '|',
                                                    style: TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        rides[index]
                                                            .departureLoc,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${dayCheck ? rides[index].departureDate.day : '0${rides[index].departureDate.day}'} ${DateFormat.MMM().format(rides[index].departureDate)}, ${DateFormat.Hm().format(rides[index].departureDate)} ${DateFormat('a').format(rides[index].departureDate)}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 27),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        rides[index].arrivalLoc,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${dayCheck ? rides[index].arrivalDate.day : '0${rides[index].arrivalDate.day}'} ${DateFormat.MMM().format(rides[index].arrivalDate)}, ${DateFormat.Hm().format(rides[index].arrivalDate)} ${DateFormat('a').format(rides[index].arrivalDate)}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    rides[index].company,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                text: 'Vehicle: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: rides[index].vehicle,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '₦${rides[index].price.toString()}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'per seat',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              children: [
                                                Text(
                                                  '1 seat',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'booked',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${rides[index].departureDate.day - DateTime.now().day} days',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'left to trip',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Trips'),
                      SizedBox(height: 10),
                      Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: (300 * rides.length).toDouble(),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: rides.length,
                          itemBuilder: (context, index) {
                            bool dayCheck =
                                rides[index].departureDate.day
                                    .toString()
                                    .length ==
                                2;

                            cardLimit() {
                              if (rides[index].memberIds.length >= 3) {
                                return 3;
                              } else {
                                return rides[index].memberIds.length;
                              }
                            }

                            if (rides.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.confirmation_num_rounded,
                                      size: 64,
                                      color: Colors.grey.shade400,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No tickets or trips yet',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Your tickets and trips will appear here.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black26,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        ((17 *
                                                            (cardLimit() - 1)) +
                                                        43),
                                                    height: 40,
                                                    child: Stack(
                                                      children: [
                                                        ...List.generate(cardLimit(), (
                                                          indexnew,
                                                        ) {
                                                          // final member = rides[index].members[indexnew];
                                                          return Positioned(
                                                            left: indexnew * 17,
                                                            child: Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      20,
                                                                    ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    user.nickName,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 20,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    WidgetStateColor.resolveWith(
                                                      (states) {
                                                        if (states.contains(
                                                          WidgetState.pressed,
                                                        )) {
                                                          return myColors
                                                              .primary;
                                                        }
                                                        return myColors
                                                            .backgound;
                                                      },
                                                    ),
                                                foregroundColor:
                                                    WidgetStateColor.resolveWith(
                                                      (states) {
                                                        if (states.contains(
                                                          WidgetState.pressed,
                                                        )) {
                                                          return myColors
                                                              .backgound;
                                                        }
                                                        return myColors.primary;
                                                      },
                                                    ),
                                                side: WidgetStatePropertyAll(
                                                  BorderSide(
                                                    width: 2,
                                                    color: myColors.primary,
                                                  ),
                                                ),
                                                elevation:
                                                    WidgetStatePropertyAll(0),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 70,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(Icons.circle, size: 13),
                                                  Text(
                                                    '|',
                                                    style: TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Text(
                                                    '|',
                                                    style: TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Text(
                                                    '|',
                                                    style: TextStyle(
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        rides[index]
                                                            .departureLoc,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${dayCheck ? rides[index].departureDate.day : '0${rides[index].departureDate.day}'} ${DateFormat.MMM().format(rides[index].departureDate)}, ${DateFormat.Hm().format(rides[index].departureDate)} ${DateFormat('a').format(rides[index].departureDate)}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 27),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        rides[index].arrivalLoc,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${dayCheck ? rides[index].arrivalDate.day : '0${rides[index].arrivalDate.day}'} ${DateFormat.MMM().format(rides[index].arrivalDate)}, ${DateFormat.Hm().format(rides[index].arrivalDate)} ${DateFormat('a').format(rides[index].arrivalDate)}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    rides[index].company,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                text: 'Vehicle: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: rides[index].vehicle,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '₦${rides[index].price.toString()}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'per seat',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              children: [
                                                Text(
                                                  '1 seat',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'booked',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${rides[index].departureDate.day - DateTime.now().day} days',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  'left to trip',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await secureStorage.delete(key: 'access_token');
                                await secureStorage.delete(
                                  key: 'refresh_token',
                                );
                                // ignore: use_build_context_synchronously
                                context.go('/start');
                              },
                              child: Text('Log out'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonWidget(),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBarWidget(
          toggle1: false,
          toggle2: false,
          toggle3: false,
          toggle4: true,
        ),
      ),
    );
  }
}
