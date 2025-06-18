import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/data/models/company_model.dart';

final partnerListProvider = Provider<List<PartnerModel>>(
  (ref) => [
    PartnerModel(
      name: 'Peace Mass Transit',
      vehicles: [
        VehicleModel(type: 'Bus', seats: '11', price: '18000'),
        VehicleModel(type: 'Lorry', seats: '32', price: '12000'),
      ],
      locations: ['Enugu', 'Lagos', 'Abuja'],
    ),
    PartnerModel(
      name: 'God Is Good Motors',
      vehicles: [
        VehicleModel(type: 'Bus', seats: '11', price: '20000'),
        VehicleModel(type: 'Sienna', seats: '6', price: '40000'),
      ],
      locations: ['Enugu', 'Lagos', 'Abuja'],
    ),
  ],
);
