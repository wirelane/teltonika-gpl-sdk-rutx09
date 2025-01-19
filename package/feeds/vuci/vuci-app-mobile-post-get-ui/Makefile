include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for Mobile Post Get

ifeq (m, $(CONFIG_PACKAGE_vuci-app-mobile-post-get-ui))
	APP_TLT_NAME:=Mobile POST/GET
	APP_ROUTER:=$(TLT_PLATFORM_NAME)
	APP_APP_NAME:=mobile_post_get
	APP_HW_INFO:=mobile
endif

include ../app.mk

define Package/vuci-app-mobile-post-get-ui/description
	Mobile control via HTTP POST/GET requests.
endef

# call BuildPackage - OpenWrt buildroot signature
