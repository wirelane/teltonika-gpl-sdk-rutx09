include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for UPnP

ifeq (m, $(CONFIG_PACKAGE_vuci-app-upnp-ui))
	APP_TLT_NAME:=UPNP
	APP_ROUTER:=$(TLT_PLATFORM_NAME)
	APP_APP_NAME:=miniupnpd
endif

define Package/vuci-app-upnp-ui/prerm
#!/bin/sh
	uci delete firewall.miniupnpd
	uci -q commit firewall
	/etc/init.d/firewall reload
	exit 0
endef

include ../app.mk

define Package/vuci-app-upnp-ui/description
	UPnP (Universal Plug and Play) is a service that allows clients in
	the local network to automatically configure some devices and services.
endef

# call BuildPackage - OpenWrt buildroot signature
