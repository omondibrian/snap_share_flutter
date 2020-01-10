import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String id;
  final String name;
  final String imageUrl;

  User({this.id, this.name, this.imageUrl});

  @override
  
  List<Object> get props => [id,name,imageUrl];

}
class Auth extends User {
  final String token;
  final  User user; 
  Auth(this.token, this.user);
}