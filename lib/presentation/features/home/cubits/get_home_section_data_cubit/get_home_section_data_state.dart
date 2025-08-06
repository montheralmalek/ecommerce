part of 'get_home_section_data_cubit.dart';

@immutable
abstract class GetHomeSectionDataState {}

class GetHomeSectionDataInitial extends GetHomeSectionDataState {}

class GetHomeSectionDataLoading extends GetHomeSectionDataState {}

class GetHomeSectionDataLoaded extends GetHomeSectionDataState {
  final HomeSection section;

  GetHomeSectionDataLoaded(this.section);
}

class GetHomeSectionDataError extends GetHomeSectionDataState {
  final String message;

  GetHomeSectionDataError(this.message);
}
