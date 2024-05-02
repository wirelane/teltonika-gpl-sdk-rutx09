include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for Samba application

ifeq (m, $(CONFIG_PACKAGE_vuci-app-samba-ui))
	APP_TLT_NAME:=Network shares
	APP_ROUTER:=$(TLT_PLATFORM_NAME)
	APP_APP_NAME:=samba36-server
endif

define Package/vuci-app-samba-ui/teltonika_rut9m
  PKG_ROUTER:=RUT956 RUT906
endef

include ../app.mk

define Package/vuci-app-samba-ui/description
	Samba is a software solution for using the Server Message Block (SMB)
	networking protocol, which provides shared file access between
	nodes on a computer network.
endef

# call BuildPackage - OpenWrt buildroot signature
