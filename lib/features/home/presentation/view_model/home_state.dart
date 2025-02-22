import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/features/artwork/presentation/view/search_view.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/home/presentation/view/buyer/pages/dashboard_view.dart';
import 'package:tryproject/features/home/presentation/view/buyer/pages/notification_view.dart';
import 'package:tryproject/features/profiles/view/customerProfileView.dart';
import 'package:tryproject/features/profiles/view_model/profile_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        const HomeScreen(),
        BlocProvider(
          create: (context) => getIt<ArtworkBloc>(),
          child: const SearchView(),
        ),
        // Pass the PurchaseBloc here
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
          child: const CustomerProfileView(
            userId: '679cb11ed81a6e1b96420af0',
          ),
        ),
        const NotificationsView(),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
