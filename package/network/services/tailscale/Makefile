#
# Copyright (C) 2021 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tailscale
PKG_VERSION:=1.92.3
PKG_RELEASE:=16

PKG_HASH:=805b2eb3526e14c61c09b7e14ee2ad5bd17ce25ff13961342302737c138041d4

PKG_SOURCE_VERSION:=1.92.3
PKG_SOURCE=tailscale-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/tailscale/tailscale/tar.gz/v$(PKG_SOURCE_VERSION)?

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec1@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:tailscale:tailscale

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=\
	tailscale.com/cmd/tailscale \
	tailscale.com/cmd/tailscaled
GO_PKG_LDFLAGS:=-s -w -X 'tailscale.com/version.longStamp=$(PKG_VERSION)-$(PKG_RELEASE) (OpenWrt)'
GO_PKG_LDFLAGS_X:=tailscale.com/version.shortStamp=$(PKG_VERSION)
GO_PKG_TAGS:= \
	ts_include_cli \
	ts_omit_aws \
	ts_omit_webclient \
	ts_omit_kube \
	ts_omit_synology \
	ts_omit_systray \
	ts_omit_dbus \
	ts_omit_networkmanager \
	ts_omit_desktop_sessions \
	ts_omit_resolved \
	ts_omit_sdnotify \
	ts_omit_cloud \
	ts_omit_completion \
	ts_omit_clientupdate

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/package/lang/golang/golang-package.mk

RSTRIP:=:
STRIP:=:

define Package/tailscale
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=Zero config VPN
  URL:=https://tailscale.com
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle +kmod-tun
  USERID:=tailscale:tailscale
  FATTRS:=/usr/sbin/tailscale.combined::::cap_net_admin,cap_net_raw+ep
endef

define Build/Compile
	$(call GoPackage/Build/Compile)
	$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/tailscaled
endef

define Package/tailscale/description
  It creates a secure network between your servers, computers,
  and cloud instances. Even when separated by firewalls or subnets.
endef

define Package/tailscale/conffiles
/etc/config/tailscale
endef

define Package/tailscale/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/tailscaled $(1)/usr/sbin/tailscale.combined
	ln -s tailscale.combined $(1)/usr/sbin/tailscale
	ln -s tailscale.combined $(1)/usr/sbin/tailscaled
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN_USR) ./files/tailscale.init $(1)/etc/init.d/tailscale
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF_USR) ./files/tailscale.conf $(1)/etc/config/tailscale
	$(INSTALL_DIR) $(1)/etc/uci-defaults/7.6
	$(INSTALL_DATA) ./files/defaults/99_tailscale_fw_rules $(1)/etc/uci-defaults/7.6/99_tailscale_fw_rules
	$(INSTALL_DIR) $(1)/etc/permtab.d
	$(INSTALL_DATA) ./files/tailscale.permtab $(1)/etc/permtab.d/tailscale
endef

define Package/tailscale/prerm
	#!/bin/sh
	. /lib/functions.sh

	clean_zones() {
		config_get name "$$1" name ""
		[ "$$name" = "tailscale" ] && uci_remove firewall "$$1"
	}

	clean_forwardings() {
		config_get dest "$$1" dest ""
		config_get src "$$1" src ""
		[ "$$dest" = "tailscale" ] || [ "$$src" = "tailscale" ] && uci_remove firewall "$$1"
	}

	config_load 'firewall'
	config_foreach clean_zones "zone"
	config_foreach clean_forwardings "forwarding"
	uci_commit firewall
	/etc/init.d/firewall reload > /dev/null 2>&1
	exit 0
endef


$(eval $(call BuildPackage,tailscale))
