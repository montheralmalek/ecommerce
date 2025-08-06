class AdBannerModel {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? actionText;
  final String? targetId;
  @Deprecated('not used')
  final int? color;

  const AdBannerModel({
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.actionText,
    this.targetId,
    this.color,
  });
  factory AdBannerModel.fromJson(Map<String, dynamic> json) {
    return AdBannerModel(
      imageUrl: json['image_url'] as String,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      // actionText: json['actionText'] as String?,
      targetId: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      // 'actionText': actionText,
      'id': targetId,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdBannerModel &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl &&
          title == other.title &&
          subtitle == other.subtitle &&
          actionText == other.actionText &&
          targetId == other.targetId;

  @override
  int get hashCode =>
      imageUrl.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      actionText.hashCode ^
      targetId.hashCode;
}
