ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

SYSROOT = $(THEOS)/sdks/iPhoneOS13.4.sdk
PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/

BUNDLE_NAME = ReachInfoPrefs

ReachInfoPrefs_FILES = $(wildcard *.m) $(wildcard ./libappearancecell/*.m)
ReachInfoPrefs_INSTALL_PATH = /Library/PreferenceBundles
ReachInfoPrefs_FRAMEWORKS = UIKit
ReachInfoPrefs_PRIVATE_FRAMEWORKS = Preferences
ReachInfoPrefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
ReachInfoPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ReachInfoPrefs.plist$(ECHO_END)
