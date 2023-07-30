import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  // Create Singleton instance
  Settings._();
  static final Settings _instance = Settings._();
  factory Settings() {
    _instance._initialize();
    return _instance;
  }

  SharedPreferences? prefs;
  // Function to run in the constructor
  void _initialize() async {
    // Obtain Shared preferences
    prefs = await SharedPreferences.getInstance();
    // Init Data (if none stored)
    if (!prefs!.containsKey('theme')) {
      await prefs?.setString('theme', 'green');
    }
    applyThemeData();
  }

  void writeThemeData(theme) async {
    await prefs?.setString('theme', theme);
  }

  String? getThemeData() {
    return prefs?.getString('theme');
  }

  void applyThemeData() {
    switch (prefs?.getString('theme')) {
      case "blue":
        popupBgColor = Colors.white;
        successPopupTextColor = Colors.blue;
        errorPopupTextColor = Colors.red;

        registerBgColor = Colors.blue;
        registerTextFieldTextColor = Colors.blue;
        registerTextFieldShadowColor = Colors.blue.shade900;
        registerTextFieldText2Color = Colors.white;
        registerTextFieldIconColor = Colors.white;
        registerTextFieldCursorColor = Colors.blue;
        registerTextFieldBorderColor = Colors.blue;
        registerTextFieldBorderWidth = 1.0;

        loginTextFieldBgColor = Colors.blue.withOpacity(0.6);
        loginTextFieldTextColor = Colors.white;
        loginTextFieldIconColor = Colors.white;
        loginTextFieldButtonColor = Colors.blue.shade400;
        loginTextFieldText2Color = Colors.lightBlue;
        loginTextFieldCursorColor = Colors.white;
        loginTextFieldBorderColor = Colors.white;
        loginTextFieldBorderWidth = 1.0;

        topNavBarBgColor = Colors.blue;
        topNavBarTextColor = Colors.white;

        leftDrawerBgColor = Colors.blue;
        leftDrawerTextColor = Colors.white;

        bottomNavBarBgColor = Colors.blue;
        bottomNavBarTextColor = Colors.white;

        postTypeFilterSectionTextColor = Colors.blue.shade500;
        postTypeFilterSectionIconColor = Colors.blue.shade600;
        postTypeFilterSectionIconSelectedColor = Colors.red.shade600;
        postTypeFilterSectionTextSelectedColor = Colors.red.shade500;

        postListTextColor = Colors.blue.shade500;
        postListButtonCancelColor = Colors.red.shade500;
        postListIconColor = Colors.blue.shade600;
        postListIconColor2 = Colors.red.shade600;
        postListButtonTextColor = Colors.white;

        profileTopNavBarBgColor = Colors.blue;
        profileTopNavBarTextColor = Colors.white;
        profileTextColor = Colors.blue.shade500;
        profileIconColor = Colors.blue.shade600;

        editProfileBgColor = Colors.blue;
        editProfileBgColor2 = Colors.red;
        editProfileTextFieldTextColor = Colors.blue;
        editProfileTextFieldShadowColor = Colors.blue.shade900;
        editProfileTextFieldText2Color = Colors.white;
        editProfileTextFieldIconColor = Colors.white;
        editProfileTextFieldCursorColor = Colors.blue;
        editProfileTextFieldBorderColor = Colors.blue;
        editProfileTextFieldBorderWidth = 1.0;

        createPostBgColor = Colors.blue;
        createPostBgColor2 = Colors.red;
        createPostTextFieldTextColor = Colors.blue;
        createPostTextFieldShadowColor = Colors.blue.shade900;
        createPostTextFieldText2Color = Colors.white;
        createPostTextFieldIconColor = Colors.white;
        createPostTextFieldCursorColor = Colors.blue;
        createPostTextFieldBorderColor = Colors.blue;
        createPostTextFieldBorderWidth = 1.0;

        mapWaitDuration = 1;
        mapShowDuration = 2;
        mapTooltipBgColor = Colors.blue.shade900;
        mapTooltipTextColor = Colors.white;
        mapPrimaryMarkerColor = Colors.red;
        mapSecondaryMarkerColor = Colors.blue;

        joinGroupBgColor = Colors.blue;
        joinGroupBgColor2 = Colors.blue.shade600;
        joinGroupBgColor3 = Colors.red.shade600;
        joinGroupBgColor4 = Colors.grey.shade600;
        joinGroupTextFieldTextColor = Colors.white;
        joinGroupTextFieldShadowColor = Colors.blue.shade900;
        joinGroupTextFieldIconColor = Colors.white;
        joinGroupTextFieldCursorColor = Colors.blue;
        joinGroupTextFieldBorderColor = Colors.blue;
        joinGroupTextFieldBorderWidth = 1.0;

        createGroupBgColor = Colors.blue;
        createGroupTextFieldTextColor = Colors.blue;
        createGroupTextFieldShadowColor = Colors.blue.shade900;
        createGroupTextFieldText2Color = Colors.white;
        createGroupTextFieldIconColor = Colors.white;
        createGroupTextFieldCursorColor = Colors.blue;
        createGroupTextFieldBorderColor = Colors.blue;
        createGroupTextFieldBorderWidth = 1.0;

        manageGroupBgColor = Colors.blue;
        manageGroupTextColor = Colors.blue;
        manageGroupShadowColor = Colors.blue.shade900;
        manageGroupText2Color = Colors.white;
        manageGroupIconColor = Colors.white;
        manageGroupCursorColor = Colors.blue;
        manageGroupBorderColor = Colors.blue;
        manageGroupButtonColor = Colors.blue;
        manageGroupButtonColor2 = Colors.red;
        manageGroupBorderWidth = 1.0;

        editGroupBgColor = Colors.blue;
        editGroupTextFieldTextColor = Colors.blue;
        editGroupTextFieldShadowColor = Colors.blue.shade900;
        editGroupTextFieldText2Color = Colors.white;
        editGroupTextFieldIconColor = Colors.white;
        editGroupTextFieldCursorColor = Colors.blue;
        editGroupTextFieldBorderColor = Colors.blue;
        editGroupTextFieldBorderWidth = 1.0;

        facilitiesBgColor = Colors.blue;
        facilitiesTooltipBgColor = const Color.fromARGB(228, 1, 89, 1);
        facilitiesTextColor = Colors.blue;
        facilitiesShadowColor = Colors.blue.shade900;
        facilitiesText2Color = Colors.white;
        facilitiesCursorColor = Colors.blue;
        facilitiesBorderColor = Colors.blue;
        facilitiesButtonColor = Colors.blue;
        facilitiesButtonColor2 = Colors.red;
        facilitiesButtonColor3 = Colors.blue.shade800;
        facilitiesIconColor = Colors.blue;
        facilitiesIconColor2 = Colors.red;
        facilitiesIconColor3 = Colors.white;
        facilitiesBorderWidth = 1.0;

        registerFacilitiesBgColor = Colors.blue;
        registerFacilitiesTextFieldTextColor = Colors.blue;
        registerFacilitiesTextFieldShadowColor = Colors.blue.shade900;
        registerFacilitiesTextFieldText2Color = Colors.white;
        registerFacilitiesTextFieldIconColor = Colors.white;
        registerFacilitiesTextFieldCursorColor = Colors.blue;
        registerFacilitiesTextFieldBorderColor = Colors.blue;
        registerFacilitiesTextFieldBorderWidth = 1.0;

        editPostBgColor = Colors.blue;
        editPostBgColor2 = Colors.red;
        editPostTextFieldTextColor = Colors.blue;
        editPostTextFieldShadowColor = Colors.blue.shade900;
        editPostTextFieldText2Color = Colors.white;
        editPostTextFieldIconColor = Colors.white;
        editPostTextFieldCursorColor = Colors.blue;
        editPostTextFieldBorderColor = Colors.blue;
        editPostTextFieldBorderWidth = 1.0;

        editPostCommentBgColor = Colors.blue;
        editPostCommentBgColor2 = Colors.red;
        editPostCommentTextFieldTextColor = Colors.blue;
        editPostCommentTextFieldShadowColor = Colors.blue.shade900;
        editPostCommentTextFieldText2Color = Colors.white;
        editPostCommentTextFieldIconColor = Colors.white;
        editPostCommentTextFieldCursorColor = Colors.blue;
        editPostCommentTextFieldBorderColor = Colors.blue;
        editPostCommentTextFieldBorderWidth = 1.0;

        settingsTopNavBarBgColor = Colors.blue;
        settingsTopNavBarTextColor = Colors.white;
        settingsTextColor = Colors.blue.shade500;
        settingsIconColor = Colors.blue.shade600;

        loadingBgColor = Colors.blue.shade600;
        loadingColor = Colors.blue.shade200;
        break;
      case "green":
        popupBgColor = Colors.white;
        successPopupTextColor = Colors.green;
        errorPopupTextColor = Colors.red;

        registerBgColor = Colors.green;
        registerTextFieldTextColor = Colors.green;
        registerTextFieldShadowColor = Colors.green.shade900;
        registerTextFieldText2Color = Colors.white;
        registerTextFieldIconColor = Colors.white;
        registerTextFieldCursorColor = Colors.green;
        registerTextFieldBorderColor = Colors.green;
        registerTextFieldBorderWidth = 1.0;

        loginTextFieldBgColor = Colors.green.withOpacity(0.6);
        loginTextFieldTextColor = Colors.white;
        loginTextFieldIconColor = Colors.white;
        loginTextFieldButtonColor = Colors.green.shade400;
        loginTextFieldText2Color = Colors.lightGreen;
        loginTextFieldCursorColor = Colors.white;
        loginTextFieldBorderColor = Colors.white;
        loginTextFieldBorderWidth = 1.0;

        topNavBarBgColor = Colors.green;
        topNavBarTextColor = Colors.white;

        leftDrawerBgColor = Colors.green;
        leftDrawerTextColor = Colors.white;

        bottomNavBarBgColor = Colors.green;
        bottomNavBarTextColor = Colors.white;

        postTypeFilterSectionTextColor = Colors.green.shade500;
        postTypeFilterSectionIconColor = Colors.green.shade600;
        postTypeFilterSectionIconSelectedColor = Colors.red.shade600;
        postTypeFilterSectionTextSelectedColor = Colors.red.shade500;

        postListTextColor = Colors.green.shade500;
        postListButtonCancelColor = Colors.red.shade500;
        postListIconColor = Colors.green.shade600;
        postListIconColor2 = Colors.red.shade600;
        postListButtonTextColor = Colors.white;

        profileTopNavBarBgColor = Colors.green;
        profileTopNavBarTextColor = Colors.white;
        profileTextColor = Colors.green.shade500;
        profileIconColor = Colors.green.shade600;

        editProfileBgColor = Colors.green;
        editProfileBgColor2 = Colors.red;
        editProfileTextFieldTextColor = Colors.green;
        editProfileTextFieldShadowColor = Colors.green.shade900;
        editProfileTextFieldText2Color = Colors.white;
        editProfileTextFieldIconColor = Colors.white;
        editProfileTextFieldCursorColor = Colors.green;
        editProfileTextFieldBorderColor = Colors.green;
        editProfileTextFieldBorderWidth = 1.0;

        createPostBgColor = Colors.green;
        createPostBgColor2 = Colors.red;
        createPostTextFieldTextColor = Colors.green;
        createPostTextFieldShadowColor = Colors.green.shade900;
        createPostTextFieldText2Color = Colors.white;
        createPostTextFieldIconColor = Colors.white;
        createPostTextFieldCursorColor = Colors.green;
        createPostTextFieldBorderColor = Colors.green;
        createPostTextFieldBorderWidth = 1.0;

        mapWaitDuration = 1;
        mapShowDuration = 2;
        mapTooltipBgColor = Colors.green.shade900;
        mapTooltipTextColor = Colors.white;
        mapPrimaryMarkerColor = Colors.red;
        mapSecondaryMarkerColor = Colors.blue;

        joinGroupBgColor = Colors.green;
        joinGroupBgColor2 = Colors.green.shade600;
        joinGroupBgColor3 = Colors.red.shade600;
        joinGroupBgColor4 = Colors.grey.shade600;
        joinGroupTextFieldTextColor = Colors.white;
        joinGroupTextFieldShadowColor = Colors.green.shade900;
        joinGroupTextFieldIconColor = Colors.white;
        joinGroupTextFieldCursorColor = Colors.green;
        joinGroupTextFieldBorderColor = Colors.green;
        joinGroupTextFieldBorderWidth = 1.0;

        createGroupBgColor = Colors.green;
        createGroupTextFieldTextColor = Colors.green;
        createGroupTextFieldShadowColor = Colors.green.shade900;
        createGroupTextFieldText2Color = Colors.white;
        createGroupTextFieldIconColor = Colors.white;
        createGroupTextFieldCursorColor = Colors.green;
        createGroupTextFieldBorderColor = Colors.green;
        createGroupTextFieldBorderWidth = 1.0;

        manageGroupBgColor = Colors.green;
        manageGroupTextColor = Colors.green;
        manageGroupShadowColor = Colors.green.shade900;
        manageGroupText2Color = Colors.white;
        manageGroupIconColor = Colors.white;
        manageGroupCursorColor = Colors.green;
        manageGroupBorderColor = Colors.green;
        manageGroupButtonColor = Colors.green;
        manageGroupButtonColor2 = Colors.red;
        manageGroupBorderWidth = 1.0;

        editGroupBgColor = Colors.green;
        editGroupTextFieldTextColor = Colors.green;
        editGroupTextFieldShadowColor = Colors.green.shade900;
        editGroupTextFieldText2Color = Colors.white;
        editGroupTextFieldIconColor = Colors.white;
        editGroupTextFieldCursorColor = Colors.green;
        editGroupTextFieldBorderColor = Colors.green;
        editGroupTextFieldBorderWidth = 1.0;

        facilitiesBgColor = Colors.green;
        facilitiesTooltipBgColor = const Color.fromARGB(228, 1, 89, 1);
        facilitiesTextColor = Colors.green;
        facilitiesShadowColor = Colors.green.shade900;
        facilitiesText2Color = Colors.white;
        facilitiesCursorColor = Colors.green;
        facilitiesBorderColor = Colors.green;
        facilitiesButtonColor = Colors.green;
        facilitiesButtonColor2 = Colors.red;
        facilitiesButtonColor3 = Colors.green.shade800;
        facilitiesIconColor = Colors.green;
        facilitiesIconColor2 = Colors.red;
        facilitiesIconColor3 = Colors.white;
        facilitiesBorderWidth = 1.0;

        registerFacilitiesBgColor = Colors.green;
        registerFacilitiesTextFieldTextColor = Colors.green;
        registerFacilitiesTextFieldShadowColor = Colors.green.shade900;
        registerFacilitiesTextFieldText2Color = Colors.white;
        registerFacilitiesTextFieldIconColor = Colors.white;
        registerFacilitiesTextFieldCursorColor = Colors.green;
        registerFacilitiesTextFieldBorderColor = Colors.green;
        registerFacilitiesTextFieldBorderWidth = 1.0;

        editPostBgColor = Colors.green;
        editPostBgColor2 = Colors.red;
        editPostTextFieldTextColor = Colors.green;
        editPostTextFieldShadowColor = Colors.green.shade900;
        editPostTextFieldText2Color = Colors.white;
        editPostTextFieldIconColor = Colors.white;
        editPostTextFieldCursorColor = Colors.green;
        editPostTextFieldBorderColor = Colors.green;
        editPostTextFieldBorderWidth = 1.0;

        editPostCommentBgColor = Colors.green;
        editPostCommentBgColor2 = Colors.red;
        editPostCommentTextFieldTextColor = Colors.green;
        editPostCommentTextFieldShadowColor = Colors.green.shade900;
        editPostCommentTextFieldText2Color = Colors.white;
        editPostCommentTextFieldIconColor = Colors.white;
        editPostCommentTextFieldCursorColor = Colors.green;
        editPostCommentTextFieldBorderColor = Colors.green;
        editPostCommentTextFieldBorderWidth = 1.0;

        settingsTopNavBarBgColor = Colors.green;
        settingsTopNavBarTextColor = Colors.white;
        settingsTextColor = Colors.green.shade500;
        settingsIconColor = Colors.green.shade600;

        loadingBgColor = Colors.green.shade600;
        loadingColor = Colors.green.shade200;
        break;
      case "orange":
        popupBgColor = Colors.white;
        successPopupTextColor = Colors.orange;
        errorPopupTextColor = Colors.red;

        registerBgColor = Colors.orange;
        registerTextFieldTextColor = Colors.orange;
        registerTextFieldShadowColor = Colors.orange.shade900;
        registerTextFieldText2Color = Colors.white;
        registerTextFieldIconColor = Colors.white;
        registerTextFieldCursorColor = Colors.orange;
        registerTextFieldBorderColor = Colors.orange;
        registerTextFieldBorderWidth = 1.0;

        loginTextFieldBgColor = Colors.orange.withOpacity(0.6);
        loginTextFieldTextColor = Colors.white;
        loginTextFieldIconColor = Colors.white;
        loginTextFieldButtonColor = Colors.orange.shade400;
        loginTextFieldText2Color = Colors.orange.shade400;
        loginTextFieldCursorColor = Colors.white;
        loginTextFieldBorderColor = Colors.white;
        loginTextFieldBorderWidth = 1.0;

        topNavBarBgColor = Colors.orange;
        topNavBarTextColor = Colors.white;

        leftDrawerBgColor = Colors.orange;
        leftDrawerTextColor = Colors.white;

        bottomNavBarBgColor = Colors.orange;
        bottomNavBarTextColor = Colors.white;

        postTypeFilterSectionTextColor = Colors.orange.shade500;
        postTypeFilterSectionIconColor = Colors.orange.shade600;
        postTypeFilterSectionIconSelectedColor = Colors.red.shade600;
        postTypeFilterSectionTextSelectedColor = Colors.red.shade500;

        postListTextColor = Colors.orange.shade500;
        postListButtonCancelColor = Colors.red.shade500;
        postListIconColor = Colors.orange.shade600;
        postListIconColor2 = Colors.red.shade600;
        postListButtonTextColor = Colors.white;

        profileTopNavBarBgColor = Colors.orange;
        profileTopNavBarTextColor = Colors.white;
        profileTextColor = Colors.orange.shade500;
        profileIconColor = Colors.orange.shade600;

        editProfileBgColor = Colors.orange;
        editProfileBgColor2 = Colors.red;
        editProfileTextFieldTextColor = Colors.orange;
        editProfileTextFieldShadowColor = Colors.orange.shade900;
        editProfileTextFieldText2Color = Colors.white;
        editProfileTextFieldIconColor = Colors.white;
        editProfileTextFieldCursorColor = Colors.orange;
        editProfileTextFieldBorderColor = Colors.orange;
        editProfileTextFieldBorderWidth = 1.0;

        createPostBgColor = Colors.orange;
        createPostBgColor2 = Colors.red;
        createPostTextFieldTextColor = Colors.orange;
        createPostTextFieldShadowColor = Colors.orange.shade900;
        createPostTextFieldText2Color = Colors.white;
        createPostTextFieldIconColor = Colors.white;
        createPostTextFieldCursorColor = Colors.orange;
        createPostTextFieldBorderColor = Colors.orange;
        createPostTextFieldBorderWidth = 1.0;

        mapWaitDuration = 1;
        mapShowDuration = 2;
        mapTooltipBgColor = Colors.orange.shade900;
        mapTooltipTextColor = Colors.white;
        mapPrimaryMarkerColor = Colors.red;
        mapSecondaryMarkerColor = Colors.blue;

        joinGroupBgColor = Colors.orange;
        joinGroupBgColor2 = Colors.orange.shade600;
        joinGroupBgColor3 = Colors.red.shade600;
        joinGroupBgColor4 = Colors.grey.shade600;
        joinGroupTextFieldTextColor = Colors.white;
        joinGroupTextFieldShadowColor = Colors.orange.shade900;
        joinGroupTextFieldIconColor = Colors.white;
        joinGroupTextFieldCursorColor = Colors.orange;
        joinGroupTextFieldBorderColor = Colors.orange;
        joinGroupTextFieldBorderWidth = 1.0;

        createGroupBgColor = Colors.orange;
        createGroupTextFieldTextColor = Colors.orange;
        createGroupTextFieldShadowColor = Colors.orange.shade900;
        createGroupTextFieldText2Color = Colors.white;
        createGroupTextFieldIconColor = Colors.white;
        createGroupTextFieldCursorColor = Colors.orange;
        createGroupTextFieldBorderColor = Colors.orange;
        createGroupTextFieldBorderWidth = 1.0;

        manageGroupBgColor = Colors.orange;
        manageGroupTextColor = Colors.orange;
        manageGroupShadowColor = Colors.orange.shade900;
        manageGroupText2Color = Colors.white;
        manageGroupIconColor = Colors.white;
        manageGroupCursorColor = Colors.orange;
        manageGroupBorderColor = Colors.orange;
        manageGroupButtonColor = Colors.orange;
        manageGroupButtonColor2 = Colors.red;
        manageGroupBorderWidth = 1.0;

        editGroupBgColor = Colors.orange;
        editGroupTextFieldTextColor = Colors.orange;
        editGroupTextFieldShadowColor = Colors.orange.shade900;
        editGroupTextFieldText2Color = Colors.white;
        editGroupTextFieldIconColor = Colors.white;
        editGroupTextFieldCursorColor = Colors.orange;
        editGroupTextFieldBorderColor = Colors.orange;
        editGroupTextFieldBorderWidth = 1.0;

        facilitiesBgColor = Colors.orange;
        facilitiesTooltipBgColor = const Color.fromARGB(228, 1, 89, 1);
        facilitiesTextColor = Colors.orange;
        facilitiesShadowColor = Colors.orange.shade900;
        facilitiesText2Color = Colors.white;
        facilitiesCursorColor = Colors.orange;
        facilitiesBorderColor = Colors.orange;
        facilitiesButtonColor = Colors.orange;
        facilitiesButtonColor2 = Colors.red;
        facilitiesButtonColor3 = Colors.orange.shade800;
        facilitiesIconColor = Colors.orange;
        facilitiesIconColor2 = Colors.red;
        facilitiesIconColor3 = Colors.white;
        facilitiesBorderWidth = 1.0;

        registerFacilitiesBgColor = Colors.orange;
        registerFacilitiesTextFieldTextColor = Colors.orange;
        registerFacilitiesTextFieldShadowColor = Colors.orange.shade900;
        registerFacilitiesTextFieldText2Color = Colors.white;
        registerFacilitiesTextFieldIconColor = Colors.white;
        registerFacilitiesTextFieldCursorColor = Colors.orange;
        registerFacilitiesTextFieldBorderColor = Colors.orange;
        registerFacilitiesTextFieldBorderWidth = 1.0;

        editPostBgColor = Colors.orange;
        editPostBgColor2 = Colors.red;
        editPostTextFieldTextColor = Colors.orange;
        editPostTextFieldShadowColor = Colors.orange.shade900;
        editPostTextFieldText2Color = Colors.white;
        editPostTextFieldIconColor = Colors.white;
        editPostTextFieldCursorColor = Colors.orange;
        editPostTextFieldBorderColor = Colors.orange;
        editPostTextFieldBorderWidth = 1.0;

        editPostCommentBgColor = Colors.orange;
        editPostCommentBgColor2 = Colors.red;
        editPostCommentTextFieldTextColor = Colors.orange;
        editPostCommentTextFieldShadowColor = Colors.orange.shade900;
        editPostCommentTextFieldText2Color = Colors.white;
        editPostCommentTextFieldIconColor = Colors.white;
        editPostCommentTextFieldCursorColor = Colors.orange;
        editPostCommentTextFieldBorderColor = Colors.orange;
        editPostCommentTextFieldBorderWidth = 1.0;

        settingsTopNavBarBgColor = Colors.orange;
        settingsTopNavBarTextColor = Colors.white;
        settingsTextColor = Colors.orange.shade500;
        settingsIconColor = Colors.orange.shade600;

        loadingBgColor = Colors.orange.shade600;
        loadingColor = Colors.orange.shade200;
        break;
      case "black":
        popupBgColor = Colors.white;
        successPopupTextColor = Colors.black;
        errorPopupTextColor = Colors.red;

        registerBgColor = Colors.black;
        registerTextFieldTextColor = Colors.black;
        registerTextFieldShadowColor = Colors.black;
        registerTextFieldText2Color = Colors.white;
        registerTextFieldIconColor = Colors.white;
        registerTextFieldCursorColor = Colors.black;
        registerTextFieldBorderColor = Colors.black;
        registerTextFieldBorderWidth = 1.0;

        loginTextFieldBgColor = Colors.black.withOpacity(0.6);
        loginTextFieldTextColor = Colors.white;
        loginTextFieldIconColor = Colors.white;
        loginTextFieldButtonColor = Colors.black;
        loginTextFieldText2Color = Colors.black;
        loginTextFieldCursorColor = Colors.white;
        loginTextFieldBorderColor = Colors.white;
        loginTextFieldBorderWidth = 1.0;

        topNavBarBgColor = Colors.black;
        topNavBarTextColor = Colors.white;

        leftDrawerBgColor = Colors.black;
        leftDrawerTextColor = Colors.white;

        bottomNavBarBgColor = Colors.black;
        bottomNavBarTextColor = Colors.white;

        postTypeFilterSectionTextColor = Colors.black;
        postTypeFilterSectionIconColor = Colors.black;
        postTypeFilterSectionIconSelectedColor = Colors.red;
        postTypeFilterSectionTextSelectedColor = Colors.red;

        postListTextColor = Colors.black;
        postListButtonCancelColor = Colors.red;
        postListIconColor = Colors.black;
        postListIconColor2 = Colors.red;
        postListButtonTextColor = Colors.white;

        profileTopNavBarBgColor = Colors.black;
        profileTopNavBarTextColor = Colors.white;
        profileTextColor = Colors.black;
        profileIconColor = Colors.black;

        editProfileBgColor = Colors.black;
        editProfileBgColor2 = Colors.red;
        editProfileTextFieldTextColor = Colors.black;
        editProfileTextFieldShadowColor = Colors.black;
        editProfileTextFieldText2Color = Colors.white;
        editProfileTextFieldIconColor = Colors.white;
        editProfileTextFieldCursorColor = Colors.black;
        editProfileTextFieldBorderColor = Colors.black;
        editProfileTextFieldBorderWidth = 1.0;

        createPostBgColor = Colors.black;
        createPostBgColor2 = Colors.red;
        createPostTextFieldTextColor = Colors.black;
        createPostTextFieldShadowColor = Colors.black;
        createPostTextFieldText2Color = Colors.white;
        createPostTextFieldIconColor = Colors.white;
        createPostTextFieldCursorColor = Colors.black;
        createPostTextFieldBorderColor = Colors.black;
        createPostTextFieldBorderWidth = 1.0;

        mapWaitDuration = 1;
        mapShowDuration = 2;
        mapTooltipBgColor = Colors.black;
        mapTooltipTextColor = Colors.white;
        mapPrimaryMarkerColor = Colors.red;
        mapSecondaryMarkerColor = Colors.blue;

        joinGroupBgColor = Colors.black;
        joinGroupBgColor2 = Colors.black;
        joinGroupBgColor3 = Colors.red;
        joinGroupBgColor4 = Colors.grey;
        joinGroupTextFieldTextColor = Colors.white;
        joinGroupTextFieldShadowColor = Colors.black;
        joinGroupTextFieldIconColor = Colors.white;
        joinGroupTextFieldCursorColor = Colors.black;
        joinGroupTextFieldBorderColor = Colors.black;
        joinGroupTextFieldBorderWidth = 1.0;

        createGroupBgColor = Colors.black;
        createGroupTextFieldTextColor = Colors.black;
        createGroupTextFieldShadowColor = Colors.black;
        createGroupTextFieldText2Color = Colors.white;
        createGroupTextFieldIconColor = Colors.white;
        createGroupTextFieldCursorColor = Colors.black;
        createGroupTextFieldBorderColor = Colors.black;
        createGroupTextFieldBorderWidth = 1.0;

        manageGroupBgColor = Colors.black;
        manageGroupTextColor = Colors.black;
        manageGroupShadowColor = Colors.black;
        manageGroupText2Color = Colors.white;
        manageGroupIconColor = Colors.white;
        manageGroupCursorColor = Colors.black;
        manageGroupBorderColor = Colors.black;
        manageGroupButtonColor = Colors.black;
        manageGroupButtonColor2 = Colors.red;
        manageGroupBorderWidth = 1.0;

        editGroupBgColor = Colors.black;
        editGroupTextFieldTextColor = Colors.black;
        editGroupTextFieldShadowColor = Colors.black;
        editGroupTextFieldText2Color = Colors.white;
        editGroupTextFieldIconColor = Colors.white;
        editGroupTextFieldCursorColor = Colors.black;
        editGroupTextFieldBorderColor = Colors.black;
        editGroupTextFieldBorderWidth = 1.0;

        facilitiesBgColor = Colors.black;
        facilitiesTooltipBgColor = const Color.fromARGB(228, 1, 89, 1);
        facilitiesTextColor = Colors.black;
        facilitiesShadowColor = Colors.black;
        facilitiesText2Color = Colors.white;
        facilitiesCursorColor = Colors.black;
        facilitiesBorderColor = Colors.black;
        facilitiesButtonColor = Colors.black;
        facilitiesButtonColor2 = Colors.red;
        facilitiesButtonColor3 = Colors.black;
        facilitiesIconColor = Colors.black;
        facilitiesIconColor2 = Colors.red;
        facilitiesIconColor3 = Colors.white;
        facilitiesBorderWidth = 1.0;

        registerFacilitiesBgColor = Colors.black;
        registerFacilitiesTextFieldTextColor = Colors.black;
        registerFacilitiesTextFieldShadowColor = Colors.black;
        registerFacilitiesTextFieldText2Color = Colors.white;
        registerFacilitiesTextFieldIconColor = Colors.white;
        registerFacilitiesTextFieldCursorColor = Colors.black;
        registerFacilitiesTextFieldBorderColor = Colors.black;
        registerFacilitiesTextFieldBorderWidth = 1.0;

        editPostBgColor = Colors.black;
        editPostBgColor2 = Colors.red;
        editPostTextFieldTextColor = Colors.black;
        editPostTextFieldShadowColor = Colors.black;
        editPostTextFieldText2Color = Colors.white;
        editPostTextFieldIconColor = Colors.white;
        editPostTextFieldCursorColor = Colors.black;
        editPostTextFieldBorderColor = Colors.black;
        editPostTextFieldBorderWidth = 1.0;

        editPostCommentBgColor = Colors.black;
        editPostCommentBgColor2 = Colors.red;
        editPostCommentTextFieldTextColor = Colors.black;
        editPostCommentTextFieldShadowColor = Colors.black;
        editPostCommentTextFieldText2Color = Colors.white;
        editPostCommentTextFieldIconColor = Colors.white;
        editPostCommentTextFieldCursorColor = Colors.black;
        editPostCommentTextFieldBorderColor = Colors.black;
        editPostCommentTextFieldBorderWidth = 1.0;

        settingsTopNavBarBgColor = Colors.black;
        settingsTopNavBarTextColor = Colors.white;
        settingsTextColor = Colors.black;
        settingsIconColor = Colors.black;

        loadingBgColor = Colors.black;
        loadingColor = Colors.white;
        break;
      case "indigo":
        popupBgColor = Colors.white;
        successPopupTextColor = Colors.indigo;
        errorPopupTextColor = Colors.red;

        registerBgColor = Colors.indigo;
        registerTextFieldTextColor = Colors.indigo;
        registerTextFieldShadowColor = Colors.indigo.shade900;
        registerTextFieldText2Color = Colors.white;
        registerTextFieldIconColor = Colors.white;
        registerTextFieldCursorColor = Colors.indigo;
        registerTextFieldBorderColor = Colors.indigo;
        registerTextFieldBorderWidth = 1.0;

        loginTextFieldBgColor = Colors.indigo.withOpacity(0.6);
        loginTextFieldTextColor = Colors.white;
        loginTextFieldIconColor = Colors.white;
        loginTextFieldButtonColor = Colors.indigo.shade400;
        loginTextFieldText2Color = Colors.indigo.shade400;
        loginTextFieldCursorColor = Colors.white;
        loginTextFieldBorderColor = Colors.white;
        loginTextFieldBorderWidth = 1.0;

        topNavBarBgColor = Colors.indigo;
        topNavBarTextColor = Colors.white;

        leftDrawerBgColor = Colors.indigo;
        leftDrawerTextColor = Colors.white;

        bottomNavBarBgColor = Colors.indigo;
        bottomNavBarTextColor = Colors.white;

        postTypeFilterSectionTextColor = Colors.indigo.shade500;
        postTypeFilterSectionIconColor = Colors.indigo.shade600;
        postTypeFilterSectionIconSelectedColor = Colors.red.shade600;
        postTypeFilterSectionTextSelectedColor = Colors.red.shade500;

        postListTextColor = Colors.indigo.shade500;
        postListButtonCancelColor = Colors.red.shade500;
        postListIconColor = Colors.indigo.shade600;
        postListIconColor2 = Colors.red.shade600;
        postListButtonTextColor = Colors.white;

        profileTopNavBarBgColor = Colors.indigo;
        profileTopNavBarTextColor = Colors.white;
        profileTextColor = Colors.indigo.shade500;
        profileIconColor = Colors.indigo.shade600;

        editProfileBgColor = Colors.indigo;
        editProfileBgColor2 = Colors.red;
        editProfileTextFieldTextColor = Colors.indigo;
        editProfileTextFieldShadowColor = Colors.indigo.shade900;
        editProfileTextFieldText2Color = Colors.white;
        editProfileTextFieldIconColor = Colors.white;
        editProfileTextFieldCursorColor = Colors.indigo;
        editProfileTextFieldBorderColor = Colors.indigo;
        editProfileTextFieldBorderWidth = 1.0;

        createPostBgColor = Colors.indigo;
        createPostBgColor2 = Colors.red;
        createPostTextFieldTextColor = Colors.indigo;
        createPostTextFieldShadowColor = Colors.indigo.shade900;
        createPostTextFieldText2Color = Colors.white;
        createPostTextFieldIconColor = Colors.white;
        createPostTextFieldCursorColor = Colors.indigo;
        createPostTextFieldBorderColor = Colors.indigo;
        createPostTextFieldBorderWidth = 1.0;

        mapWaitDuration = 1;
        mapShowDuration = 2;
        mapTooltipBgColor = Colors.indigo.shade900;
        mapTooltipTextColor = Colors.white;
        mapPrimaryMarkerColor = Colors.red;
        mapSecondaryMarkerColor = Colors.blue;

        joinGroupBgColor = Colors.indigo;
        joinGroupBgColor2 = Colors.indigo.shade600;
        joinGroupBgColor3 = Colors.red.shade600;
        joinGroupBgColor4 = Colors.grey.shade600;
        joinGroupTextFieldTextColor = Colors.white;
        joinGroupTextFieldShadowColor = Colors.indigo.shade900;
        joinGroupTextFieldIconColor = Colors.white;
        joinGroupTextFieldCursorColor = Colors.indigo;
        joinGroupTextFieldBorderColor = Colors.indigo;
        joinGroupTextFieldBorderWidth = 1.0;

        createGroupBgColor = Colors.indigo;
        createGroupTextFieldTextColor = Colors.indigo;
        createGroupTextFieldShadowColor = Colors.indigo.shade900;
        createGroupTextFieldText2Color = Colors.white;
        createGroupTextFieldIconColor = Colors.white;
        createGroupTextFieldCursorColor = Colors.indigo;
        createGroupTextFieldBorderColor = Colors.indigo;
        createGroupTextFieldBorderWidth = 1.0;

        manageGroupBgColor = Colors.indigo;
        manageGroupTextColor = Colors.indigo;
        manageGroupShadowColor = Colors.indigo.shade900;
        manageGroupText2Color = Colors.white;
        manageGroupIconColor = Colors.white;
        manageGroupCursorColor = Colors.indigo;
        manageGroupBorderColor = Colors.indigo;
        manageGroupButtonColor = Colors.indigo;
        manageGroupButtonColor2 = Colors.red;
        manageGroupBorderWidth = 1.0;

        editGroupBgColor = Colors.indigo;
        editGroupTextFieldTextColor = Colors.indigo;
        editGroupTextFieldShadowColor = Colors.indigo.shade900;
        editGroupTextFieldText2Color = Colors.white;
        editGroupTextFieldIconColor = Colors.white;
        editGroupTextFieldCursorColor = Colors.indigo;
        editGroupTextFieldBorderColor = Colors.indigo;
        editGroupTextFieldBorderWidth = 1.0;

        facilitiesBgColor = Colors.indigo;
        facilitiesTooltipBgColor = const Color.fromARGB(228, 1, 89, 1);
        facilitiesTextColor = Colors.indigo;
        facilitiesShadowColor = Colors.indigo.shade900;
        facilitiesText2Color = Colors.white;
        facilitiesCursorColor = Colors.indigo;
        facilitiesBorderColor = Colors.indigo;
        facilitiesButtonColor = Colors.indigo;
        facilitiesButtonColor2 = Colors.red;
        facilitiesButtonColor3 = Colors.indigo.shade800;
        facilitiesIconColor = Colors.indigo;
        facilitiesIconColor2 = Colors.red;
        facilitiesIconColor3 = Colors.white;
        facilitiesBorderWidth = 1.0;

        registerFacilitiesBgColor = Colors.indigo;
        registerFacilitiesTextFieldTextColor = Colors.indigo;
        registerFacilitiesTextFieldShadowColor = Colors.indigo.shade900;
        registerFacilitiesTextFieldText2Color = Colors.white;
        registerFacilitiesTextFieldIconColor = Colors.white;
        registerFacilitiesTextFieldCursorColor = Colors.indigo;
        registerFacilitiesTextFieldBorderColor = Colors.indigo;
        registerFacilitiesTextFieldBorderWidth = 1.0;

        editPostBgColor = Colors.indigo;
        editPostBgColor2 = Colors.red;
        editPostTextFieldTextColor = Colors.indigo;
        editPostTextFieldShadowColor = Colors.indigo.shade900;
        editPostTextFieldText2Color = Colors.white;
        editPostTextFieldIconColor = Colors.white;
        editPostTextFieldCursorColor = Colors.indigo;
        editPostTextFieldBorderColor = Colors.indigo;
        editPostTextFieldBorderWidth = 1.0;

        editPostCommentBgColor = Colors.indigo;
        editPostCommentBgColor2 = Colors.red;
        editPostCommentTextFieldTextColor = Colors.indigo;
        editPostCommentTextFieldShadowColor = Colors.indigo.shade900;
        editPostCommentTextFieldText2Color = Colors.white;
        editPostCommentTextFieldIconColor = Colors.white;
        editPostCommentTextFieldCursorColor = Colors.indigo;
        editPostCommentTextFieldBorderColor = Colors.indigo;
        editPostCommentTextFieldBorderWidth = 1.0;

        settingsTopNavBarBgColor = Colors.indigo;
        settingsTopNavBarTextColor = Colors.white;
        settingsTextColor = Colors.indigo.shade500;
        settingsIconColor = Colors.indigo.shade600;

        loadingBgColor = Colors.indigo.shade600;
        loadingColor = Colors.indigo.shade200;
        break;
      case "purple":
        popupBgColor = Colors.white;
        successPopupTextColor = Colors.purple;
        errorPopupTextColor = Colors.red;

        registerBgColor = Colors.purple;
        registerTextFieldTextColor = Colors.purple;
        registerTextFieldShadowColor = Colors.purple.shade900;
        registerTextFieldText2Color = Colors.white;
        registerTextFieldIconColor = Colors.white;
        registerTextFieldCursorColor = Colors.purple;
        registerTextFieldBorderColor = Colors.purple;
        registerTextFieldBorderWidth = 1.0;

        loginTextFieldBgColor = Colors.purple.withOpacity(0.6);
        loginTextFieldTextColor = Colors.white;
        loginTextFieldIconColor = Colors.white;
        loginTextFieldButtonColor = Colors.purple.shade400;
        loginTextFieldText2Color = Colors.purple.shade400;
        loginTextFieldCursorColor = Colors.white;
        loginTextFieldBorderColor = Colors.white;
        loginTextFieldBorderWidth = 1.0;

        topNavBarBgColor = Colors.purple;
        topNavBarTextColor = Colors.white;

        leftDrawerBgColor = Colors.purple;
        leftDrawerTextColor = Colors.white;

        bottomNavBarBgColor = Colors.purple;
        bottomNavBarTextColor = Colors.white;

        postTypeFilterSectionTextColor = Colors.purple.shade500;
        postTypeFilterSectionIconColor = Colors.purple.shade600;
        postTypeFilterSectionIconSelectedColor = Colors.red.shade600;
        postTypeFilterSectionTextSelectedColor = Colors.red.shade500;

        postListTextColor = Colors.purple.shade500;
        postListButtonCancelColor = Colors.red.shade500;
        postListIconColor = Colors.purple.shade600;
        postListIconColor2 = Colors.red.shade600;
        postListButtonTextColor = Colors.white;

        profileTopNavBarBgColor = Colors.purple;
        profileTopNavBarTextColor = Colors.white;
        profileTextColor = Colors.purple.shade500;
        profileIconColor = Colors.purple.shade600;

        editProfileBgColor = Colors.purple;
        editProfileBgColor2 = Colors.red;
        editProfileTextFieldTextColor = Colors.purple;
        editProfileTextFieldShadowColor = Colors.purple.shade900;
        editProfileTextFieldText2Color = Colors.white;
        editProfileTextFieldIconColor = Colors.white;
        editProfileTextFieldCursorColor = Colors.purple;
        editProfileTextFieldBorderColor = Colors.purple;
        editProfileTextFieldBorderWidth = 1.0;

        createPostBgColor = Colors.purple;
        createPostBgColor2 = Colors.red;
        createPostTextFieldTextColor = Colors.purple;
        createPostTextFieldShadowColor = Colors.purple.shade900;
        createPostTextFieldText2Color = Colors.white;
        createPostTextFieldIconColor = Colors.white;
        createPostTextFieldCursorColor = Colors.purple;
        createPostTextFieldBorderColor = Colors.purple;
        createPostTextFieldBorderWidth = 1.0;

        mapWaitDuration = 1;
        mapShowDuration = 2;
        mapTooltipBgColor = Colors.purple.shade900;
        mapTooltipTextColor = Colors.white;
        mapPrimaryMarkerColor = Colors.red;
        mapSecondaryMarkerColor = Colors.blue;

        joinGroupBgColor = Colors.purple;
        joinGroupBgColor2 = Colors.purple.shade600;
        joinGroupBgColor3 = Colors.red.shade600;
        joinGroupBgColor4 = Colors.grey.shade600;
        joinGroupTextFieldTextColor = Colors.white;
        joinGroupTextFieldShadowColor = Colors.purple.shade900;
        joinGroupTextFieldIconColor = Colors.white;
        joinGroupTextFieldCursorColor = Colors.purple;
        joinGroupTextFieldBorderColor = Colors.purple;
        joinGroupTextFieldBorderWidth = 1.0;

        createGroupBgColor = Colors.purple;
        createGroupTextFieldTextColor = Colors.purple;
        createGroupTextFieldShadowColor = Colors.purple.shade900;
        createGroupTextFieldText2Color = Colors.white;
        createGroupTextFieldIconColor = Colors.white;
        createGroupTextFieldCursorColor = Colors.purple;
        createGroupTextFieldBorderColor = Colors.purple;
        createGroupTextFieldBorderWidth = 1.0;

        manageGroupBgColor = Colors.purple;
        manageGroupTextColor = Colors.purple;
        manageGroupShadowColor = Colors.purple.shade900;
        manageGroupText2Color = Colors.white;
        manageGroupIconColor = Colors.white;
        manageGroupCursorColor = Colors.purple;
        manageGroupBorderColor = Colors.purple;
        manageGroupButtonColor = Colors.purple;
        manageGroupButtonColor2 = Colors.red;
        manageGroupBorderWidth = 1.0;

        editGroupBgColor = Colors.purple;
        editGroupTextFieldTextColor = Colors.purple;
        editGroupTextFieldShadowColor = Colors.purple.shade900;
        editGroupTextFieldText2Color = Colors.white;
        editGroupTextFieldIconColor = Colors.white;
        editGroupTextFieldCursorColor = Colors.purple;
        editGroupTextFieldBorderColor = Colors.purple;
        editGroupTextFieldBorderWidth = 1.0;

        facilitiesBgColor = Colors.purple;
        facilitiesTooltipBgColor = const Color.fromARGB(228, 1, 89, 1);
        facilitiesTextColor = Colors.purple;
        facilitiesShadowColor = Colors.purple.shade900;
        facilitiesText2Color = Colors.white;
        facilitiesCursorColor = Colors.purple;
        facilitiesBorderColor = Colors.purple;
        facilitiesButtonColor = Colors.purple;
        facilitiesButtonColor2 = Colors.red;
        facilitiesButtonColor3 = Colors.purple.shade800;
        facilitiesIconColor = Colors.purple;
        facilitiesIconColor2 = Colors.red;
        facilitiesIconColor3 = Colors.white;
        facilitiesBorderWidth = 1.0;

        registerFacilitiesBgColor = Colors.purple;
        registerFacilitiesTextFieldTextColor = Colors.purple;
        registerFacilitiesTextFieldShadowColor = Colors.purple.shade900;
        registerFacilitiesTextFieldText2Color = Colors.white;
        registerFacilitiesTextFieldIconColor = Colors.white;
        registerFacilitiesTextFieldCursorColor = Colors.purple;
        registerFacilitiesTextFieldBorderColor = Colors.purple;
        registerFacilitiesTextFieldBorderWidth = 1.0;

        editPostBgColor = Colors.purple;
        editPostBgColor2 = Colors.red;
        editPostTextFieldTextColor = Colors.purple;
        editPostTextFieldShadowColor = Colors.purple.shade900;
        editPostTextFieldText2Color = Colors.white;
        editPostTextFieldIconColor = Colors.white;
        editPostTextFieldCursorColor = Colors.purple;
        editPostTextFieldBorderColor = Colors.purple;
        editPostTextFieldBorderWidth = 1.0;

        editPostCommentBgColor = Colors.purple;
        editPostCommentBgColor2 = Colors.red;
        editPostCommentTextFieldTextColor = Colors.purple;
        editPostCommentTextFieldShadowColor = Colors.purple.shade900;
        editPostCommentTextFieldText2Color = Colors.white;
        editPostCommentTextFieldIconColor = Colors.white;
        editPostCommentTextFieldCursorColor = Colors.purple;
        editPostCommentTextFieldBorderColor = Colors.purple;
        editPostCommentTextFieldBorderWidth = 1.0;

        settingsTopNavBarBgColor = Colors.purple;
        settingsTopNavBarTextColor = Colors.white;
        settingsTextColor = Colors.purple.shade500;
        settingsIconColor = Colors.purple.shade600;

        loadingBgColor = Colors.purple.shade600;
        loadingColor = Colors.purple.shade200;
        break;
      case "pink":
        popupBgColor = Colors.white;
        successPopupTextColor = Colors.pink;
        errorPopupTextColor = Colors.red;

        registerBgColor = Colors.pink;
        registerTextFieldTextColor = Colors.pink;
        registerTextFieldShadowColor = Colors.pink.shade900;
        registerTextFieldText2Color = Colors.white;
        registerTextFieldIconColor = Colors.white;
        registerTextFieldCursorColor = Colors.pink;
        registerTextFieldBorderColor = Colors.pink;
        registerTextFieldBorderWidth = 1.0;

        loginTextFieldBgColor = Colors.pink.withOpacity(0.6);
        loginTextFieldTextColor = Colors.white;
        loginTextFieldIconColor = Colors.white;
        loginTextFieldButtonColor = Colors.pink.shade400;
        loginTextFieldText2Color = Colors.pink.shade400;
        loginTextFieldCursorColor = Colors.white;
        loginTextFieldBorderColor = Colors.white;
        loginTextFieldBorderWidth = 1.0;

        topNavBarBgColor = Colors.pink;
        topNavBarTextColor = Colors.white;

        leftDrawerBgColor = Colors.pink;
        leftDrawerTextColor = Colors.white;

        bottomNavBarBgColor = Colors.pink;
        bottomNavBarTextColor = Colors.white;

        postTypeFilterSectionTextColor = Colors.pink.shade500;
        postTypeFilterSectionIconColor = Colors.pink.shade600;
        postTypeFilterSectionIconSelectedColor = Colors.red.shade600;
        postTypeFilterSectionTextSelectedColor = Colors.red.shade500;

        postListTextColor = Colors.pink.shade500;
        postListButtonCancelColor = Colors.red.shade500;
        postListIconColor = Colors.pink.shade600;
        postListIconColor2 = Colors.red.shade600;
        postListButtonTextColor = Colors.white;

        profileTopNavBarBgColor = Colors.pink;
        profileTopNavBarTextColor = Colors.white;
        profileTextColor = Colors.pink.shade500;
        profileIconColor = Colors.pink.shade600;

        editProfileBgColor = Colors.pink;
        editProfileBgColor2 = Colors.red;
        editProfileTextFieldTextColor = Colors.pink;
        editProfileTextFieldShadowColor = Colors.pink.shade900;
        editProfileTextFieldText2Color = Colors.white;
        editProfileTextFieldIconColor = Colors.white;
        editProfileTextFieldCursorColor = Colors.pink;
        editProfileTextFieldBorderColor = Colors.pink;
        editProfileTextFieldBorderWidth = 1.0;

        createPostBgColor = Colors.pink;
        createPostBgColor2 = Colors.red;
        createPostTextFieldTextColor = Colors.pink;
        createPostTextFieldShadowColor = Colors.pink.shade900;
        createPostTextFieldText2Color = Colors.white;
        createPostTextFieldIconColor = Colors.white;
        createPostTextFieldCursorColor = Colors.pink;
        createPostTextFieldBorderColor = Colors.pink;
        createPostTextFieldBorderWidth = 1.0;

        mapWaitDuration = 1;
        mapShowDuration = 2;
        mapTooltipBgColor = Colors.pink.shade900;
        mapTooltipTextColor = Colors.white;
        mapPrimaryMarkerColor = Colors.red;
        mapSecondaryMarkerColor = Colors.blue;

        joinGroupBgColor = Colors.pink;
        joinGroupBgColor2 = Colors.pink.shade600;
        joinGroupBgColor3 = Colors.red.shade600;
        joinGroupBgColor4 = Colors.grey.shade600;
        joinGroupTextFieldTextColor = Colors.white;
        joinGroupTextFieldShadowColor = Colors.pink.shade900;
        joinGroupTextFieldIconColor = Colors.white;
        joinGroupTextFieldCursorColor = Colors.pink;
        joinGroupTextFieldBorderColor = Colors.pink;
        joinGroupTextFieldBorderWidth = 1.0;

        createGroupBgColor = Colors.pink;
        createGroupTextFieldTextColor = Colors.pink;
        createGroupTextFieldShadowColor = Colors.pink.shade900;
        createGroupTextFieldText2Color = Colors.white;
        createGroupTextFieldIconColor = Colors.white;
        createGroupTextFieldCursorColor = Colors.pink;
        createGroupTextFieldBorderColor = Colors.pink;
        createGroupTextFieldBorderWidth = 1.0;

        manageGroupBgColor = Colors.pink;
        manageGroupTextColor = Colors.pink;
        manageGroupShadowColor = Colors.pink.shade900;
        manageGroupText2Color = Colors.white;
        manageGroupIconColor = Colors.white;
        manageGroupCursorColor = Colors.pink;
        manageGroupBorderColor = Colors.pink;
        manageGroupButtonColor = Colors.pink;
        manageGroupButtonColor2 = Colors.red;
        manageGroupBorderWidth = 1.0;

        editGroupBgColor = Colors.pink;
        editGroupTextFieldTextColor = Colors.pink;
        editGroupTextFieldShadowColor = Colors.pink.shade900;
        editGroupTextFieldText2Color = Colors.white;
        editGroupTextFieldIconColor = Colors.white;
        editGroupTextFieldCursorColor = Colors.pink;
        editGroupTextFieldBorderColor = Colors.pink;
        editGroupTextFieldBorderWidth = 1.0;

        facilitiesBgColor = Colors.pink;
        facilitiesTooltipBgColor = const Color.fromARGB(228, 1, 89, 1);
        facilitiesTextColor = Colors.pink;
        facilitiesShadowColor = Colors.pink.shade900;
        facilitiesText2Color = Colors.white;
        facilitiesCursorColor = Colors.pink;
        facilitiesBorderColor = Colors.pink;
        facilitiesButtonColor = Colors.pink;
        facilitiesButtonColor2 = Colors.red;
        facilitiesButtonColor3 = Colors.pink.shade800;
        facilitiesIconColor = Colors.pink;
        facilitiesIconColor2 = Colors.red;
        facilitiesIconColor3 = Colors.white;
        facilitiesBorderWidth = 1.0;

        registerFacilitiesBgColor = Colors.pink;
        registerFacilitiesTextFieldTextColor = Colors.pink;
        registerFacilitiesTextFieldShadowColor = Colors.pink.shade900;
        registerFacilitiesTextFieldText2Color = Colors.white;
        registerFacilitiesTextFieldIconColor = Colors.white;
        registerFacilitiesTextFieldCursorColor = Colors.pink;
        registerFacilitiesTextFieldBorderColor = Colors.pink;
        registerFacilitiesTextFieldBorderWidth = 1.0;

        editPostBgColor = Colors.pink;
        editPostBgColor2 = Colors.red;
        editPostTextFieldTextColor = Colors.pink;
        editPostTextFieldShadowColor = Colors.pink.shade900;
        editPostTextFieldText2Color = Colors.white;
        editPostTextFieldIconColor = Colors.white;
        editPostTextFieldCursorColor = Colors.pink;
        editPostTextFieldBorderColor = Colors.pink;
        editPostTextFieldBorderWidth = 1.0;

        editPostCommentBgColor = Colors.pink;
        editPostCommentBgColor2 = Colors.red;
        editPostCommentTextFieldTextColor = Colors.pink;
        editPostCommentTextFieldShadowColor = Colors.pink.shade900;
        editPostCommentTextFieldText2Color = Colors.white;
        editPostCommentTextFieldIconColor = Colors.white;
        editPostCommentTextFieldCursorColor = Colors.pink;
        editPostCommentTextFieldBorderColor = Colors.pink;
        editPostCommentTextFieldBorderWidth = 1.0;

        settingsTopNavBarBgColor = Colors.pink;
        settingsTopNavBarTextColor = Colors.white;
        settingsTextColor = Colors.pink.shade500;
        settingsIconColor = Colors.pink.shade600;

        loadingBgColor = Colors.pink.shade600;
        loadingColor = Colors.pink.shade200;
        break;
    }
  }

  // Initialize attributes
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
  Color editProfileBgColor2 = Colors.red;
  Color editProfileTextFieldTextColor = Colors.green;
  Color editProfileTextFieldShadowColor = Colors.green.shade900;
  Color editProfileTextFieldText2Color = Colors.white;
  Color editProfileTextFieldIconColor = Colors.white;
  Color editProfileTextFieldCursorColor = Colors.green;
  Color editProfileTextFieldBorderColor = Colors.green;
  double editProfileTextFieldBorderWidth = 1.0;

  Color createPostBgColor = Colors.green;
  Color createPostBgColor2 = Colors.red;
  Color createPostTextFieldTextColor = Colors.green;
  Color createPostTextFieldShadowColor = Colors.green.shade900;
  Color createPostTextFieldText2Color = Colors.white;
  Color createPostTextFieldIconColor = Colors.white;
  Color createPostTextFieldCursorColor = Colors.green;
  Color createPostTextFieldBorderColor = Colors.green;
  double createPostTextFieldBorderWidth = 1.0;

  int mapWaitDuration = 1;
  int mapShowDuration = 2;
  Color mapTooltipBgColor = Colors.green.shade900;
  Color mapTooltipTextColor = Colors.white;
  Color mapPrimaryMarkerColor = Colors.red;
  Color mapPrimaryUserMarkerColor = const Color.fromARGB(200, 0, 255, 255);
  Color mapSecondaryMarkerColor = Colors.blue;
  Color mapTertiaryMarkerColor = Colors.orange;

  Color joinGroupBgColor = Colors.green;
  Color joinGroupBgColor2 = Colors.green.shade600;
  Color joinGroupBgColor3 = Colors.red.shade600;
  Color joinGroupBgColor4 = Colors.grey.shade600;
  Color joinGroupTextFieldTextColor = Colors.white;
  Color joinGroupTextFieldShadowColor = Colors.green.shade900;
  Color joinGroupTextFieldIconColor = Colors.white;
  Color joinGroupTextFieldCursorColor = Colors.green;
  Color joinGroupTextFieldBorderColor = Colors.green;
  double joinGroupTextFieldBorderWidth = 1.0;

  Color createGroupBgColor = Colors.green;
  Color createGroupTextFieldTextColor = Colors.green;
  Color createGroupTextFieldShadowColor = Colors.green.shade900;
  Color createGroupTextFieldText2Color = Colors.white;
  Color createGroupTextFieldIconColor = Colors.white;
  Color createGroupTextFieldCursorColor = Colors.green;
  Color createGroupTextFieldBorderColor = Colors.green;
  double createGroupTextFieldBorderWidth = 1.0;

  Color manageGroupBgColor = Colors.green;
  Color manageGroupTextColor = Colors.green;
  Color manageGroupShadowColor = Colors.green.shade900;
  Color manageGroupText2Color = Colors.white;
  Color manageGroupIconColor = Colors.white;
  Color manageGroupCursorColor = Colors.green;
  Color manageGroupBorderColor = Colors.green;
  Color manageGroupButtonColor = Colors.green;
  Color manageGroupButtonColor2 = Colors.red;
  double manageGroupBorderWidth = 1.0;

  Color editGroupBgColor = Colors.green;
  Color editGroupTextFieldTextColor = Colors.green;
  Color editGroupTextFieldShadowColor = Colors.green.shade900;
  Color editGroupTextFieldText2Color = Colors.white;
  Color editGroupTextFieldIconColor = Colors.white;
  Color editGroupTextFieldCursorColor = Colors.green;
  Color editGroupTextFieldBorderColor = Colors.green;
  double editGroupTextFieldBorderWidth = 1.0;

  Color facilitiesBgColor = Colors.green;
  Color facilitiesTooltipBgColor = const Color.fromARGB(228, 1, 89, 1);
  Color facilitiesTextColor = Colors.green;
  Color facilitiesShadowColor = Colors.green.shade900;
  Color facilitiesText2Color = Colors.white;
  Color facilitiesCursorColor = Colors.green;
  Color facilitiesBorderColor = Colors.green;
  Color facilitiesButtonColor = Colors.green;
  Color facilitiesButtonColor2 = Colors.red;
  Color facilitiesButtonColor3 = Colors.green.shade800;
  Color facilitiesIconColor = Colors.green;
  Color facilitiesIconColor2 = Colors.red;
  Color facilitiesIconColor3 = Colors.white;
  double facilitiesBorderWidth = 1.0;

  Color registerFacilitiesBgColor = Colors.green;
  Color registerFacilitiesTextFieldTextColor = Colors.green;
  Color registerFacilitiesTextFieldShadowColor = Colors.green.shade900;
  Color registerFacilitiesTextFieldText2Color = Colors.white;
  Color registerFacilitiesTextFieldIconColor = Colors.white;
  Color registerFacilitiesTextFieldCursorColor = Colors.green;
  Color registerFacilitiesTextFieldBorderColor = Colors.green;
  double registerFacilitiesTextFieldBorderWidth = 1.0;

  Color editPostBgColor = Colors.green;
  Color editPostBgColor2 = Colors.red;
  Color editPostTextFieldTextColor = Colors.green;
  Color editPostTextFieldShadowColor = Colors.green.shade900;
  Color editPostTextFieldText2Color = Colors.white;
  Color editPostTextFieldIconColor = Colors.white;
  Color editPostTextFieldCursorColor = Colors.green;
  Color editPostTextFieldBorderColor = Colors.green;
  double editPostTextFieldBorderWidth = 1.0;

  Color editPostCommentBgColor = Colors.green;
  Color editPostCommentBgColor2 = Colors.red;
  Color editPostCommentTextFieldTextColor = Colors.green;
  Color editPostCommentTextFieldShadowColor = Colors.green.shade900;
  Color editPostCommentTextFieldText2Color = Colors.white;
  Color editPostCommentTextFieldIconColor = Colors.white;
  Color editPostCommentTextFieldCursorColor = Colors.green;
  Color editPostCommentTextFieldBorderColor = Colors.green;
  double editPostCommentTextFieldBorderWidth = 1.0;

  Color settingsTopNavBarBgColor = Colors.green;
  Color settingsTopNavBarTextColor = Colors.white;
  Color settingsTextColor = Colors.green.shade500;
  Color settingsIconColor = Colors.green.shade600;

  Color loadingBgColor = Colors.green.shade600;
  Color loadingColor = Colors.green.shade200;
}
