ARCHS = arm64 arm64e
TARGET = iphone:latest::13.0

SYSROOT = $(THEOS)/sdks/iPhoneOS14.5.sdk
PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ReachInfo

ReachInfo_FILES = Tweak.xm ReachInfoView.m $(wildcard ./Widgets/*.m) $(wildcard ./Widgets/*.xm) $(wildcard ./Helpers/*.m)
ReachInfo_CFLAGS = -fobjc-arc
ReachInfo_LDFLAGS += -lobjc
ReachInfo_EXTRA_FRAMEWORKS += Cephei
ReachInfo_PRIVATE_FRAMEWORKS = EventKit MediaRemote
ReachInfo_LIBRARIES += pddokdo

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += ReachInfoPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk
