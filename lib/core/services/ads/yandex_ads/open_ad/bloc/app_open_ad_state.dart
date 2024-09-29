part of 'app_open_ad_bloc.dart';

abstract class AppOpenAdState extends Equatable {
  const AppOpenAdState();

  @override
  List<Object> get props => [];
}

class AppOpenAdInitialState extends AppOpenAdState {}

class AppOpenAdLoadingState extends AppOpenAdState {}

class AppOpenAdLoadedState extends AppOpenAdState {}

class AppOpenAdShowingState extends AppOpenAdState {}

class AppOpenAdErrorState extends AppOpenAdState {
  final String message;

  const AppOpenAdErrorState(this.message);

  @override
  List<Object> get props => [message];
}
