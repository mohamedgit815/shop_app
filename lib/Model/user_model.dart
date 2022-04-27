
class UserModel {
  final String first , last , email , image , id , name;

  UserModel({
     required this.first , required this.last ,required this.name ,
    required this.email, required this.image, required this.id ,
  });

  factory UserModel.fromApp(Map<String,dynamic>map){
    return UserModel(
        first: map['first'],
        last: map['last'],
        email: map['email'] ,
        image: map['image'],
        id: map['id'] ,
        name: map['name'] ,
        // bio: map['bio'] ,
        // token: map['token'] ,
        // page: map['page']
    );
  }

  Map<String,dynamic> toApp()=>{
    'first' : first ,
    'last' : last ,
    'email' : email ,
    'image' : image ,
    'id' : id ,
    // 'bio': bio ,
    // 'token': token,
    // 'page': page
  };
}