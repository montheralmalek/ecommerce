import 'package:store/domain/entities/home_section.dart';

class HomeSectionApiModel {
  final HomeSectionType type;
  final String? title;
  final String? actionText;
  final String? targetId;
  const HomeSectionApiModel({
    required this.type,
    this.title,
    this.actionText,
    this.targetId,
  });
  factory HomeSectionApiModel.fromJson(Map<String, dynamic> json) {
    return HomeSectionApiModel(
      type: HomeSectionType.getByName(json['type'] as String),
      title: json['title'] as String?,
      actionText: json['actionText'] as String?,
      targetId: json['id'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'title': title,
      'actionText': actionText,
      'id': targetId,
    };
  }
}
