import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/core/providers/list_providers/ride_list_provider.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';

class AllSetScreen extends ConsumerWidget {
  const AllSetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ref.invalidate(ridesListProvider);
            ref.invalidate(userListProvider);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.height * 0.2,
          MediaQuery.of(context).size.width * 0.05,
          0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/all_set_logo.png', width: 150),
            SizedBox(height: 30),
            Text('All Set!!!', style: TextStyle(fontSize: 20)),
            Text(
              'Hurrray!!!, your now set to join in on the conversation with your trip buddies.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.invalidate(ridesListProvider);
                      ref.invalidate(userListProvider);
                      context.go('/rides');
                    },
                    child: Text(
                      'Return to Rides',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
