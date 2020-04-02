import 'dart:async';

import 'package:corona_trace/bloc/notification/notification_bloc_event.dart';
import 'package:corona_trace/bloc/notification/notification_bloc_state.dart';
import 'package:corona_trace/domain/notification/usecase/fest_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CTNotificationsBloc
    extends Bloc<NotificationsBloEvent, NotificationsBlocState> {
  // TODO let DI handle this later
  final FetchNotificationsUseCase _fetchNotificationsUseCase =
      FetchNotificationsUseCase();

  @override
  NotificationsBlocState get initialState => NotificationsBlocState((b) => b
    ..pageNo = 1
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
      {int pageNo = 1}) async* {
    yield state.rebuild((b) => b
      ..loading = true
      ..pageNo = pageNo);

    try {
      var notifications =
          await _fetchNotificationsUseCase.execute(pageNo: pageNo);
      yield state.rebuild((b) => b
        ..loading = false
        ..suggestions.addAll(notifications.data)
        ..pageNo = pageNo);
    } catch (ex) {
      yield state.rebuild((b) => b
        ..loading = false
        ..pageNo = pageNo > 1 ? pageNo - 1 : 1);
    }
  }
}
