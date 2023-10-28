import 'page_state_enums.dart';
import 'package:get/get.dart';
export 'page_state_enums.dart';

// Create instance of controller and assign to PageStateHandler Widget
class PageStateController {
  final _currentState = PageState.loading.obs;
  final _errorMessage = 'Something went wrong'.obs;

// set error message
  void onError(String error) {
    _errorMessage(error);
    _currentState(PageState.error);
  }

// set current state
  void onStateUpdate(PageState state) {
    _currentState(state);
  }

// get error message
  RxString get errorMessage => _errorMessage;

// get current state
  Rx<PageState> get pageState => _currentState;
}
