class UserData {
  final String uid;
  final String email;
  final String? name;
  final String? photoURL;

  const UserData({
    required this.uid,
    required this.email,
    this.name,
    this.photoURL,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'email': email});
    if(name != null){
      result.addAll({'name': name});
    }
    if(photoURL != null){
      result.addAll({'photoURL': photoURL});
    }
  
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      photoURL: map['photoURL'],
    );
  }
}
