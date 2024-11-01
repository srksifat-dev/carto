class RegistrationReq{
  final String email;
  final String name;
  final String password;
  final String avatarUrl;

  const RegistrationReq({
    required this.email,
    required this.name,
    required this.password,
    required this.avatarUrl,
  });
}