// ignore_for_file: public_member_api_docs, sort_constructors_first
 
class Status {
  final String uid;
  final String userName;
  final String phoneNumber;
  final String profilePic;
  final String statusId;
  final List<String> photoUrl;
  final List<String> whoCanSee;
  final DateTime createAt;

  Status({
    required this.uid,
    required this.userName,
    required this.phoneNumber,
   required this.profilePic,
   required  this.statusId,
   required  this.photoUrl,
   required this.whoCanSee,
  required  this.createAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidl': uid,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'statusId': statusId,
      'photoUrl': photoUrl,
      'whoCanSee': whoCanSee,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePic: map['profilePic'] as String,
      statusId: map['statusId'] as String,
      photoUrl: List<String>.from(map['photoUrl'] as List<String>),
      whoCanSee: List<String>.from(map['whoCanSee'] as List<String>),
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
    );
  }

  
}
