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
  Color mapSecondaryMarkerColor = Colors.blue;

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
}
