// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      full_name: json['full_name'] as String,
      contact_no: json['contact_no'] as String,
      password: json['password'] as String?,
      role: json['role'] as String,
      profilepic: json['profilepic'] as String?,
      artistname: json['artistname'] as String?,
      desc: json['desc'] as String?,
      email: json['email'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'full_name': instance.full_name,
      'contact_no': instance.contact_no,
      'password': instance.password,
      'role': instance.role,
      'profilepic': instance.profilepic,
      'artistname': instance.artistname,
      'desc': instance.desc,
      'email': instance.email,
    };
