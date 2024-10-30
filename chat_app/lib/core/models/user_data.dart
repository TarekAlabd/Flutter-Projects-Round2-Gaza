class UserData {
  final String uid;
  final String email;
  final String? name;
  final String photoUrl;
  final String password;

  const UserData({
    required this.uid,
    required this.email,
    this.name = 'Chat User',
    this.photoUrl = 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'email': email});
    if(name != null){
      result.addAll({'name': name});
    }
    result.addAll({'photoUrl': photoUrl});
    result.addAll({'password': password});
  
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      photoUrl: map['photoUrl'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
