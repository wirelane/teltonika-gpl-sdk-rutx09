include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for I/O Post Get

ifeq (m, $(CONFIG_PACKAGE_vuci-app-io-post-get-ui))
	APP_TLT_NAME:=I/O POST/GET
	APP_ROUTER:=$(TLT_PLATFORM_NAME)
	APP_APP_NAME:=io_post_get
	APP_HW_INFO:=ios
endif

include ../app.mk

define Package/vuci-app-io-post-get-ui/description
	I/O control via HTTP POST/GET requests.
endef

# call BuildPackage - OpenWrt buildroot signature
