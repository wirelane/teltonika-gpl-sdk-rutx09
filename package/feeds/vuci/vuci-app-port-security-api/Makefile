include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI API Support for 802.1X
APP_DEPENDS:=

ifeq (y, $(CONFIG_SWITCH_DEVICE))
	APP_DEPENDS+=+dot1x-server +radius_test +dot1x-client
endif

ifeq (y, $(CONFIG_HAS_DOT1X_SERVER))
	APP_DEPENDS+=+dsa-dot1x-server +radius_test
endif

ifeq (y, $(CONFIG_HAS_DOT1X_CLIENT))
	APP_DEPENDS+=+dot1x-client
endif

include ../api.mk

# call BuildPackage - OpenWrt buildroot signature
