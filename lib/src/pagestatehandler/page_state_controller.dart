import 'page_state_enums.dart';
import 'package:get/get.dart';
export 'page_state_enums.dart';

class PageStateController {
  final _currentState = PageState.loading.obs;
  final _errorMessage = 'Something went wrong'.obs;

  void onError(String error) {
    _errorMessage(error);
    _currentState(PageState.error);
  }

  void onStateUpdate(PageState state) {
    _currentState(state);
  }

  RxString get errorMessage {
    return _errorMessage;
  }

  Rx<PageState> get pageState => _currentState;
}
