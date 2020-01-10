import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_flutter/features/Chats/Domain/entities/chats.dart';
import 'package:test_flutter/features/signUp_signIn/Domain/entities/Users.dart';
@immutable
 abstract class ChatsState extends Equatable{
   ChatsState([List props = const <dynamic>[]]);

 }   
class Empty extends ChatsState {
  @override
  List<Object> get props => null;
}
class Loading extends ChatsState {
  @override
  List<Object> get props => null;
}
class LoadingUsers extends ChatsState {
  final List<String>userIds;

  LoadingUsers({@required this.userIds});

  @override
  List<Object> get props => [userIds];
 
}
class UserLoaded extends ChatsState{
 final List<User> users;

  UserLoaded(this.users);

  @override
  List<Object> get props => [users];
}
class Loaded extends ChatsState{
  final List<Chats> chats;

  Loaded(this.chats);

  @override
  List<Object> get props => [chats];
}
class Error extends ChatsState{
  final List<Chats> message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}
 