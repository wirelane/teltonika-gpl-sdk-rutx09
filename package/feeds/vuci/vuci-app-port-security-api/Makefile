include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI API Support for Port Security

ifeq (y, $(CONFIG_SWITCH_DEVICE))
	APP_DEPENDS:=+dot1x-server
else ifeq (y, $(CONFIG_HAS_DOT1X_SERVER))
	APP_DEPENDS:=+dsa-dot1x-server
endif

include ../api.mk

# call BuildPackage - OpenWrt buildroot signature
