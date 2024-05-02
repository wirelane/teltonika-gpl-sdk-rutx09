include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for miniDLNA

APP_TLT_NAME:=DLNA
APP_ROUTER:=$(TLT_PLATFORM_NAME)
APP_APP_NAME:=tlt-minidlna

define Package/vuci-app-minidlna-ui/teltonika_rut9m
  PKG_ROUTER:=RUT956 RUT906
endef

include ../app.mk

define Package/vuci-app-minidlna-ui/description
  MiniDLNA is a lightweight DLNA/UPnP media server. It serves
  media files (music, pictures, and video) to clients on a network.
endef

# call BuildPackage - OpenWrt buildroot signature
