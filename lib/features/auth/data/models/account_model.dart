import 'package:carto/features/auth/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  AccountModel({
    required super.id,
    required super.name,
    required super.email,
    required super.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatarUrl": avatarUrl,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      avatarUrl: map["avatarUrl"],
    );
  }
}
