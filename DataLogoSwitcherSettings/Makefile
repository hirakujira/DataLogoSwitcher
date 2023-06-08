BUNDLE_NAME = DataLogoSwitcher
DataLogoSwitcher_FILES = DataLogoSwitcher.m
DataLogoSwitcher_INSTALL_PATH = /Library/PreferenceBundles
DataLogoSwitcher_FRAMEWORKS = UIKit
DataLogoSwitcher_CFLAGS = -fobjc-arc
DataLogoSwitcher_PRIVATE_FRAMEWORKS = Preferences

SDKVERSION = 9.2
SYSROOT = $(THEOS)/sdks/iPhoneOS9.2.sdk

ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	ARCHS = arm64 arm64e
	TARGET = iphone:16.2:12.0
else
	ARCHS = arm64 arm64e
	TARGET = iphone:12.1.2:11.0
endif


GO_EASY_ON_ME = 1

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk
