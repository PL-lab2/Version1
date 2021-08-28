import 'package:Sociio/models/user_model.dart';

class Message {
  final String content;
  final DateTime time;
  final User sender;
  final bool hasRead;

  Message({this.content, this.time, this.sender, this.hasRead = true});
}

final List<Message> recentChats = [
  Message(
      content: 'I dont know. What do you think?',
      time: DateTime.now(),
      sender: u1,
      hasRead: false),
  Message(
      content: 'What brings you here today?',
      time: DateTime.now(),
      sender: u2,
      hasRead: false),
  Message(
      content: 'hi! how are you! Im fine',
      time: DateTime.now(),
      sender: u3,
      hasRead: false),
  Message(
      content: 'Thank you. That was really helpful.',
      time: DateTime.now(),
      sender: u4,
      hasRead: false),
];

final List<Message> messages = [
  Message(
      content: 'Im not keeping you from something, am I?',
      time: DateTime.now(),
      sender: u1),
  Message(
      content:
          'Sorry for taking up so much of your time. Do you need to take off?',
      time: DateTime.now(),
      sender: currentUser),
  Message(
      content: 'I really enjoyed our chat. Thanks so much.',
      time: DateTime.now(),
      sender: u1),
  Message(
      content:
          'I had a great time talking with you. Hope to see you again soon',
      time: DateTime.now(),
      sender: currentUser),
  Message(
      content:
          'I just realised you are probably in the middle of something. Do you have time to chat?',
      time: DateTime.now(),
      sender: u1),
  Message(
      content:
          'Let me know if you need to get going. I dont want to take up all your time.',
      time: DateTime.now(),
      sender: u1)
];
