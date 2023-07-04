import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class JoinGroupsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for groupName widget.
  TextEditingController? groupNameController;
  String? Function(BuildContext, String?)? groupNameControllerValidator;
  // State field(s) for GroupIdUserCreated widget.
  TextEditingController? groupIdUserCreatedController;
  String? Function(BuildContext, String?)?
      groupIdUserCreatedControllerValidator;
  // State field(s) for GroupDes widget.
  TextEditingController? groupDesController;
  String? Function(BuildContext, String?)? groupDesControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  GroupsRecord? groupCreatedToPass;
  // State field(s) for TextField widget.
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  List<GroupsRecord> simpleSearchResults = [];

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    groupNameController?.dispose();
    groupIdUserCreatedController?.dispose();
    groupDesController?.dispose();
    textController4?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
