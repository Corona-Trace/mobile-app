import 'dart:async';

import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui/notifications/blocs/notification_bloc_event.dart';
import 'package:corona_trace/ui/notifications/blocs/notification_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CTNotificationsBloc
    extends Bloc<NotificationsBloEvent, NotificationsBlocState> {
  @override
  NotificationsBlocState get initialState => NotificationsBlocState((b) => b
    ..pageNo = 0
    ..totalItems = 10
    ..suggestions = []
    ..loading = true);

  @override
  Stream<NotificationsBlocState> mapEventToState(
      NotificationsBloEvent event) async* {
    switch (event) {
      case NotificationsBloEvent.fetch:
        yield* _fetchNotificationsInternal();
        break;

      case NotificationsBloEvent.fetchMore:
        yield* _fetchNotificationsInternal(pageNo: state.pageNo + 1);
        break;
    }
  }

  Stream<NotificationsBlocState> _fetchNotificationsInternal(
      {int pageNo = 0}) async* {
    yield state.rebuild((b) => b
      ..loading = true
      ..suggestions = []
      ..pageNo = pageNo);

    var notifications =
        await ApiRepository.getNotificationsList(state.pageNo + 1);

    yield state.rebuild((b) => b
      ..loading = false
      ..suggestions = notifications.data.toList(growable: false)
      ..pageNo = state.pageNo + 1);
  }
}
