part of 'app_open_ad_bloc.dart';

abstract class AppOpenAdEvent extends Equatable {
  const AppOpenAdEvent();

  @override
  List<Object> get props => [];
}

class LoadAppOpenAdEvent extends AppOpenAdEvent {}

class ShowAppOpenAdEvent extends AppOpenAdEvent {}

class ShowAppOpenAdOnceEvent extends AppOpenAdEvent {}

class ClearAppOpenAdEvent extends AppOpenAdEvent {}
