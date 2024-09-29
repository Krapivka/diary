import 'package:bloc/bloc.dart';
import 'package:diary/core/services/ads/yandex_ads/open_ad/app_open_ad_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:diary/core/services/ads/ads_config.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
part 'app_open_ad_event.dart';
part 'app_open_ad_state.dart';

class AppOpenAdBloc extends Bloc<AppOpenAdEvent, AppOpenAdState> {
  final AppOpenAdManager appOpenAdManager;

  AppOpenAdBloc(this.appOpenAdManager) : super(AppOpenAdInitialState()) {
    on<LoadAppOpenAdEvent>(_onLoadAppOpenAd);
    on<ShowAppOpenAdEvent>(_onShowAppOpenAd);
    on<ShowAppOpenAdOnceEvent>(_onShowAppOpenAdOnce);
    on<ClearAppOpenAdEvent>(_onClearAppOpenAd);
  }

  Future<void> _onLoadAppOpenAd(
      LoadAppOpenAdEvent event, Emitter<AppOpenAdState> emit) async {
    emit(AppOpenAdLoadingState());
    try {
      await appOpenAdManager.loadAppOpenAd();
      add(ShowAppOpenAdEvent());
    } catch (e) {
      emit(AppOpenAdErrorState(e.toString()));
    }
  }

  Future<void> _onShowAppOpenAd(
      ShowAppOpenAdEvent event, Emitter<AppOpenAdState> emit) async {
    emit(AppOpenAdShowingState());
    await appOpenAdManager.showAdIfAvailable();
    emit(AppOpenAdInitialState());
  }

  Future<void> _onShowAppOpenAdOnce(
      ShowAppOpenAdOnceEvent event, Emitter<AppOpenAdState> emit) async {
    if (appOpenAdManager.isLoaded) {
      emit(AppOpenAdShowingState());
      await appOpenAdManager.showAdOnce();
      emit(AppOpenAdInitialState());
    }
  }

  Future<void> _onClearAppOpenAd(
      ClearAppOpenAdEvent event, Emitter<AppOpenAdState> emit) async {
    appOpenAdManager.clearAppOpenAd();
    emit(AppOpenAdInitialState());
  }
}
