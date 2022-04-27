class HomeModel {
  final String name , image , id;

  const HomeModel({required this.name,required this.image,required this.id});

  factory HomeModel.fromApp(Map<String,dynamic>map) {
    return HomeModel(
        name: map['name'],
        image: map['image'],
        id: map['_id']
    );
  }
}