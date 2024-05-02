include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI UI Support for Ntrip

APP_TLT_NAME:=NTRIP
APP_ROUTER:=$(TLT_PLATFORM_NAME)
APP_APP_NAME:=ntrip_client_v2

define Package/vuci-app-ntrip-ui/teltonika_rut9m
  PKG_ROUTER:=RUT956 RUT906
endef

define Package/vuci-app-ntrip-ui/mdm9x07
  PKG_ROUTER:=TRB142 TRB145
endef

define Package/vuci-app-ntrip-ui/teltonika_trb2xx
  PKG_ROUTER:=TRB245 TRB255
endef

define Package/vuci-app-ntrip-ui/teltonika_rutx
  PKG_ROUTER:=RUTX09 RUTX11 RUTX12 RUTX14 RUTXR1 RUTX50 RUTX10 RUTX08
endef

define Package/vuci-app-ntrip-ui/teltonika_rut14x
  PKG_ROUTER:=RUT142
endef

include ../app.mk

define Package/vuci-app-ntrip-ui/description
  NTRIP client designed for providing differential correction data acquired via Internet Protocol to RTK receiver or rover connected via serial connection.
  It is not meant to correct the GPS coordinates of the Teltonika device itself.
endef

# call BuildPackage - OpenWrt buildroot signature
