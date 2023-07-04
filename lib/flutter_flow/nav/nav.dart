import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '../flutter_flow_theme.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '../../auth/base_auth_user_provider.dart';

import '../../index.dart';
import '../../main.dart';
import '../lat_lng.dart';
import '../place.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : A0LoginPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : A0LoginPageWidget(),
        ),
        FFRoute(
          name: 'a0-loginPage',
          path: '/a0LoginPage',
          builder: (context, params) => A0LoginPageWidget(),
        ),
        FFRoute(
          name: 'a1-registerAccount',
          path: '/a1RegisterAccount',
          builder: (context, params) => A1RegisterAccountWidget(),
        ),
        FFRoute(
          name: 'a2-completeProfile',
          path: '/a2CompleteProfile',
          builder: (context, params) => A2CompleteProfileWidget(),
        ),
        FFRoute(
          name: 'a7-forgotPassword',
          path: '/a7ForgotPassword',
          builder: (context, params) => A7ForgotPasswordWidget(),
        ),
        FFRoute(
          name: 'a5-onboarding',
          path: '/a5Onboarding',
          builder: (context, params) => A5OnboardingWidget(),
        ),
        FFRoute(
          name: 'MY_Card',
          path: '/mYCard',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'MY_Card')
              : MYCardWidget(),
        ),
        FFRoute(
          name: 'MY_Budgets',
          path: '/mYBudgets',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'MY_Budgets')
              : MYBudgetsWidget(),
        ),
        FFRoute(
          name: 'c3-paymentDetails',
          path: '/c3PaymentDetails',
          builder: (context, params) => C3PaymentDetailsWidget(
            transactionDetails: params.getParam('transactionDetails',
                ParamType.DocumentReference, false, ['transactions']),
            userSpent: params.getParam(
                'userSpent', ParamType.DocumentReference, false, ['users']),
          ),
        ),
        FFRoute(
          name: 'b0-profileSetting',
          path: '/b0ProfileSetting',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'b0-profileSetting')
              : B0ProfileSettingWidget(
                  userProfile: params.getParam('userProfile',
                      ParamType.DocumentReference, false, ['users']),
                ),
        ),
        FFRoute(
          name: 'budgetDetails',
          path: '/budgetDetails',
          builder: (context, params) => BudgetDetailsWidget(
            budgetDetails: params.getParam('budgetDetails',
                ParamType.DocumentReference, false, ['budgets']),
          ),
        ),
        FFRoute(
          name: 'transferComplete',
          path: '/transferComplete',
          builder: (context, params) => TransferCompleteWidget(),
        ),
        FFRoute(
          name: 'transferFunds',
          path: '/transferFunds',
          builder: (context, params) => TransferFundsWidget(),
        ),
        FFRoute(
          name: 'requestFunds',
          path: '/requestFunds',
          builder: (context, params) => RequestFundsWidget(),
        ),
        FFRoute(
          name: 'createBudget',
          path: '/createBudget',
          builder: (context, params) => CreateBudgetWidget(),
        ),
        FFRoute(
          name: 'c1-expenseAdd',
          path: '/c1ExpenseAdd',
          asyncParams: {
            'groupChosen': getDoc(['groups'], GroupsRecord.fromSnapshot),
          },
          builder: (context, params) => C1ExpenseAddWidget(
            groupChosen: params.getParam('groupChosen', ParamType.Document),
          ),
        ),
        FFRoute(
          name: 'c2-expenseEdit',
          path: '/c2ExpenseEdit',
          builder: (context, params) => C2ExpenseEditWidget(
            transactionDetails: params.getParam('transactionDetails',
                ParamType.DocumentReference, false, ['transactions']),
          ),
        ),
        FFRoute(
          name: 'a3-editProfile',
          path: '/a3EditProfile',
          builder: (context, params) => A3EditProfileWidget(
            userProfile: params.getParam(
                'userProfile', ParamType.DocumentReference, false, ['users']),
          ),
        ),
        FFRoute(
          name: 'a4-changePassword',
          path: '/a4ChangePassword',
          builder: (context, params) => A4ChangePasswordWidget(),
        ),
        FFRoute(
          name: 'b1-notificationsSettings',
          path: '/b1NotificationsSettings',
          builder: (context, params) => B1NotificationsSettingsWidget(),
        ),
        FFRoute(
          name: 'b2-privacyPolicy',
          path: '/b2PrivacyPolicy',
          builder: (context, params) => B2PrivacyPolicyWidget(),
        ),
        FFRoute(
          name: 'tutorial_PROFILE',
          path: '/tutorialPROFILE',
          builder: (context, params) => TutorialPROFILEWidget(),
        ),
        FFRoute(
          name: 'd0-homePage',
          path: '/d0HomePage',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'd0-homePage')
              : D0HomePageWidget(),
        ),
        FFRoute(
          name: 'homePage_alt',
          path: '/homePageAlt',
          builder: (context, params) => HomePageAltWidget(),
        ),
        FFRoute(
          name: 'c0-groupPage',
          path: '/c0GroupPage',
          asyncParams: {
            'groupChosen': getDoc(['groups'], GroupsRecord.fromSnapshot),
          },
          builder: (context, params) => C0GroupPageWidget(
            groupChosen: params.getParam('groupChosen', ParamType.Document),
          ),
        ),
        FFRoute(
          name: 'budget_DELETE',
          path: '/budgetDELETE',
          builder: (context, params) => BudgetDELETEWidget(
            budgetList: params.getParam(
                'budgetList', ParamType.DocumentReference, false, ['budgets']),
          ),
        ),
        FFRoute(
          name: 'a6-profilePage',
          path: '/a6ProfilePage',
          builder: (context, params) => A6ProfilePageWidget(),
        ),
        FFRoute(
          name: 'a8-createGroup',
          path: '/a8CreateGroup',
          builder: (context, params) => A8CreateGroupWidget(),
        ),
        FFRoute(
          name: 'a9-CreatedGroupSuccess',
          path: '/a9CreatedGroupSuccess',
          asyncParams: {
            'groupChosen': getDoc(['groups'], GroupsRecord.fromSnapshot),
          },
          builder: (context, params) => A9CreatedGroupSuccessWidget(
            groupChosen: params.getParam('groupChosen', ParamType.Document),
          ),
        ),
        FFRoute(
          name: 'joinGroups',
          path: '/joinGroups',
          builder: (context, params) => JoinGroupsWidget(),
        ),
        FFRoute(
          name: 'addFriends',
          path: '/addFriends',
          builder: (context, params) => AddFriendsWidget(),
        ),
        FFRoute(
          name: 'goToGroup',
          path: '/goToGroup',
          builder: (context, params) => GoToGroupWidget(),
        ),
        FFRoute(
          name: 'inviteFriend',
          path: '/inviteFriend',
          asyncParams: {
            'groupChosen': getDoc(['groups'], GroupsRecord.fromSnapshot),
          },
          builder: (context, params) => InviteFriendWidget(
            groupChosen: params.getParam('groupChosen', ParamType.Document),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList,
        collectionNamePath: collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/a0LoginPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Medical_ScheduleApp_0.0.png',
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
