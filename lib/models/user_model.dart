// ignore_for_file: public_member_api_docs, sort_constructors_first

//you can't name it User without overriding it when you using firebase beacuse there s already
//a defined one in firebase with the name User
class UserModel {
  final String name;
  final String uidl;
  final String profilePic;
  final bool isOnlie;
  final String phoneNumber;
  final List<String> groupId;

  UserModel({
    required this.groupId,
    required this.isOnlie,
    required this.name,
    required this.phoneNumber,
    required this.profilePic,
    required this.uidl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uidl': uidl,
      'profilePic': profilePic,
      'isOnlie': isOnlie,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uidl: map['uidl'] as String,
      profilePic: map['profilePic'] as String,
      isOnlie: map['isOnlie'] as bool,
      phoneNumber: map['phoneNumber'] as String,
      groupId: List<String>.from(
        (map['groupId'] as List<String>),
      ),
    );
  }
}
