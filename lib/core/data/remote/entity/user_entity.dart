
class UserEntity {
  final String? accessToken;

  UserEntity({
    this.accessToken,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      accessToken: json['accessToken'] as String?,
    );
  }
}
