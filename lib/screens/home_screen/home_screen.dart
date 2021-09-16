import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Sociio/screens/home_screen/components/chat_screen.dart';
import 'package:Sociio/common/styles.dart';
import 'package:Sociio/models/message.dart';
import 'package:Sociio/screens/home_screen/components/avatar.dart';
import 'package:Sociio/models/user_model.dart';
import 'package:Sociio/methods.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home_screen";
  MainHomePage createState() => MainHomePage();
}

class MainHomePage extends State<HomeScreen> {
  static String routeName = "/home_screen";

  bool isSearching = false;
  String myName, myProfilePic, myUserName, myEmail;
  Stream usersStream, chatRoomsStream;

  TextEditingController searchUsernameEditingController =
      TextEditingController();

  Widget buildUserAvatar(User user) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 6.0),
      child: Column(
        children: <Widget>[
          Avatar(
            url: user.imgUrl,
            isOnline: user.isOnline,
          ),
          SizedBox(
            height: 4.0,
          ),
          Container(
            width: 64.0,
            child: Text(
              user.name.split(' ')[0],
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: textColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRecentChat(Message message, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              sender: message.sender,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Avatar(
              url: message.sender.imgUrl,
              isOnline: message.sender.isOnline,
            ),
            SizedBox(width: 8.0),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender.name,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.0),
                Text(message.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: message.hasRead
                            ? textColor.withOpacity(.4)
                            : textColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400))
              ],
            )),
            SizedBox(width: 8.0),
            Text(
              formatTime('0' + message.time.hour.toString()) +
                  ':' +
                  formatTime('0' + message.time.minute.toString()),
              style:
                  TextStyle(color: textColor.withOpacity(.6), fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }

  String formatTime(String time) {
    return time.substring(time.length - 2);
  }

  getChatRoomIdByNames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await getUserByName(searchUsernameEditingController.text);
  }

  Widget searchListUserTile({String profileUrl, name, username, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByNames(myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };
        createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            this.context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                profileUrl,
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(name), Text(email)])
          ],
        ),
      ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return searchListUserTile(
                      profileUrl: ds["imgUrl"],
                      name: ds["name"],
                      email: ds["email"],
                      username: ds["username"]);
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: background,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                children: [
                  Text("Sociio",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      logOut(context);
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
            ),

            // search

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    color: background,
                    boxShadow: softShadowsInvert,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            boxShadow: softShadows,
                            color: background,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.search,
                          size: 16.0,
                          color: Theme.of(context).primaryColor,
                        )),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: textColor, fontSize: 16.0),
                        decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle:
                                TextStyle(color: textColor.withOpacity(0.6)),
                            filled: false,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 12.0)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (searchUsernameEditingController.text != "") {
                          onSearchBtnClick();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),

            // List User

            // Container(
            //   height: 100.0,
            //   child: Center(
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: favoriteUsers.length,
            //         itemBuilder: (BuildContext ctx, int index) =>
            //             buildUserAvatar(favoriteUsers[index])),
            //   ),
            // ),

            // recents
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, int index) =>
                  buildRecentChat(recentChats[index], context),
            ))
          ],
        ),
      ),
    ));
  }
}
