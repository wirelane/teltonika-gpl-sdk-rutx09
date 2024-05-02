include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for SMPP

APP_TLT_NAME:=SMPP
APP_ROUTER:=$(TLT_PLATFORM_NAME)
APP_APP_NAME:=smpp

define Package/vuci-app-smpp-ui/teltonika_rutx
	PKG_ROUTER:=RUTX09 RUTX11 RUTX12 RUTX14 RUTXR1 RUTX50
endef

define Package/vuci-app-smpp-ui/teltonika_rutm
	PKG_ROUTER:=RUTM09 RUTM11 RUTM12 RUTM14 RUTM50 RUTM51 RUTM52
endef

include ../app.mk

define Package/vuci-app-smpp-ui/description
	SMPP package that provides SMPP protocol
	services for flexible short message data transfer.
endef

# call BuildPackage - OpenWrt buildroot signature
