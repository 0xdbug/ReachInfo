ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ReachInfo

ReachInfo_FILES = Tweak.xm $(wildcard ./Widgets/*.m)
ReachInfo_CFLAGS = -fobjc-arc
ReachInfo_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += ReachInfoPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk
