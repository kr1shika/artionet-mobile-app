import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/features/artwork/presentation/view/search_view.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/home/presentation/view/buyer/pages/dashboard_view.dart';
import 'package:tryproject/features/profiles/presentation/view/profileView.dart';
import 'package:tryproject/features/profiles/presentation/view/notificationView.dart';
import 'package:tryproject/features/profiles/presentation/view/orders/purchases_orders_view.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final String? userId;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
    this.userId,
  });

  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      views: [],
      userId: null, // Initially null, to be updated later
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    String? userId,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: [
        const HomeScreen(),
        BlocProvider(
          create: (context) => getIt<ArtworkBloc>(),
          child: const SearchView(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
          child: CustomerProfileView(
              userId: (userId ?? this.userId) ?? 'defaultUserId'),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
          child: NotificationsView(
              userId: (userId ?? this.userId) ?? 'defaultUserId'),
        ),
        BlocProvider(
          create: (context) => getIt<PurchaseBloc>(),
          child: PurchasesOrdersView(
            userId: (userId ?? this.userId) ?? 'defaultUserId',
            artistId: (userId ?? this.userId) ??
                'defaultArtistId', // Assuming artistId is also the same
          ),
        ),
      ],
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, userId, views];
}
