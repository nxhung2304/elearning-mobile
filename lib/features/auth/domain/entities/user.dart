class User {
  int id;
  String email;
  String? name;
  String status;

  User({
    required this.id,
    required this.email,
    required this.status,
    this.name,
  });
}
