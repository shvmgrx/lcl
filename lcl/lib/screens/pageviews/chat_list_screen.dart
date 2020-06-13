import 'package:flutter/material.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/utils/strings.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/utils/utilities.dart';
import 'package:lcl/utils/uniColors.dart';
import 'package:lcl/widgets/CustomAppBar.dart';
import 'package:lcl/widgets/CustomTile.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

//global
final FirebaseRepository _repository = FirebaseRepository();

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUserId;
  String initials;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((user) {
      setState(() {
        currentUserId = user.uid;
        initials = Utils.getInitials(user.displayName);
      });
    });
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: uniColors.lcRed,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: UserCircle(initials),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: uniColors.lcRed,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uniColors.backgroundGrey,
      appBar: customAppBar(context),
      body: ChatListContainer(currentUserId),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  final String currentUserId;

  ChatListContainer(this.currentUserId);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 2,
        itemBuilder: (context, index) {
          return CustomTile(
            mini: false,
            onTap: () {},
            title: Text(
              "Test user",
              style: TextStyle(
                  color: uniColors.standardBlack,
                  fontFamily: "Raleway",
                  fontSize: 16),
            ),
            subtitle: Text(
              "First message",
              style: TextStyle(
                color: uniColors.standardBlack,
                fontSize: 14,
              ),
            ),
            leading: Container(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/36469/woman-person-flowers-wreaths.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: uniColors.online,
                          border: Border.all(
                              color: uniColors.standardBlack, width: 1)),
                    ),
                  )
                ],
              ),
            ),
            trailing: Container(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: uniColors.standardWhite,
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.video_call,
                          size:20,
                          color: uniColors.lcRed,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    //backgroundImage: NetworkImage("https://images.pexels.com/photos/36469/woman-person-flowers-wreaths.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserCircle extends StatelessWidget {
  final String text;

  UserCircle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.APP_NAME,
      style: TextStyles.appNameTextStyle,
    );
    // return Container(
    //   height: 40,
    //   width: 40,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(50),
    //     color: uniColors.lcRedLight,
    //   ),
    //   child: Stack(
    //     children: <Widget>[
    //       Align(
    //         alignment: Alignment.center,
    //         child: Text(
    //           text,
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             color: uniColors.lcRed,
    //             fontSize: 13,
    //           ),
    //         ),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomRight,
    //         child: Container(
    //           height: 12,
    //           width: 12,
    //           decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               border: Border.all(
    //                   color: uniColors.standardBlack, width: 2),
    //               color: uniColors.gold2),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
