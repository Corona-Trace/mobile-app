import 'package:corona_trace/analytics/CTAnalyticsEvents.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class CTAnalyticsManager {
  FirebaseAnalytics _analytics;
  FirebaseAnalyticsObserver _firebaseAnalyticsObserver;

  static final CTAnalyticsManager _instance = CTAnalyticsManager._internal();

  factory CTAnalyticsManager() => _instance;

  static CTAnalyticsManager get instance => _instance;

  CTAnalyticsManager._internal() {
    _analytics = FirebaseAnalytics();
    _firebaseAnalyticsObserver =
        FirebaseAnalyticsObserver(analytics: _analytics);
  }

  FirebaseAnalytics getFBAnalytics() => _analytics;

  FirebaseAnalyticsObserver getFBAnalyticsObserver() =>
      _firebaseAnalyticsObserver;

  logPermissionsGranted() {
    _logEventInternal(CTAnalyticsEvents.PERMISSIONS_GRANTED_INITIAL);
  }

  void logClickTermsAndConditions() {
    _logEventInternal(CTAnalyticsEvents.CLICK_TERMS_CONDITIONS);
  }

  void logClickPrivacyPolicy() {
    _logEventInternal(CTAnalyticsEvents.CLICK_PRIVACY_POLICY);
  }

  void _logEventInternal(eventName) {
    getFBAnalytics().logEvent(name: eventName).catchError((error) {
      print(error);
    });
  }

  void setFirstSeverityCheck(int severity) {
    _logEventInternal(CTAnalyticsEvents.EVENT_first_check_in);
  }

  void setSeverityCheck(int severity) {
    _logEventInternal(CTAnalyticsEvents.EVENT_update_check_in);
  }
}
