import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Settings {
  String? _id;
  bool _isEnglish;
  bool _isDarkModeEnabled;
  bool _isPostNotificationDisabled;
  bool _isChatNotificationDisabled;

  Settings({
    bool isEnglish = true,
    bool isDarkModeEnabled = false,
    bool isPostNotificationDisabled = false,
    bool isChatNotificationDisabled = false,
  })  : _id = AutogenerateUtil().generateId(), _isEnglish = isEnglish, _isDarkModeEnabled = isDarkModeEnabled, _isPostNotificationDisabled = isPostNotificationDisabled, _isChatNotificationDisabled = isChatNotificationDisabled; 

  String? get id => this._id;
  set id(String? value) => this._id = value;

  bool get isEnglish => this._isEnglish;
  set isEnglish(bool value) => this._isEnglish = value;

  bool get isDarkModeEnabled => this._isDarkModeEnabled;
  set isDarkModeEnabled(bool value) => this._isDarkModeEnabled = value;
  
  bool get isPostNotificationDisabled => this._isPostNotificationDisabled;
  set isPostNotificationDisabled(bool value) => this._isPostNotificationDisabled = value;

  bool get isChatNotificationDisabled => this._isChatNotificationDisabled;
  set isChatNotificationDisabled(bool value) => this._isChatNotificationDisabled = value;
}