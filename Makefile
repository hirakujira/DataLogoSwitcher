TWEAK_NAME = DataLogoSwitcher
DataLogoSwitcher_OBJCC_FILES = Tweak.x
DataLogoSwitcher_CFLAGS = -F$(SYSROOT)/System/Library/CoreServices -fobjc-arc
DataLogoSwitcher_FRAMEWORKS = Foundation UIKit
DataLogoSwitcher_PRIVATE_FRAMEWORKS = Foundation
GO_EASY_FOR_ME = 1
FINALPACKAGE = 1

SDKVERSION = 9.2
SYSROOT = $(THEOS)/sdks/iPhoneOS9.2.sdk

ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	ARCHS = arm64 arm64e
	TARGET = iphone:16.2:12.0
else
	ARCHS = armv7 arm64 arm64e
	TARGET = iphone:12.1.2:7.0
endif

SUBPROJECTS += DataLogoSwitcherSettings

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

sync: stage
	rsync -e "ssh -p 2222" -z .theos/_/Library/MobileSubstrate/DynamicLibraries/* root@127.0.0.1:/Library/MobileSubstrate/DynamicLibraries/
	rsync -e "ssh -p 2222" -avz .theos/_/Library/PreferenceBundles/DataLogoSwitcher.bundle/* root@127.0.0.1:/Library/PreferenceBundles/DataLogoSwitcher.bundle/
	ssh root@127.0.0.1 -p 2222 killall backboardd
