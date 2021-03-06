import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lcl/constants/constantStrings.dart';
import 'package:lcl/enum/view_state.dart';
import 'package:lcl/models/message.dart';
import 'package:lcl/models/user.dart';
import 'package:lcl/provider/image_upload_provider.dart';
import 'package:lcl/resources/chat_methods.dart';
import 'package:lcl/resources/firebase_repository.dart';
import 'package:lcl/screens/chatScreens/widgets/cached_image.dart';
import 'package:lcl/utils/call_utilities.dart';
import 'package:lcl/utils/permissions.dart';
import 'package:lcl/utils/text_styles.dart';
import 'package:lcl/utils/utilities.dart';
import 'package:lcl/widgets/CustomAppBar.dart';


import 'package:lcl/utils/uniColors.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;
  

  ChatScreen({this.receiver});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textFieldController = TextEditingController();
  FirebaseRepository _repository = FirebaseRepository();

    final ChatMethods _chatMethods = ChatMethods();

  bool isWriting = false;
  User sender;

   String _currentUserId;

   ImageUploadProvider _imageUploadProvider;
 @override
  void initState() {  
    super.initState();

    _repository.getCurrentUser().then((user) {
      _currentUserId = user.uid;

      setState(() {
        sender = User(
          uid: user.uid,
          name: user.displayName,
          profilePhoto: user.photoUrl,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
     _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return Scaffold(
      backgroundColor: uniColors.backgroundGrey,
      appBar: customAppBar(context),
      body: Column(
        children: <Widget>[
          Flexible(
            child: messageList(),
          ),
          _imageUploadProvider.getViewState == ViewState.LOADING
              ? Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 15),
                  child: CircularProgressIndicator(),
                )
              : Container(),
          chatControls(),
        ],
      ),
    );
  }

  Widget messageList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(MESSAGES_COLLECTION)
          .document(_currentUserId)
          .collection(widget.receiver.uid)
          .orderBy(TIMESTAMP_FIELD, descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data.documents.length,
           reverse: true,
          itemBuilder: (context, index) {
            // mention the arrow syntax if you get the time
            return chatMessageItem(snapshot.data.documents[index]);
          },
        );
      },
    );
  }


   Widget chatMessageItem(DocumentSnapshot snapshot) {
    Message _message = Message.fromMap(snapshot.data);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: _message.senderId == _currentUserId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: _message.senderId == _currentUserId
            ? senderLayout(_message)
            : receiverLayout(_message),
      ),
    );
  }



  Widget senderLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: uniColors.senderColor,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }

  getMessage(Message message) {
    return message.type != MESSAGE_TYPE_IMAGE
        ? Text(
            message.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          )
        : message.photoUrl != null
            ? CachedImage(
                message.photoUrl,
                height: 250,
                width: 250,
                radius: 10,
              )
            : Text("Url was null");
  }

  Widget receiverLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: uniColors.receiverColor,
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }

  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }


    sendMessage() {
      var text = textFieldController.text;

      Message _message = Message(
        receiverId: widget.receiver.uid,
        senderId: sender.uid,
        message: text,
        timestamp: Timestamp.now(),
        type: 'text',
      );

      setState(() {
        isWriting = false;
      });

      textFieldController.text = "";

      _chatMethods.addMessageToDb(_message, sender, widget.receiver);
    }



    // addMediaModal(context) {
    //   showModalBottomSheet(
    //       context: context,
    //       elevation: 0,
    //       backgroundColor: uniColors.standardBlack,
    //       builder: (context) {
    //         return Column(
    //           children: <Widget>[
    //             Container(
    //               padding: EdgeInsets.symmetric(vertical: 15),
    //               child: Row(
    //                 children: <Widget>[
    //                   FlatButton(
    //                     child: Icon(
    //                       Icons.close,
    //                     ),
    //                     onPressed: () => Navigator.maybePop(context),
    //                   ),
    //                   Expanded(
    //                     child: Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: Text(
    //                         "Content and tools",
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 20,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
                // Flexible(
                //   child: ListView(
                //     children: <Widget>[
                //       ModalTile(
                //         title: "Media",
                //         subtitle: "Share Photos and Video",
                //         icon: Icons.image,
                //       ),
                //       ModalTile(
                //         title: "File",
                //         subtitle: "Share files",
                //         icon: Icons.tab),
                //     ModalTile(
                //         title: "Contact",
                //         subtitle: "Share contacts",
                //         icon: Icons.contacts),
                //     ModalTile(
                //         title: "Location",
                //         subtitle: "Share a location",
                //         icon: Icons.add_location),
                //     ModalTile(
                //         title: "Schedule Call",
                //         subtitle: "Arrange a skype call and get reminders",
                //         icon: Icons.schedule),
                //     ModalTile(
                //         title: "Create Poll",
                //         subtitle: "Share polls",
                //         icon: Icons.poll)
                //     ],
                //   ),
                // ),
    //           ],
    //         );
    //       });
    // }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          // GestureDetector(
          //   onTap: () => addMediaModal(context),
          //   child: Container(
          //     padding: EdgeInsets.all(5),
          //     decoration: BoxDecoration(
          //       gradient: uniColors.fabGradient,
          //       shape: BoxShape.circle,
          //     ),
          //     child: Icon(Icons.add),
          //   ),
          // ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              controller: textFieldController,
              style: TextStyle(
                color: uniColors.standardBlack,
              ),
              onChanged: (val) {
                (val.length > 0 && val.trim() != "")
                    ? setWritingTo(true)
                    : setWritingTo(false);
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(
                  color: uniColors.grey2,
                ),
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                    borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: uniColors.standardWhite,
                // suffixIcon: GestureDetector(
                //   onTap: () {},
                //   child: Icon(Icons.face),
                // ),
              ),
            ),
          ),
          // isWriting
          //     ? Container()
          //     : Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 10),
          //         child: Icon(Icons.record_voice_over),
          //       ),
          isWriting
              ? Container()
              : GestureDetector(
                  child: Icon(Icons.camera_alt),
                  onTap: () => pickImage(source: ImageSource.gallery),
                ),
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      gradient: uniColors.fabGradient,
                      shape: BoxShape.circle),
                  child: InkWell(
                      child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color:uniColors.standardWhite,
                        size: 15,
                      ),
                      //onPressed: () => {},
                    ),
                     onTap: () => sendMessage(),
                  ))
              : Container()
        ],
      ),
    );
  }

  void pickImage({@required ImageSource source}) async {
    File selectedImage = await Utils.pickImage(source: source);
    _repository.uploadImage(
        image: selectedImage,
        receiverId: widget.receiver.uid,
        senderId: _currentUserId,
        imageUploadProvider: _imageUploadProvider);
  }


          
  CustomAppBar customAppBar(context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: uniColors.lcRed,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Row(
        children: <Widget>[
          CircleAvatar(
                    maxRadius: 22,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "${widget.receiver.profilePhoto}"),
                  ),
          Padding(
            padding: const EdgeInsets.only(left:5),
            child: Text(
              widget.receiver.name == null? "":  widget.receiver.name,

              style: TextStyles.chatScreenNameTextStyle,
              // : widget.receiver.name,
            ),
          ),
        ],
      ),
      actions: <Widget>[

                IconButton(
          icon: Icon(
            CupertinoIcons.video_camera,
            color:uniColors.lcRed
          ),
          onPressed: () async =>
              await Permissions.cameraAndMicrophonePermissionsGranted()
                  ? CallUtils.dial(
                      from: sender,
                      to: widget.receiver,
                      context: context,
                    )
                  : {},
        ),
        // IconButton(
        //   icon: Icon(
        //     Icons.phone,
        //   ),
        //   onPressed: () {},
        // )
      ],
    );
  }
}

// class ModalTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;

//   const ModalTile({
//     @required this.title,
//     @required this.subtitle,
//     @required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       child: CustomTile(
//         mini: false,
//         leading: Container(
//           margin: EdgeInsets.only(right: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: uniColors.lcRed,
//           ),
//           padding: EdgeInsets.all(10),
//           child: Icon(
//             icon,
//             color: uniColors.grey2,
//             size: 38,
//           ),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: TextStyle(
//             color: uniColors.grey2,
//             fontSize: 14,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     );
//   }
// }