import 'package:flutter/material.dart';
import 'page_state_controller.dart';
import 'widgets/page_state_empty_widget.dart';
import 'widgets/page_state_error_widget.dart';
import 'package:get/get.dart';
export 'page_state_enums.dart';

class PageStateHandler extends StatelessWidget {
  /// Controller to handle states of Page and Error Messages
  final PageStateController controller;

  /// refresh your page or update data
  /// default refresh indicator is disabled, passing [onRefresh] will enable it
  final RefreshCallback? onRefresh;

  /// Use your custom Retry callback in Error indicator widget
  final VoidCallback? onRetry;

  /// turning [isChildScrollable] false will enable child scrollable
  /// if child is not scrollable
  final bool? isChildScrollable;

  /// physics will only work if [isChildScrollable] is false
  final ScrollPhysics? physics;

  /// Custom Loading Widget
  final Widget? loading;

  /// Custom Empty Widget
  final Widget? empty;

  /// Custom Error Widget
  final Widget? error;

  /// Customize refresh indicator [r] stands for Refresh
  final double rDisplacement;
  final double rEdgeOffset;
  final Color? rColor;
  final Color? rBackgroundColor;
  final ScrollNotificationPredicate rNotificationPredicate;
  final String? rSemanticsLabel;
  final String? rSemanticsValue;
  final double rStrokeWidth;
  final RefreshIndicatorTriggerMode rTriggerMode;

  /// Pass any widget or list of widgets
  /// passing scrollable widget or list of widgets
  /// then ignore passing [isChildScrollable]
  /// by default it is false or assign true to let list of children scroll
  final Widget child;

  const PageStateHandler({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onRetry,
    this.isChildScrollable = true,
    this.physics,
    this.loading,
    this.empty,
    this.error,
    this.rDisplacement = 40.0,
    this.rEdgeOffset = 0.0,
    this.rColor,
    this.rBackgroundColor,
    this.rNotificationPredicate = defaultScrollNotificationPredicate,
    this.rSemanticsLabel,
    this.rSemanticsValue,
    this.rStrokeWidth = RefreshProgressIndicator.defaultStrokeWidth,
    this.rTriggerMode = RefreshIndicatorTriggerMode.onEdge,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            if (onRefresh != null &&
                controller.pageState.value != PageState.loaded &&
                controller.pageState.value != PageState.loading) ...[
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
                  onRefresh: onRefresh ?? () => Future(() {}),
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
                          child: GestureDetector(
                    onTap: onRetry,
                    child: error ??
                        CustomErrorWidget(
                            errorMessage: controller.errorMessage.value,
                            onRetry: onRetry ??
                                () {
                                  if (onRefresh != null) {
                                    onRefresh!();
                                  }
                                }),
                  ))),
                ]),
              PageState.loaded => onRefresh != null
                  ? RefreshIndicator(
                      displacement: rDisplacement,
                      edgeOffset: rEdgeOffset,
                      color: rColor ?? Colors.red,
                      backgroundColor: rBackgroundColor,
                      notificationPredicate: rNotificationPredicate,
                      semanticsLabel: rSemanticsLabel,
                      semanticsValue: rSemanticsValue,
                      strokeWidth: rStrokeWidth,
                      triggerMode: rTriggerMode,
                      onRefresh: onRefresh ?? () => Future(() {}),
                      child: !isChildScrollable!
                          ? SingleChildScrollView(
                              physics: physics ??
                                  const AlwaysScrollableScrollPhysics(),
                              child: child)
                          : child,
                    )
                  : !isChildScrollable!
                      ? SingleChildScrollView(
                          physics:
                              physics ?? const AlwaysScrollableScrollPhysics(),
                          child: child)
                      : child,
            },
          ],
        ));
  }
}
