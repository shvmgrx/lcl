class Settings {
  String sId;
  int sAge;
  int sDistance;
  String sGender;
  String sInterestedIn;
  String sMode;
  String sLocation;

  Settings({
    this.sId,
    this.sAge,
    this.sDistance,
    this.sGender,
    this.sInterestedIn,
    this.sMode,
    this.sLocation,
  });

  // to map
  Map<String, dynamic> toMap(Settings settings) {
    Map<String, dynamic> settingsMap = Map();
    settingsMap["sId"] = settings.sId;
    settingsMap["sAge"] = settings.sAge;
    settingsMap["sDistance"] = settings.sDistance;
    settingsMap["sGender"] = settings.sGender;
    settingsMap["sInterestedIn"] = settings.sInterestedIn;
    settingsMap["sMode"] = settings.sMode;
    settingsMap["sLocation"] = settings.sLocation;
    return settingsMap;
  }

  Settings.fromMap(Map settingsMap) {
    this.callerId = callMap["caller_id"];
    this.callerName = callMap["caller_name"];
    this.callerPic = callMap["caller_pic"];
    this.receiverId = callMap["receiver_id"];
    this.receiverName = callMap["receiver_name"];
    this.receiverPic = callMap["receiver_pic"];
    this.channelId = callMap["channel_id"];
    this.hasDialled = callMap["has_dialled"];
  }
}