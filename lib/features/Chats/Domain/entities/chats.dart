
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Chats  extends Equatable{
   final int senderId ;
   final String text ;
   final bool isLiked ;
   final String time ;
   final bool unread;
   final String id ;

  Chats({
    @required this.senderId,
    @required this.unread, 
    @required this.text, 
    @required this.isLiked, 
    @required this.time,
    @required this.id}):super([text,isLiked,time]);
}