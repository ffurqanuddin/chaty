


class ChatUserModel {
  ChatUserModel({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.email,
    required this.pushToken,
    required this.blueTick,
    required this.blueTickColor,
    required this.themeValue,
  });
  late final String image;
  late final String about;
  late final String name;
  late final String createdAt;
  late final bool isOnline;
  late final String id;
  late final String lastActive;
  late final String email;
  late final String pushToken;
  late final bool blueTick;
  late final String blueTickColor;
  late final int themeValue;

  ChatUserModel.fromJson(Map<String, dynamic> json){
    image = json['image']??" ";
    about = json['about']??"";
    name = json['name']??" ";
    createdAt = json['created_at']??" ";
    isOnline = json['is_online'];
    id = json['id'];
    lastActive = json['last_active']??" ";
    email = json['email'];
    pushToken = json['push_token']??" ";
    blueTick = json['blue_tick'];
    blueTickColor = json['blue_tick_color']??" ";
    themeValue = json['theme_value']??0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['blue_tick'] = blueTick;
    data['blue_tick_color'] = blueTickColor;
    data['theme_value'] = themeValue??0;
    return data;
  }
}