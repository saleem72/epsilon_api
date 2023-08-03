//

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppUserDTO extends Equatable {
  const AppUserDTO({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.plan,
    required this.tables,
    required this.profileImage,
    required this.isNotify,
    required this.defaultLanguage,
    required this.defaultCurrency,
  });

  final int id;
  final String fullName;
  final String email;
  final String role;
  final int isActive;
  final DateTime emailVerifiedAt;
  final String plan;
  final dynamic tables;
  final dynamic profileImage;
  final int isNotify;
  final String defaultLanguage;
  final String defaultCurrency;

  @override
  List<Object?> get props => [id];

  factory AppUserDTO.fromJson(Map<String, dynamic> json) => AppUserDTO(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        role: json["role"],
        isActive: json["is_active"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        plan: json["plan"],
        tables: json["tables"],
        profileImage: json["profile_image"],
        isNotify: json["is_notify"],
        defaultLanguage: json["default_language"],
        defaultCurrency: json["default_currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "role": role,
        "is_active": isActive,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "plan": plan,
        "tables": tables,
        "profile_image": profileImage,
        "is_notify": isNotify,
        "default_language": defaultLanguage,
        "default_currency": defaultCurrency,
      };
}
