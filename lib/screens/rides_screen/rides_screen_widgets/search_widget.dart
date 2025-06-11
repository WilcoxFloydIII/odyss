import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/providers/ride_list_provider.dart';

class SearchWidget extends ConsumerStatefulWidget {
  SearchWidget({super.key});

  @override
  ConsumerState<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends ConsumerState<SearchWidget> {
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    DateTime? selectedDateTime;

    Future<void> pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2030),
      );
      if (picked != null) {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDateTime?.hour ?? 0,
          selectedDateTime?.minute ?? 0,
        );
        dateController.text = '${picked.day}/${picked.month}/${picked.year}';
        ref.read(dateQueryProvider.notifier).state = '${picked.day}/${picked.month}/${picked.year}';
      }
    }

    Future<void> showTimePeriodDialog(
      BuildContext context,
      Function(String) onSelected,
    ) async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Select Time Period'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Morning'),
                onTap: () => onSelected('Morning'),
              ),
              ListTile(
                title: Text('Afternoon'),
                onTap: () => onSelected('Afternoon'),
              ),
              ListTile(title: Text('Night'), onTap: () => onSelected('Night')),
              ListTile(
                title: Text('None'),
                onTap: () => onSelected(''),
              ),
            ],
          ),
        ),
      );
    }

    Future<void> pickTime() async {
      await showTimePeriodDialog(context, (String selectedPeriod) {
        timeController.text = selectedPeriod;
        setState(() {
          timeController.text = selectedPeriod;
          ref.read(timeQueryProvider.notifier).state = selectedPeriod;
        }); // To update UI if needed
      });
    }

    Future<void> showStatePeriodDialog(
      BuildContext context,
      Function(String) onSelected,
    ) async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Select Destination'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: Text('Abuja'), onTap: () => onSelected('Abuja')),
              ListTile(title: Text('Lagos'), onTap: () => onSelected('Lagos')),
              ListTile(title: Text('None'), onTap: () => onSelected('')),
            ],
          ),
        ),
      );
    }

    Future<void> pickState() async {
      await showStatePeriodDialog(context, (String selectedState) {
        destinationController.text = selectedState;
        setState(() {
          destinationController.text = selectedState;
          ref.read(arrivalQueryProvider.notifier).state = selectedState;
        }); // To update UI if needed
      });
    }

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          bottom: MediaQuery.of(context).size.width * 0.05,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 10),
              color: Colors.black12,
            ),
          ],
          color: myColors.backgound,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 19),
                  Icon(Icons.circle, size: 13),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900),
                  ),
                  Icon(Icons.location_on_rounded),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900),
                  ),
                  Icon(Icons.access_time_filled),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    controller: locationController,
                    readOnly: true,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Enugu',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: myColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: myColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  TextFormField(
                    controller: destinationController,
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Destination',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: myColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: myColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onTap: pickState,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          controller: dateController,
                          textInputAction: TextInputAction.done,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Date',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: myColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: myColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.all(15),
                          ),
                          onTap: pickDate,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          controller: timeController,
                          textInputAction: TextInputAction.done,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Time',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: myColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: myColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onTap: pickTime,
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
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/ride_model.dart';
// import '../providers/ride_providers.dart';

// class RideSearchPage extends ConsumerStatefulWidget {
//   RideSearchPage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<RideSearchPage> createState() => _RideSearchPageState();
// }

// class _RideSearchPageState extends ConsumerState<RideSearchPage> {
//   final destinationController = TextEditingController();
//   final dateController = TextEditingController();
//   final timeController = TextEditingController();

//   DateTime? selectedDateTime;

//   Future<void> pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2024),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) {
//       selectedDateTime = DateTime(
//         picked.year,
//         picked.month,
//         picked.day,
//         selectedDateTime?.hour ?? 0,
//         selectedDateTime?.minute ?? 0,
//       );
//       dateController.text = '${picked.day}/${picked.month}/${picked.year}';
//     }
//   }

//   Future<void> pickTime() async {
//     final picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null && selectedDateTime != null) {
//       selectedDateTime = DateTime(
//         selectedDateTime!.year,
//         selectedDateTime!.month,
//         selectedDateTime!.day,
//         picked.hour,
//         picked.minute,
//       );
//       timeController.text = picked.format(context);
//     }
//   }

//   void performSearch() {
//     if (selectedDateTime != null) {
//       ref.read(rideSearchQueryProvider.notifier).state = RideSearchQuery(
//         destination: destinationController.text.trim(),
//         dateTime: selectedDateTime!,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredRides = ref.watch(filteredRidesProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text('Search Rides')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
            
//             ElevatedButton(
//               onPressed: performSearch,
//               child: Text('Search'),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredRides.length,
//                 itemBuilder: (context, index) {
//                   final ride = filteredRides[index];
//                   return ListTile(
//                     title: Text('${ride.departure} → ${ride.destination}'),
//                     subtitle: Text('${ride.company}, ₦${ride.price}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }