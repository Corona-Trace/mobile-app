import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/network/notification/response_notification.dart';

class FetchNotificationsUseCase {
  // TODO add DI to handle this for us
  final ApiRepository _repository = ApiRepository.instance;

  /// Will return a [Future] of type [ResponseNotifications] when called.
  ///
  /// Optional [pageIndex] starting at 0 for paginated notification lists.
  Future<ResponseNotifications> execute({int pageIndex = 0}) async {
    return _repository.getNotificationsList(pageIndex + 1);
  }
}
