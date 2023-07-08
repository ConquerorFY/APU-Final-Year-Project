import 'package:flutter/material.dart';

class Settings {
  // Create Singleton instance
  Settings._();
  static final Settings _instance = Settings._();
  factory Settings() => _instance;

  // Setting attributes
  Color popupBgColor = Colors.white;
  Color successPopupTextColor = Colors.green;
  Color errorPopupTextColor = Colors.red;

  Color registerTextFieldTextColor = Colors.green;
  Color registerTextFieldText2Color = Colors.white;
  Color registerTextFieldIconColor = Colors.white;
  Color registerTextFieldCursorColor = Colors.green;
  Color registerTextFieldBorderColor = Colors.green;
  double registerTextFieldBorderWidth = 1.0;

  Color loginTextFieldBgColor = Colors.green.withOpacity(0.6);
  Color loginTextFieldTextColor = Colors.white;
  Color loginTextFieldIconColor = Colors.white;
  Color loginTextFieldButtonColor = Colors.green.shade400;
  Color loginTextFieldText2Color = Colors.lightGreen;
  Color loginTextFieldCursorColor = Colors.white;
  Color loginTextFieldBorderColor = Colors.white;
  double loginTextFieldBorderWidth = 1.0;

  Color topNavBarBgColor = Colors.green;
  Color topNavBarTextColor = Colors.white;

  Color leftDrawerBgColor = Colors.green;
  Color leftDrawerTextColor = Colors.white;

  Color bottomNavBarBgColor = Colors.green;
  Color bottomNavBarTextColor = Colors.white;

  Color postTypeFilterSectionTextColor = Colors.green.shade500;
  Color postTypeFilterSectionIconColor = Colors.green.shade600;
  Color postTypeFilterSectionIconSelectedColor = Colors.red.shade600;
  Color postTypeFilterSectionTextSelectedColor = Colors.red.shade500;

  Color postListTextColor = Colors.green.shade500;
  Color postListButtonCancelColor = Colors.red.shade500;
  Color postListIconColor = Colors.green.shade600;
  Color postListIconColor2 = Colors.red.shade600;
  Color postListButtonTextColor = Colors.white;
}
