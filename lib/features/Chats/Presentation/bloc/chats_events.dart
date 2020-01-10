import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
@immutable
 abstract class ChatsEvents extends Equatable{
   ChatsEvents([List props = const <dynamic>[]]);

 }
 
 class FetchFavorite extends ChatsEvents{
  @override
  List<Object> get props => null;
}
 class FetchChats extends ChatsEvents{
  @override
  List<Object> get props => null;
}
 
 class FetchConversation extends ChatsEvents{
   FetchConversation(String id):super([id]);

  @override
  List<Object> get props => null;
 }
 class LikeChat extends ChatsEvents{
   LikeChat(String id):super([id]);

  @override
  List<Object> get props => null;
 }
 class DeleteChat extends ChatsEvents{
   DeleteChat(String id):super([id]);

  @override
  List<Object> get props => null;
 }
 class SendChat extends ChatsEvents{
   SendChat(String text):super([text]);

  @override
  List<Object> get props => null;
 }
 class DeleteConversation extends ChatsEvents{
   final String id;

  DeleteConversation(this.id);
  @override
  List<Object> get props => [id];
 }




