class User {
  final int id;
  final String petName;
  final String photo;
  final String address;

  const User({
    required this.id,
    this.petName = '',
    this.photo = '',
    required this.address,
  });

  static const empty = User(id: 0, address: '');
}
