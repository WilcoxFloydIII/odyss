import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/data/models/route_model.dart';

final routesListProvider = Provider<List<RouteModel>>(
  (ref) => [
    RouteModel(
      arrivalLocation: 'Abuja',
      departureLocation: 'Enugu',
      departureTime: [
        DateTime(0, 0, 0, 6, 0),
        DateTime(0, 0, 0, 12, 0),
        DateTime(0, 0, 0, 18, 0),
      ],
      duration: DateTime(0, 0, 0, 8, 0),
      vehicles: [
        VehicleModel(type: 'Lorry', seats: '30', price: '0'),
        VehicleModel(type: 'Sienna', seats: '6', price: '0'),
      ],
      companyId: 'cccc1',
    ),
    RouteModel(
      arrivalLocation: 'Lagos',
      departureLocation: 'Enugu',
      departureTime: [
        DateTime(0, 0, 0, 6, 0),
        DateTime(0, 0, 0, 12, 0),
        DateTime(0, 0, 0, 18, 0),
      ],
      duration: DateTime(0, 0, 0, 12, 0),
      vehicles: [
        VehicleModel(type: 'Lorry', seats: '30', price: '25000'),
        VehicleModel(type: 'Sienna', seats: '6', price: '45000'),
      ],
      companyId: 'cccc1',
    ),
    RouteModel(
      arrivalLocation: 'Rivers',
      departureLocation: 'Enugu',
      departureTime: [
        DateTime(0, 0, 0, 6, 0),
        DateTime(0, 0, 0, 12, 0),
        DateTime(0, 0, 0, 18, 0),
      ],
      duration: DateTime(0, 0, 0, 5, 0),
      vehicles: [
        VehicleModel(type: 'Lorry', seats: '30', price: '1000'),
      ],
      companyId: 'cccc1',
    ),
    RouteModel(
      departureLocation: 'Enugu',
      arrivalLocation: 'Abuja',
      duration: DateTime(0, 0, 0, 8, 0),
      departureTime: [
        DateTime(0, 0, 0, 6, 0),
        DateTime(0, 0, 0, 12, 0),
        DateTime(0, 0, 0, 18, 0),
      ],
      vehicles: [
        VehicleModel(type: 'Bus', seats: '40', price: '15000'),
        VehicleModel(type: 'Car', seats: '4', price: '30000'),
      ],
      companyId: 'cccc2',
    ),
    RouteModel(
      departureLocation: 'Enugu',
      arrivalLocation: 'Lagos',
      duration: DateTime(0, 0, 0, 12, 0),
      departureTime: [
        DateTime(0, 0, 0, 6, 0),
        DateTime(0, 0, 0, 12, 0),
        DateTime(0, 0, 0, 18, 0),
      ],
      vehicles: [
        VehicleModel(type: 'Bus', seats: '40', price: '15000'),
        VehicleModel(type: 'Car', seats: '4', price: '30000'),
      ],
      companyId: 'cccc2',
    ),
    RouteModel(
      departureLocation: 'Enugu',
      arrivalLocation: 'Rivers',
      duration: DateTime(0, 0, 0, 5, 0),
      departureTime: [
        DateTime(0, 0, 0, 6, 0),
        DateTime(0, 0, 0, 12, 0),
        DateTime(0, 0, 0, 18, 0),
      ],
      vehicles: [
        VehicleModel(type: 'Bus', seats: '40', price: '15000'),
        VehicleModel(type: 'Car', seats: '4', price: '30000'),
      ],
      companyId: 'cccc2',
    ),
  ],
);
