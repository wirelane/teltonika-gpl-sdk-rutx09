include $(TOPDIR)/rules.mk

PKG_LICENSE:=Teltonika-nda-source

APP_TITLE:=VuCI UI Support for SIM Idle protection

ifeq (m, $(CONFIG_PACKAGE_vuci-app-sim-idle-protection-ui))
	APP_APP_NAME:=sim_idle_protection
	APP_TLT_NAME:=SIM Idle Protection
	APP_ROUTER:=$(TLT_PLATFORM_NAME)
endif

define Package/vuci-app-sim-idle-protection-ui/description
	Package enabling periodic switching to a secondary SIM card for data
	connection, preventing SIM card blockage due to inactivity.
endef

define Package/vuci-app-sim-idle-protection-ui/teltonika_rutx
	PKG_ROUTER:=RUTX09 RUTX11 RUTXR1 RUTX14 RUTX50
endef

define Package/vuci-app-sim-idle-protection-ui/teltonika_rutm
	PKG_ROUTER:=RUTM09 RUTM11 RUTM14 RUTM50 RUTM51
endef

include ../app.mk

# call BuildPackage - OpenWrt buildroot signature
