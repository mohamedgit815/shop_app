class FavoriteModel {
  final String id , idProduct , idUser , name , image;

  const FavoriteModel({
    required this.id,
    required this.idProduct,
    required this.idUser,
    required this.name,
    required this.image
  });

  factory FavoriteModel.fromApp(Map<String,dynamic>map){
    return FavoriteModel(
        id: map['id'] ,
        idProduct: map['idProduct'] ,
        idUser: map['idUser'] ,
        name: map['name'] ,
        image: map['image']
    );
  }
}