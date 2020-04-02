import 'package:built_value/built_value.dart';
import 'package:corona_trace/network/notification/response_notification_item.dart';

part 'notification_bloc_state.g.dart';

abstract class NotificationsBlocState
    implements Built<NotificationsBlocState, NotificationsBlocStateBuilder> {
  List<ResponseNotificationItem> get suggestions;

  bool get loading;

  int get pageNo;

  int get totalItems;

  bool isInitialLoading() {
    return pageNo == 0 && loading;
  }

  NotificationsBlocState._();

  factory NotificationsBlocState([updates(NotificationsBlocStateBuilder b)]) =
      _$NotificationsBlocState;
}
