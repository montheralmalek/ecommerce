class BannerModel {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? actionText;
  final String? targetId;
  final int? color;

  BannerModel({
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.actionText,
    this.targetId,
    this.color,
  });
  factory BannerModel.onLoading() {
    return BannerModel(
      imageUrl: '',
      title: null,
      subtitle: null,
      actionText: null,
      targetId: null,
      color: null,
    );
  }
  bool get hasAction => actionText != null && actionText!.isNotEmpty;
  bool get hasTargetId => targetId != null && targetId!.isNotEmpty;
}
