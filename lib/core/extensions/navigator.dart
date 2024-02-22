import 'package:flutter/material.dart';

///Navigator Extensions on BuildContext.
extension BuildContextNavigationExtensions on BuildContext {
  ///Pop the current page.
  void pop<T extends Object?>([T? result]) {
    return Navigator.pop(this, result);
  }

  ///Navigate to a new page.
  ///
  ///[page] - The new page.
  Future<T?> pushTo<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  ///Navigate to a new page with an transition animation.
  ///
  ///[page] - The new page.
  ///[bottomToTop] - Whether the animation should be from bottom to top.
  Future<T?> pushToWithAnimation<T extends Object?>(
    Widget page, {
    bool bottomToTop = false,
  }) {
    if (bottomToTop) {
      return Navigator.of(this).push<T>(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0, 1);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }

    return pushTo<T>(page);
  }

  ///Navigate to a new page and then disposing the current page.
  ///
  ///[page] - The new page.
  Future<T?> replaceWith<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  ///Navigate to a new page and then disposing all previous pages.
  ///
  ///[page] - The new page, ie the new first page in the stack.
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => predicate != null && predicate(route),
    );
  }

  ///Navigate to a new page and then disposing all previous pages.
  ///
  ///[routeName] - The new page route name, ie the new first page in the stack.
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => predicate != null && predicate(route),
    );
  }

  /// Show Transparent Alert Dialogs in Flutter
  Future<T?> showTransparentDialog<T>({
    required Widget content,
  }) {
    return showDialog<T>(
      context: this,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          backgroundColor: Colors.black.withAlpha(150),
          titleTextStyle: const TextStyle(color: Colors.white),
          contentTextStyle: const TextStyle(color: Colors.white),
          content: content,
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
