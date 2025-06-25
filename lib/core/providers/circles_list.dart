import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/data/models/circle_model.dart';

class CircleListNotifier extends StateNotifier<List<CircleModel>> {
  CircleListNotifier()
    : super([
        CircleModel(
          id: '0',
          name: 'GOUNI students travelling to Lagos after school',
          departure: 'Enugu',
          destination: 'Lagos',
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(days: 1)),
          users: [],
          description: 'This circle is for students in GOUNI travelling to Lagos after school closes',
        ),
        CircleModel(
          id: '1',
          name: 'GOUNI students travelling to Abuja after school',
          description: 'This circle is for students in GOUNI travelling to Abuja after school closes',
          departure: 'Enugu',
          destination: 'Abuja',
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(days: 1)),
          users: [],
        ),
      ]);

  void addCircle(CircleModel circle) {
    state = [...state, circle];
  }

  void updateCircle(
    String? id, {
    String? name,
    String? description,
    String? departure,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? users,
  }) {
    state = state.map((circle) {
      if (circle.id == id) {
        return circle.copyWith(
          id: id,
          name: name,
          description: description,
          departure: departure,
          destination: destination,
          startDate: startDate,
          endDate: endDate,
          users: users,
        );
      }
      return circle;
    }).toList();
  }
}

var CircleListProvider =
    StateNotifierProvider<CircleListNotifier, List<CircleModel>>(
      (ref) => CircleListNotifier(),
    );
