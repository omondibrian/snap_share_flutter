 import 'package:test_flutter/models/user_model.dart';

class Message {
   final User sender ;
   final String time ;
   final String text ;
   final bool isLiked;
   final bool unread;

  Message({
    this.sender, 
    this.time, 
    this.text, 
    this.isLiked, 
    this.unread
    });

 }

 // you the current user
 final User currentUser = User(
   id: 0,
   imageUrl: "assets/images/gondola.jpg",
   name: "Brian Omondi"
 );

 //other users
 final User sam = User(
   id: 1,
   imageUrl: "assets/images/murano.jpg",
   name: "sam"
 );
 final User james = User(
   id: 2,
   imageUrl: "assets/images/hotel1.jpg",
   name: "james"
 );
 final User atuti = User(
   id: 3,
   imageUrl: "assets/images/paris.jpg",
   name: "atuti"
 );
 final User olivia = User(
   id: 4,
   imageUrl: "assets/images/santorini.jpg",
   name: "olivia"
 );
 final User owidi = User(
   id: 5,
   imageUrl: "assets/images/newdelhi.jpg",
   name: "owidi"
 );
  final User loyse = User(
   id: 6,
   imageUrl: "assets/images/newyork.jpg",
   name: "loyse"
 );

 //favorites
 List<User> favorites = [atuti,owidi,james,olivia,sam,loyse];
 //example chats on home screen
 List<Message> chats =[
    Message(
      sender: atuti,
      text: "mambo babz",
      isLiked: true,
      time: "12:00 pm",
      unread: false
    ),
    Message(
      sender: currentUser,
      text: "morning",
      isLiked: false,
      time: "12:00 am",
      unread: true
    ),
    Message(
      sender: owidi,
      text: "oyaa boyz iweyo charger lapi ",
      isLiked: false,
      time: "18:00pm",
      unread: false
    ),Message(
      sender: olivia,
      text: "mambo brayoo",
      isLiked: true,
      time: "19:00pm",
      unread: true
    ),Message(
      sender: sam,
      text: "buda",
      isLiked: true,
      time: "19:00pm",
      unread: false
    ),Message(
      sender: james,
      text: "oyooo",
      isLiked: true,
      time: "19:00pm",
      unread: true
    ),Message(
      sender: loyse,
      text: "prayooo wa viatu",
      isLiked: true,
      time: "19:00pm",
      unread: false
    )
 ];
 //example messages in the chat screen
 List<Message> messages = [
       Message(
      sender: atuti,
      text: "mambo babz",
      isLiked: true,
      time: "12:00 pm",
      unread: false
    ),
    Message(
      sender: currentUser,
      text: "morning",
      isLiked: false,
      time: "12:00 am",
      unread: false
    ),
    Message(
      sender: owidi,
      text: "oyaa boyz iweyo charger lapi eeh lab",
      isLiked: false,
      time: "18:00pm",
      unread: false
    ),Message(
      sender: olivia,
      text: "mambo brayoo",
      isLiked: true,
      time: "19:00pm",
      unread: false
    ),Message(
      sender: sam,
      text: "buda",
      isLiked: true,
      time: "19:00pm",
      unread: false
    ),Message(
      sender: james,
      text: "oyooo",
      isLiked: true,
      time: "19:00pm",
      unread: false
    ),Message(
      sender: loyse,
      text: "prayooo wa viatu",
      isLiked: true,
      time: "19:00pm",
      unread: false
    )
 ];