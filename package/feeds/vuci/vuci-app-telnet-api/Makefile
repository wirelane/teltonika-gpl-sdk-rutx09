include $(TOPDIR)/rules.mk

APP_APP_NAME:=telnet
APP_TITLE:=VuCI API Support for Telnet
APP_TLT_NAME:=Telnet
APP_ROUTER:=$(TLT_PLATFORM_NAME)

define Package/vuci-app-telnet-api/prerm
#!/bin/sh
	uci set telnetd.@telnetd[0].enable="0"
	uci -q commit telnetd
	/etc/init.d/telnetd reload
	exit 0
endef

include ../api.mk

define Package/vuci-app-telnet-api/description
	Telnet is a protocol that allows you to connect to remote computers (called hosts) over a TCP/IP network 
endef

# call BuildPackage - OpenWrt buildroot signature
