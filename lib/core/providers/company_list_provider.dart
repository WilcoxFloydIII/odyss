import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/data/models/company_model.dart';

final partnerListProvider = Provider<List<PartnerModel>>(
  (ref) => [
    PartnerModel(
      name: 'Peace Mass Transit', id: 'cccc1', picture: '',
    ),
    PartnerModel(
      name: 'God Is Good Motors', id: 'cccc2', picture: '',
    ),
  ],
);
