import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';
@immutable
 abstract class ChatsState extends Equatable{
   ChatsState([List props = const <dynamic>[]]):super(props);

 }
class Empty extends ChatsState {}
class Loading extends ChatsState {}
class LoadingUsers extends ChatsState {
  final List<String>userIds;

  LoadingUsers({@required this.userIds}):super([userIds]);
 
}
class UserLoaded extends ChatsState{
 final List<User> users;

  UserLoaded(this.users);
}
class Loaded extends ChatsState{
  final List<Chats> chats;

  Loaded(this.chats);
}
class Error extends ChatsState{
  final List<Chats> message;

  Error(this.message);
}
 