BUNDLE_NAME = DataLogoSwitcher
DataLogoSwitcher_FILES = DataLogoSwitcher.mm
DataLogoSwitcher_INSTALL_PATH = /Library/PreferenceBundles
DataLogoSwitcher_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore MessageUI
DataLogoSwitcher_PRIVATE_FRAMEWORKS = Preferences

IP_ADDRESS=127.0.0.1
RSYNC_SETTINGS = -e "ssh -p 2222" -z
SSH_PORT = -p 2222
DataLogoSwitcher_CFLAGS = -I$(SYSROOT)/usr/include/libxml2
DataLogoSwitcher_LDFLAGS = -lxml2

SDKVERSION = 9.2
SYSROOT = $(THEOS)/sdks/iPhoneOS9.2.sdk
ARCHS = armv7 armv7s arm64 arm64e
TARGET = iphone:clang::5.0

GO_EASY_ON_ME = 1

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk