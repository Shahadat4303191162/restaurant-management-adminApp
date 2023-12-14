const String userId = 'id';
const String userEmail = 'name';


class UserModel{
  String? id,email;


  UserModel({
    this.id,
    this.email,
});


  Map<String,dynamic>toMap(){
    return<String,dynamic>{
      userId : id,
      userEmail: email,

    };
  }

  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
        id: map[userId],
        email: map[userEmail],
    );
  }
}