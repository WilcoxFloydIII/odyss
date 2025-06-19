import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/company_list_provider.dart';
import 'package:odyss/core/providers/ride_list_provider.dart';
import 'package:odyss/data/models/company_model.dart';
import 'package:odyss/data/models/ride_model.dart';

class PricingScreen extends ConsumerStatefulWidget {
  const PricingScreen({super.key});

  @override
  ConsumerState<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends ConsumerState<PricingScreen> {
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final myColors = Theme.of(context).extension<MyColors>()!;

    final partnerList = ref.watch(partnerListProvider);
    //final ridesList = ref.watch(ridesListProvider);

    PartnerModel currPartner = partnerList.firstWhere(
      (currPartner) => currPartner.name == newRide['partner'],
    );

    VehicleModel currVehicle = currPartner.vehicles.firstWhere(
      (currVehicle) => currVehicle.type == newRide['vehicle'],
    );

    String price = currVehicle.price;

    priceController.text = '₦$price';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          excludeHeaderSemantics: true,
          toolbarHeight: 5,
          titleSpacing: 0,
          leadingWidth: 0,
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
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
                        Container(
                          width: MediaQuery.of(context).size.width * 0.87,
                          child: Text(
                            overflow: TextOverflow.clip,
                            "Pricing & Plan B",
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
                      height: 400,
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
                              border: Border.all(
                                width: 2,
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Trip price per seat (₦)'),
                                TextFormField(
                                  controller: priceController,
                                  keyboardType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onTap: () {
                                    Flushbar(
                                      message:
                                          "Prices are automatically set based on the trip details you've chosen",
                                      messageSize: 12,
                                      duration: Duration(seconds: 1),
                                      flushbarPosition:
                                          FlushbarPosition.TOP, // Top of screen
                                      backgroundColor: Colors
                                          .red, // Optional: customize color
                                      margin: EdgeInsets.all(
                                        8,
                                      ), // Optional: margin for better look
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ), // Optional: rounded corners
                                    ).show(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Refund policy acknowledgement',
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 10),
                                ListTile(
                                  leading: Icon(Icons.circle, size: 5),
                                  titleAlignment:
                                      ListTileTitleAlignment.titleHeight,
                                  contentPadding: EdgeInsets.all(0),
                                  horizontalTitleGap: 0,
                                  title: Text(
                                    'You are eligible for a full refund if you cancel your booking at least 3 days (72 hours) before the scheduled trip date.',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.circle, size: 5),
                                  titleAlignment:
                                      ListTileTitleAlignment.titleHeight,
                                  contentPadding: EdgeInsets.all(0),
                                  minVerticalPadding: 0,
                                  horizontalTitleGap: 0,
                                  title: Text(
                                    'Refunds will be processed within 5-7 business days to your original payment method.',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: ElevatedButton(
                                  onPressed: () {
                                    newRide['members'].add(UID);
                                    newRide['price'] = price;
                                    var newRideModel = RideModel(
                                      vehicle: newRide['vehicle'],
                                      memberIds: List.from(newRide['members']),
                                      seats: int.parse(newRide['seats']),
                                      company: newRide['partner'],
                                      price: int.parse(newRide['price']),
                                      days: 3,
                                      departureLoc: newRide['depLoc'],
                                      arrivalLoc: newRide['destLoc'],
                                      departureTOD: newRide['time'],
                                      departureDate: DateTime(2),
                                      arrivalDate: DateTime(3),
                                      id: '',
                                    );
                                    ref
                                        .read(ridesListProvider.notifier)
                                        .addRide(newRideModel);
                                    print(ref.watch(ridesListProvider).length);
                                    context.go('/rides');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Book your seat',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
