class Settings {
  String sId;
  int sAge1;
  int sAge2;
  int sDistance;
  String sGender;
  String sInterestedIn;
  String sMode;
  String sLat;
  String sLon;

  Settings({
    this.sId,
    this.sAge1,
    this.sAge2,
    this.sDistance,
    this.sGender,
    this.sInterestedIn,
    this.sMode,
    this.sLat,
    this.sLon
  });

  // to map
  Map<String, dynamic> toMap(Settings settings) {
    Map<String, dynamic> settingsMap = Map();
    settingsMap["sId"] = settings.sId;
    settingsMap["sAge1"] = settings.sAge1;
    settingsMap["sAge2"] = settings.sAge2;
    settingsMap["sDistance"] = settings.sDistance;
    settingsMap["sGender"] = settings.sGender;
    settingsMap["sInterestedIn"] = settings.sInterestedIn;
    settingsMap["sMode"] = settings.sMode;
    settingsMap["sLat"] = settings.sLat;
    settingsMap["sLon"] = settings.sLon;
    return settingsMap;
  }

  Settings.fromMap(Map settingsMap) {
    this.sId = settingsMap["sId"];
    this.sAge1 = settingsMap["sAge1"];
    this.sAge2 = settingsMap["sAge2"];
    this.sDistance = settingsMap["sDistance"];
    this.sGender = settingsMap["sGender"];
    this.sInterestedIn = settingsMap["sInterestedIn"];
    this.sMode = settingsMap["sMode"];
    this.sLat = settingsMap["sLat"];
    this.sLon = settingsMap["sLon"];
  }
}