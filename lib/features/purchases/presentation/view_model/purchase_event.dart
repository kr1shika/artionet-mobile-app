// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

part of 'purchase_bloc.dart';

sealed class PurchaseEvent extends Equatable {
  const PurchaseEvent();
  @override
  List<Object> get props => [];
}

class CreatePurchaseEvent extends PurchaseEvent {
  final BuildContext context;
  final String art_id;
  final String buyer_id;
  final String address;
  final String status;
  final String? otp;
  final DateTime? otp_expiration;
  final DateTime? orderDate;
  final int? totalAmount;

  const CreatePurchaseEvent({
    required this.context,
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.status,
    this.otp,
    this.otp_expiration,
    this.orderDate,
    this.totalAmount,
  });
  @override
  List<Object> get props => [art_id, buyer_id, address];
}

class VerifyPurchaseEvent extends PurchaseEvent {
  final String art_id;
  final String buyer_id;
  final String address;
  final String otp;

  const VerifyPurchaseEvent({
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.otp,
  });

  @override
  List<Object> get props => [art_id, buyer_id, address, otp];
}
