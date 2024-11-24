include $(TOPDIR)/rules.mk

APP_TITLE:=VuCI API Support for Data Sender

# call BuildPackage - OpenWrt buildroot signature

CUSTOM_INSTALL=1

include ../api.mk

define InstallLuaFile
	if [[ -n "$${CONFIG_VUCI_COMPILE_LUA}" ]] && [[ -f $$(PKG_BUILD_DIR)/files/usr/lib/lua/api/services/$(1).lua ]]; then \
		$$(CP) $$(PKG_BUILD_DIR)/files/usr/lib/lua/api/services/$(1).lua $(2)/usr/lib/lua/api/services/$(1).lua; \
	elif [[ -f ./files/usr/lib/lua/api/services/$(1).lua ]]; then \
		$$(INSTALL_BIN) ./files/usr/lib/lua/api/services/$(1).lua $(2)/usr/lib/lua/api/services/$(1).lua; \
	fi
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/api/services
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DIR) $(1)/usr/lib/lua/vuci
	$(INSTALL_BIN) ./files/usr/lib/lua/vuci/ds_update_list.lua $(1)/usr/lib/lua/vuci/ds_update_list.lua
	$(CP) ./files/usr/share/rpcd/acl.d/datasender.json $(1)/usr/share/rpcd/acl.d/datasender.json
	$(if $(CONFIG_VUCI_MINIFY_JSON),$(call JsonMin,$(1)/),true);
	$(call InstallLuaFile,data_sender_collections,$(1))
	$(call InstallLuaFile,data_sender_inputs,$(1))
	$(call InstallLuaFile,data_sender_outputs,$(1))
	$(call InstallLuaFile,data_sender_format,$(1))
	$(call InstallLuaFile,data_sender_utils,$(1))
endef

define InstallLuaModuleFile
	if [[ -n "$${CONFIG_VUCI_COMPILE_LUA}" ]] && [[ -f $$(PKG_BUILD_DIR)/files/usr/lib/lua/api/services/$(1)/$(2).lua ]]; then \
		$$(CP) $$(PKG_BUILD_DIR)/files/usr/lib/lua/api/services/$(1)/$(2).lua $(3)/usr/lib/lua/api/services/$(1)/$(2).lua; \
	elif [[ -f ./files/usr/lib/lua/api/services/$(1)/$(2).lua ]]; then \
		$$(INSTALL_BIN) ./files/usr/lib/lua/api/services/$(1)/$(2).lua $(3)/usr/lib/lua/api/services/$(1)/$(2).lua; \
	fi
endef

define GenerateDataToServerModule
define Package/data-sender-api-mod-$(2)
	SECTION:=vuci
	CATEGORY:=VuCI
	SUBMENU:=Applications/API
	TITLE:=Vuci Data Sender API $(1) module
	ifneq ($(2), azure)
		DEPENDS:=+data-sender-mod-$(2)
	endif
endef

define Package/data-sender-api-mod-$(2)/install
	$(INSTALL_DIR) $$(1)/usr/lib/lua/api/services/$(3)
	$(call InstallLuaModuleFile,$(3),$(4),$$(1))
endef

define Package/data-sender-api-mod-$(2)/postinst
#!/bin/sh
[ -z "$${IPKG_INSTROOT}" ] || exit 0

lua -e 'ds_update = require "vuci.ds_update_list"; ds_update:update_list();'

exit 0
endef


define Package/data-sender-api-mod-$(2)/postrm
#!/bin/sh
[ -z "$${IPKG_INSTROOT}" ] || exit 0

FILE_PATH="/tmp/data_sender/plugin_data.json"

if [ -f "$${FILE_PATH}" ]; then
    rm -f "$${FILE_PATH}"
fi

exit 0
endef

$$(eval $$(call BuildPackage,data-sender-api-mod-$(2)))
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call GenerateDataToServerModule,Format Custom,format-custom,ds_formats,ds_format_custom))
$(eval $(call GenerateDataToServerModule,Lua Format,lua_format,ds_formats,ds_format_lua))
$(eval $(call GenerateDataToServerModule,MQTT Input,mqtt-in,ds_inputs,ds_input_mqtt))
$(eval $(call GenerateDataToServerModule,MQTT Output,mqtt-out,ds_outputs,ds_output_mqtt))
$(eval $(call GenerateDataToServerModule,HTTP,http,ds_outputs,ds_output_http))
$(eval $(call GenerateDataToServerModule,UBUS,ubus,ds_outputs,ds_output_ubus))
$(eval $(call GenerateDataToServerModule,Bluetooth,bluetooth,ds_inputs,ds_input_bluetooth))
$(eval $(call GenerateDataToServerModule,Mbus,mbus,ds_inputs,ds_input_mbus))
$(eval $(call GenerateDataToServerModule,Lua,lua-in,ds_inputs,ds_input_lua))
$(eval $(call GenerateDataToServerModule,GSM,gsm,ds_inputs,ds_input_gsm))
$(eval $(call GenerateDataToServerModule,Mobile Usage,mdcollect,ds_inputs,ds_input_mdcollect))
$(eval $(call GenerateDataToServerModule,Modbus Alarm,modbus-alarm,ds_inputs,ds_input_modbus_alarm))
$(eval $(call GenerateDataToServerModule,Modbus,modbus,ds_inputs,ds_input_modbus))
$(eval $(call GenerateDataToServerModule,DNP3,dnp3,ds_inputs,ds_input_dnp3))
$(eval $(call GenerateDataToServerModule,OPCUA,opcua,ds_inputs,ds_input_opcua))
$(eval $(call GenerateDataToServerModule,Impulse Counter,impulse_counter,ds_inputs,ds_input_impulse_counter))
$(eval $(call GenerateDataToServerModule,Dlms,dlms,ds_inputs,ds_input_dlms))
$(eval $(call GenerateDataToServerModule,WifiScan,wifiscan,ds_inputs,ds_input_wifiscan))
$(eval $(call GenerateDataToServerModule,Azure,azure,ds_outputs,ds_output_azure))
