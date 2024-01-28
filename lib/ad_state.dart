import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' // Your AdMob Android ad unit ID
      : 'ca-app-pub-3940256099942544/2934735716'; // Your AdMob iOS ad unit ID

  BannerAdListener get listener => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded: ${ad.adUnitId}.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      print('Ad failed to load: ${ad.adUnitId}, $error');
      ad.dispose();
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened: ${ad.adUnitId}.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed: ${ad.adUnitId}.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression: ${ad.adUnitId}.'),
  );

}
