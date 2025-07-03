import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/providers/list_providers/ride_list_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

class AvailableRidesWidget extends ConsumerStatefulWidget {
  const AvailableRidesWidget({super.key});

  @override
  ConsumerState<AvailableRidesWidget> createState() =>
      _AvailableRidesWidgetState();
}

class _AvailableRidesWidgetState extends ConsumerState<AvailableRidesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.refresh(filteredRidesProvider);
    ref.refresh(userListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    final filteredRidesAsync = ref.watch(filteredRidesProvider);
    final userListAsync = ref.watch(userListProvider);

    // Show loading animation if any provider is loading
    if (filteredRidesAsync is AsyncLoading || userListAsync is AsyncLoading) {
      return const Scaffold(body: Center(child: LoadingAnimationWidget()));
    }

    // Show error dialog if any provider has an error
    if (filteredRidesAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: filteredRidesAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }
    if (userListAsync is AsyncError) {
      return Scaffold(
        body: ErrorDialogWidget(
          error: userListAsync.error.toString(),
          onRetry: () => setState(() {}),
        ),
      );
    }

    // Extract data after loading/error checks
    final filteredRides = filteredRidesAsync.value ?? [];
    final userList = userListAsync.value ?? [];

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      color: Theme.of(context).primaryColor,
      child: filteredRides.isEmpty
          ? Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Icon(
                      Icons.directions_car_filled_rounded,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No available rides',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Check back later or curate a new trip!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: filteredRides.length,
              itemBuilder: (context, index) {
                var ride = filteredRides[index];

                List<UserModel> members = userList
                    .where((members) => ride.memberIds.contains(members.id))
                    .toList();
                UserModel creator = members.firstWhere(
                  (member) => member.id == ride.creator,
                );

                cardLimit() {
                  if (members.length >= 3) {
                    return 3;
                  } else {
                    return members.length;
                  }
                }

                final bool dayCheck =
                    ride.departureDate.day.toString().length > 1;

                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.width * 0.02,
                  ),
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      bottom: BorderSide(width: 1, color: Colors.black26),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: ((17 * (cardLimit() - 1)) + 43),
                                    height: 40,
                                    child: Stack(
                                      children: [
                                        ...List.generate(cardLimit(), (
                                          indexnew,
                                        ) {
                                          // final member = ride.members[indexnew];
                                          return Positioned(
                                            left: indexnew * 17,
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.black,
                                                ),
                                                color: Colors.grey.shade300,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    members[indexnew].picture,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${creator.nickName} and ${members.length - 1} others',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                print(creator.nickName);
                                context.push('/ride/${ride.id}');
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
                                    return myColors.primary;
                                  }
                                  return myColors.backgound;
                                }),
                                backgroundColor: WidgetStateColor.resolveWith((
                                  states,
                                ) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return myColors.backgound;
                                  }
                                  return myColors.primary;
                                }),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      35,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                              child: Text(
                                'Join trip',
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.circle, size: 13),
                                  Text(
                                    '|',
                                    style: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    '|',
                                    style: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    '|',
                                    style: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Icon(Icons.location_on_rounded),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ride.departureLoc,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${dayCheck ? ride.departureDate.day : '0${ride.departureDate.day}'} ${DateFormat.MMM().format(ride.departureDate)}, ${DateFormat.Hm().format(ride.departureDate)} ${DateFormat('a').format(ride.departureDate)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 27),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ride.arrivalLoc,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${dayCheck ? ride.arrivalDate.day : '0${ride.arrivalDate.day}'} ${DateFormat.MMM().format(ride.arrivalDate)}, ${DateFormat.Hm().format(ride.arrivalDate)} ${DateFormat('a').format(ride.arrivalDate)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  // Container(
                                  //   height: 25,
                                  //   width: 25,
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.grey.shade300,
                                  //     borderRadius: BorderRadius.circular(15),
                                  //   ),
                                  // ),
                                  // SizedBox(width: 3),
                                  Text(
                                    ride.company,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
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
                                    text: ride.vehicle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₦${ride.price.toString()}',
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
                                  '${(ride.seats - members.length).toString()} seats',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'available',
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${ride.departureDate.day - DateTime.now().day} days',
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
                      SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
