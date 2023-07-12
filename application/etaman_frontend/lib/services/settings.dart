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

  Color registerBgColor = Colors.green;
  Color registerTextFieldTextColor = Colors.green;
  Color registerTextFieldShadowColor = Colors.green.shade900;
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

  Color profileTopNavBarBgColor = Colors.green;
  Color profileTopNavBarTextColor = Colors.white;
  Color profileTextColor = Colors.green.shade500;
  Color profileIconColor = Colors.green.shade600;

  Color editProfileBgColor = Colors.green;
  Color editProfileTextFieldTextColor = Colors.green;
  Color editProfileTextFieldShadowColor = Colors.green.shade900;
  Color editProfileTextFieldText2Color = Colors.white;
  Color editProfileTextFieldIconColor = Colors.white;
  Color editProfileTextFieldCursorColor = Colors.green;
  Color editProfileTextFieldBorderColor = Colors.green;
  double editProfileTextFieldBorderWidth = 1.0;

  Color createPostBgColor = Colors.green;
  Color createPostTextFieldTextColor = Colors.green;
  Color createPostTextFieldShadowColor = Colors.green.shade900;
  Color createPostTextFieldText2Color = Colors.white;
  Color createPostTextFieldIconColor = Colors.white;
  Color createPostTextFieldCursorColor = Colors.green;
  Color createPostTextFieldBorderColor = Colors.green;
  double createPostTextFieldBorderWidth = 1.0;
}
