import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
@immutable
 abstract class ChatsEvents extends Equatable{
   ChatsEvents([List props = const <dynamic>[]]):super(props);

 }

 class FetchFavorite extends ChatsEvents{}
 class FetchChats extends ChatsEvents{}
 
 class FetchConversation extends ChatsEvents{
   FetchConversation(String id):super([id]);
 }
 class LikeChat extends ChatsEvents{
   LikeChat(String id):super([id]);
 }
 class DeleteChat extends ChatsEvents{
   DeleteChat(String id):super([id]);
 }
 class SendChat extends ChatsEvents{
   SendChat(String text):super([text]);
 }
 class DeleteConversation extends ChatsEvents{
   DeleteConversation(String id):super([id]);
 }




