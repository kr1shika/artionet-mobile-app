import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/purchases/domain/use_case/GetPurchasesByUserIdUsecase.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/profiles/view_model/profile_bloc.dart';

class FetchPurchases {
  final ProfileBloc profileBloc;
  final GetPurchasesByUserIdUsecase getPurchasesByUserIdUsecase;

  FetchPurchases({
    required this.profileBloc,
    required this.getPurchasesByUserIdUsecase,
  });

  void fetch(String userId) {
    profileBloc.add(FetchPurchasesByUserId(userId: userId));
  }
}
