import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/ride_list_provider.dart';
import 'package:odyss/core/providers/user_list_provider.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/rides_screen/rides_screen_widgets/selected_ride_dialog.dart';

class AvailableRidesWidget extends ConsumerStatefulWidget {
  const AvailableRidesWidget({super.key});

  @override
  ConsumerState<AvailableRidesWidget> createState() =>
      _AvailableRidesWidgetState();
}

class _AvailableRidesWidgetState extends ConsumerState<AvailableRidesWidget> {
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    final filteredRides = ref.watch(filteredRidesProvider);
    var allRides = ref.watch(ridesListProvider);
    var userList = ref.watch(userListProvider);

    return ListView.builder(
      itemCount: filteredRides.length,
      itemBuilder: (context, index) {
        var ride = filteredRides[index];

        List<UserModel> members = userList
            .where((members) => ride.memberIds.contains(members.id))
            .toList();

        cardLimit() {
          if (ride.memberIds.length >= 3) {
            return 3;
          } else {
            return ride.memberIds.length;
          }
        }

        
        bool isMember = ride.memberIds.contains(UID);

        // final bool cardLimitCheck = ride.members.length > 3;
        final bool dayCheck = ride.departureDate.day.toString().length > 1;

        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          decoration: BoxDecoration(
            border: BoxBorder.fromLTRB(
              bottom: BorderSide(width: 1, color: Colors.black26),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: ((17 * (cardLimit() - 1)) + 43),
                            height: 40,
                            child: Stack(
                              children: [
                                ...List.generate(cardLimit(), (indexnew) {
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
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Text(
                            '${members[0].nickName} and ${ride.memberIds.length - 1} others',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print(members);
                        isMember
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Already a member'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: myColors.backgound,
                                ),
                              )
                            : showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Dialog',
                                transitionDuration: const Duration(
                                  milliseconds: 300,
                                ),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                      return SelectedRideDialog(
                                        arrLoc: ride.arrivalLoc,
                                        company: ride.company,
                                        days: ride.days,
                                        depLoc: ride.departureLoc,
                                        finalDate: ride.arrivalDate,
                                        initDate: ride.departureDate,
                                        members: members,
                                        seats: ride.seats,
                                        vehicle: ride.vehicle,
                                        price: ride.price,
                                      );
                                    },
                                transitionBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      final offsetAnimation = Tween<Offset>(
                                        begin: const Offset(
                                          0,
                                          1,
                                        ), // From bottom
                                        end: Offset.zero,
                                      ).animate(animation);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                              );
                      },
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        ),
                        backgroundColor: WidgetStatePropertyAll(isMember? Colors.blueGrey.shade400 : myColors.primary)
                      ),
                      child: Text('Join trip', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                              fontSize: 7,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '|',
                            style: TextStyle(
                              fontSize: 7,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          SizedBox(height: 23),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(width: 3),
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
                          '${(ride.seats - ride.memberIds.length).toString()} seats',
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
                          '${ride.days.toString()} days',
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
        );
      },
    );
  }
}
