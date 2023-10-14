import 'package:flutter/material.dart';
import 'page_state_controller.dart';
import 'widgets/page_state_empty_widget.dart';
import 'widgets/page_state_error_widget.dart';
import 'package:get/get.dart';
export 'page_state_enums.dart';

class PageStateHandler extends StatelessWidget {
  final PageStateController controller;

  final RefreshCallback retry;
  final Widget child;
  final bool isRefreshOnTop;
  final Widget? loading;
  final Widget? empty;
  final Widget? error;
  final Widget? refresh;
  final double rDisplacement;
  final double rEdgeOffset;
  final Color? rColor;
  final Color? rBackgroundColor;
  final ScrollNotificationPredicate rNotificationPredicate;
  final String? rSemanticsLabel;
  final String? rSemanticsValue;
  final double rStrokeWidth;
  final RefreshIndicatorTriggerMode rTriggerMode;
  const PageStateHandler({
    super.key,
    required this.child,
    required this.controller,
    required this.retry,
    this.isRefreshOnTop = true,
    this.loading,
    this.empty,
    this.error,
    this.refresh,
    this.rDisplacement = 40.0,
    this.rEdgeOffset = 0.0,
    this.rColor,
    this.rBackgroundColor,
    this.rNotificationPredicate = defaultScrollNotificationPredicate,
    this.rSemanticsLabel,
    this.rSemanticsValue,
    this.rStrokeWidth = RefreshProgressIndicator.defaultStrokeWidth,
    this.rTriggerMode = RefreshIndicatorTriggerMode.onEdge,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            if (isRefreshOnTop &&
                controller.pageState.value == PageState.error) ...[
              RefreshIndicator(
                  displacement: rDisplacement,
                  edgeOffset: rEdgeOffset,
                  color: rColor ?? Colors.red,
                  backgroundColor: rBackgroundColor,
                  notificationPredicate: rNotificationPredicate,
                  semanticsLabel: rSemanticsLabel,
                  semanticsValue: rSemanticsValue,
                  strokeWidth: rStrokeWidth,
                  triggerMode: rTriggerMode,
                  onRefresh: retry,
                  child: ListView(
                    children: const [],
                  ))
            ],
            switch (controller.pageState.value) {
              PageState.loading => Stack(children: [
                  Positioned.fill(
                      child: Center(
                    child: loading ??
                        const CircularProgressIndicator(color: Colors.red),
                  )),
                ]),
              PageState.empty => Stack(children: [
                  Positioned.fill(
                    child: Center(
                      child: empty ??
                          const EmptyWidget(
                            message: 'No Data Found',
                          ),
                    ),
                  )
                ]),
              PageState.error => Stack(children: [
                  Positioned.fill(
                      child: Center(
                          child: error ??
                              CustomErrorWidget(
                                  errorMessage: controller.errorMessage.value,
                                  onRetry: () {
                                    retry();
                                  }))),
                ]),
              PageState.loaded => RefreshIndicator(
                  color: rColor ?? Colors.red,
                  onRefresh: retry,
                  child: child,
                )
            },
            if (isRefreshOnTop &&
                controller.pageState.value != PageState.error) ...[
              RefreshIndicator(
                  displacement: rDisplacement,
                  edgeOffset: rEdgeOffset,
                  color: rColor ?? Colors.red,
                  backgroundColor: rBackgroundColor,
                  notificationPredicate: rNotificationPredicate,
                  semanticsLabel: rSemanticsLabel,
                  semanticsValue: rSemanticsValue,
                  strokeWidth: rStrokeWidth,
                  triggerMode: rTriggerMode,
                  onRefresh: retry,
                  child: ListView(
                    children: const [],
                  )),
            ],
          ],
        ));
  }
}
