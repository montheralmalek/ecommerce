class AdBanner {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? actionText;
  final String targetId;
  @Deprecated('not used')
  final int? color;

  AdBanner({
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.actionText,
    required this.targetId,
    this.color,
  });
  factory AdBanner.onLoading() {
    return AdBanner(
      imageUrl: '',
      title: null,
      subtitle: null,
      actionText: null,
      targetId: 'null',
      color: null,
    );
  }
  bool get hasAction => actionText != null && actionText!.isNotEmpty;
}
