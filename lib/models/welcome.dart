class WelcomeItem {

  final String image;
  final int index;
  WelcomeItem({required this.image, required this.index});

  factory WelcomeItem.fromJson(Map<String, dynamic> json) =>
      WelcomeItem(image: json["image"], index: json["index"]);
}
