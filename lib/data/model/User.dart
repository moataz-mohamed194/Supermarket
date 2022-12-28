
class User{
  final int id;
  final String name;
  final String email;
  final String password;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, email: $email, password: $password}';
  }

}
