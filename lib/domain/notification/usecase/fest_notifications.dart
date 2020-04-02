import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/network/notification/response_notification.dart';

class FetchNotificationsUseCase {
  // TODO add DI to handle this for us
  final ApiRepository _repository = ApiRepository.instance;

  /// Will return a [Future] of type [ResponseNotifications] when called.
  ///
  /// Optional [pageNo] starting at 0 for paginated notification lists. The page stats at 1
  Future<ResponseNotifications> execute({int pageNo = 1}) async {
    assert(pageNo > 0);
    return _repository.getNotificationsList(pageNo);
  }
}
