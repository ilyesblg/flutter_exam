class User {
  String id;
  String username;
  String password;
  double balance;

  User({
    this.id = '',
    required this.username,
    required this.password,
    this.balance = 0,
  });
}
