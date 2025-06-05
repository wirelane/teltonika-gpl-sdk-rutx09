include $(INCLUDE_DIR)/hardware.mk

define Device/teltonika_rutx_common
	HARDWARE/Wireless/Wireless_mode := $(HW_WIFI_5)
	HARDWARE/Wireless/WIFI_users := $(HW_WIFI_150_USERS)
	HARDWARE/WAN/Port := 1 $(HW_ETH_WAN_PORT)
	HARDWARE/WAN/Speed := $(HW_ETH_SPEED_1000)
	HARDWARE/WAN/Standard := $(HW_ETH_LAN_2_STANDARD)
	HARDWARE/LAN/Port := 3 $(HW_ETH_LAN_PORTS)
	HARDWARE/LAN/Speed := $(HW_ETH_SPEED_1000)
	HARDWARE/LAN/Standard := $(HW_ETH_LAN_2_STANDARD)
	HARDWARE/System_Characteristics/CPU := Quad-core ARM Cortex A7, 717 MHz
	HARDWARE/System_Characteristics/RAM := $(HW_RAM_SIZE_256M), $(HW_RAM_TYPE_DDR3)
	HARDWARE/System_Characteristics/Flash_Storage := $(HW_FLASH_SIZE_256M), $(HW_FLASH_TYPE_SPI)
	HARDWARE/USB/Data_rate := $(HW_USB_2_DATA_RATE)
	HARDWARE/USB/Applications := $(HW_USB_APPLICATIONS)
	HARDWARE/USB/External_devices := $(HW_USB_EXTERNAL_DEV)
	HARDWARE/USB/Storage_formats := $(HW_USB_STORAGE_FORMATS)
	HARDWARE/Input_Output/Input := 1 $(HW_INPUT_DI_30V)
	HARDWARE/Input_Output/Output := 1 $(HW_OUTPUT_DO_30V)
	HARDWARE/Power/Connector := $(HW_POWER_CONNECTOR_4PIN)
	HARDWARE/Power/Input_voltage_range := 9 - 50 VDC, reverse polarity protection, voltage surge/transient protection
	HARDWARE/Power/PoE_Standards := $(HW_POWER_POE_PASSIVE_50V)
	HARDWARE/Physical_Interfaces/Ethernet := 4 $(HW_ETH_RJ45_PORTS), $(HW_ETH_SPEED_1000)
	HARDWARE/Physical_Interfaces/IO := $(HW_INTERFACE_IO_4PIN_IN_OUT)
	HARDWARE/Physical_Interfaces/Power := $(HW_INTERFACE_POWER_4PIN)
	HARDWARE/Physical_Interfaces/USB := 1 $(HW_INTERFACE_USB)
	HARDWARE/Physical_Interfaces/Reset := $(HW_INTERFACE_RESET)
	HARDWARE/Physical_Specification/Casing_material := $(HW_PHYSICAL_HOUSING_AL)
	HARDWARE/Physical_Specification/Mounting_options := $(HW_PHYSICAL_MOUNTING_KIT)
	HARDWARE/Operating_Environment/Operating_Temperature := $(HW_OPERATING_TEMP)
	HARDWARE/Operating_Environment/Operating_Humidity := $(HW_OPERATING_HUMIDITY)
	HARDWARE/Operating_Environment/Ingress_Protection_Rating := $(HW_OPERATING_PROTECTION_IP30)
endef

define Device/template_rutx_common
	$(Device/teltonika_rutx)

	DEVICE_WLAN_BSSID_LIMIT := wlan0 16, wlan1 16

	DEVICE_LAN_OPTION := eth0
	DEVICE_WAN_OPTION := eth1

	DEVICE_USB_JACK_PATH := /usb1/1-1/

	DEVICE_NET_CONF :=       \
		vlans          128, \
		max_mtu        9000, \
		readonly_vlans 2

	DEVICE_INTERFACE_CONF := \
		lan default_ip 192.168.1.1

endef

define Device/TEMPLATE_teltonika_rutx08
	$(Device/teltonika_rutx_common)
	$(Device/template_rutx_common)
	DEVICE_MODEL := RUTX08
	DEVICE_SWITCH_CONF := "switch0" \
		"0u@eth0" "2:lan:1" "3:lan:2" "4:lan:3" "0u@eth1" "5:wan"
	DEVICE_FEATURES := usb ethernet ios nat_offloading \
		multi_tag port_link gigabit_port xfrm-offload tpm reset_button

	HARDWARE/Wireless/Wireless_mode :=
	HARDWARE/Wireless/WIFI_users :=
	HARDWARE/Power/Power_consumption := 6 W Max
	HARDWARE/Physical_Interfaces/Status_leds := 8 x LAN status LEDs, 1 x Power LED
	HARDWARE/Physical_Specification/Weight := 345 g
	HARDWARE/Physical_Specification/Dimensions := 115 x 32.2 x 95.2 mm
endef
TARGET_DEVICES += TEMPLATE_teltonika_rutx08

define Device/TEMPLATE_teltonika_rutx09
	$(Device/teltonika_rutx_common)
	$(Device/template_rutx_common)
	DEVICE_MODEL := RUTX09
	DEVICE_SWITCH_CONF := "switch0" \
		"0u@eth0" "2:lan:1" "3:lan:2" "4:lan:3" "0u@eth1" "5:wan"
	DEVICE_FEATURES := dual_sim usb gps mobile ethernet ios \
		nat_offloading multi_tag port_link gigabit_port \
		xfrm-offload tpm reset_button

	HARDWARE/Mobile/Module := 4G LTE Cat 6 up to 300 DL/ 50 UL Mbps; 3G up to 42 DL/ 5.76 UL Mbps
	HARDWARE/Mobile/3GPP_Release := Release 12
	HARDWARE/Wireless/Wireless_mode :=
	HARDWARE/Wireless/WIFI_users :=
	HARDWARE/Power/Power_consumption := 9 W Max
	HARDWARE/Physical_Interfaces/Status_leds := 3 x WAN type, 2 x Mobile connection type, 5 x Mobile connection strength, 8 x LAN status, 3 x WAN status, 1x Power
	HARDWARE/Physical_Interfaces/SIM := 2 $(HW_INTERFACE_SIM_HOLDERS)
	HARDWARE/Physical_Interfaces/Antennas := 2 x SMA for LTE, 1 x SMA for GNNS
	HARDWARE/Physical_Specification/Weight := 455 g
	HARDWARE/Physical_Specification/Dimensions := 115 x 44.2 x 95.1 mm
endef
TARGET_DEVICES += TEMPLATE_teltonika_rutx09

define Device/TEMPLATE_teltonika_rutx10
	$(Device/teltonika_rutx_common)
	$(Device/template_rutx_common)
	DEVICE_MODEL := RUTX10
	DEVICE_SWITCH_CONF := "switch0" \
		"0u@eth0" "2:lan:1" "3:lan:2" "4:lan:3" "0u@eth1" "5:wan"
	DEVICE_FEATURES := bluetooth usb wifi dual_band_ssid ethernet \
		ios nat_offloading multi_tag port_link gigabit_port \
		xfrm-offload tpm reset_button

	HARDWARE/Bluetooth/Bluetooth_4.0 := $(HW_BT_LE)
	HARDWARE/Power/Power_consumption := 9 W Max
	HARDWARE/Physical_Interfaces/Status_leds := 8 x LAN status LEDs, 1 x Power LED, 2 x 2.4G and 5G Wi-Fi LEDs
	HARDWARE/Physical_Interfaces/Antennas := 2 x RP-SMA for Wi-Fi, 1 x RP-SMA for Bluetooth
	HARDWARE/Physical_Specification/Weight := 355 g
	HARDWARE/Physical_Specification/Dimensions := 115 x 32.2 x 95.2 mm

	DEVICE_CHECK_PATH := bt_check /sys/bus/usb/drivers/usb/1-1.4/ reboot 13.0-
endef
TARGET_DEVICES += TEMPLATE_teltonika_rutx10

define Device/TEMPLATE_teltonika_rutx11
	$(Device/teltonika_rutx_common)
	$(Device/template_rutx_common)
	DEVICE_MODEL := RUTX11
	DEVICE_SWITCH_CONF := "switch0" \
		"0u@eth0" "2:lan:1" "3:lan:2" "4:lan:3" "0u@eth1" "5:wan"
	DEVICE_FEATURES := dual_sim usb gps mobile wifi dual_band_ssid bluetooth \
		ethernet ios nat_offloading multi_tag port_link gigabit_port \
		xfrm-offload tpm reset_button

	HARDWARE/Mobile/Module := 4G LTE Cat 6 up to 300 DL/ 50 UL Mbps; 3G up to 42 DL/ 5.76 UL Mbps
	HARDWARE/Mobile/3GPP_Release := Release 12
	HARDWARE/Bluetooth/Bluetooth_4.0 := $(HW_BT_LE)
	HARDWARE/Power/Input_voltage_range := 9 - 50 VDC, reverse polarity protection, voltage surge/transient protection; 24 - 36 VDC for railway version of the code RUTX11 020G00
	HARDWARE/Power/Power_consumption := 16 W Max
	HARDWARE/Physical_Interfaces/Status_leds := 4 x WAN type LEDs, 2 x Mobile connection type, 5 x Mobile connection strength, 8 x LAN status, 1 x Power, 2 x 2.4G and 5G Wi-Fi
	HARDWARE/Physical_Interfaces/SIM := 2 $(HW_INTERFACE_SIM_HOLDERS)
	HARDWARE/Physical_Interfaces/Antennas := 2 x SMA for Mobile, 2 x RP-SMA for Wi-Fi, 1 x RP-SMA for Bluetooth, 1 x SMA for GNSS
	HARDWARE/Physical_Specification/Weight := 456 g
	HARDWARE/Physical_Specification/Dimensions := 115 x 44.2 x 95.1 mm

	DEVICE_CHECK_PATH := bt_check /sys/bus/usb/drivers/usb/1-1.4/ reboot 13.0-
endef
TARGET_DEVICES += TEMPLATE_teltonika_rutx11

define Device/TEMPLATE_teltonika_rutx12
	$(Device/teltonika_rutx_common)
	$(Device/template_rutx_common)
	DEVICE_MODEL := RUTX12
	DEVICE_INITIAL_FIRMWARE_SUPPORT := 2.3.1
	DEVICE_USB_JACK_PATH := /usb1/1-1/1-1.3/
	DEVICE_SWITCH_CONF := "switch0" \
		"0u@eth0" "1:lan" "2:lan" "3:lan" "4:lan" "0u@eth1" "5:wan"
	DEVICE_FEATURES := usb gps mobile wifi dual_band_ssid bluetooth ethernet \
		ios dual_modem nat_offloading multi_tag port_link gigabit_port \
		xfrm-offload tpm reset_button

	HARDWARE/Mobile/Module := 2 x 4G LTE Cat 6 up to 300 DL/50 UL Mbps; 3G up to 42 DL/ 5.76 UL Mbps
	HARDWARE/Mobile/3GPP_Release := Release 12
	HARDWARE/Bluetooth/Bluetooth_4.0 := $(HW_BT_LE)
	HARDWARE/LAN/Port := 4 $(HW_ETH_LAN_PORTS)
	HARDWARE/Power/Power_consumption := Idle < 4 W, Max < 22 W
	HARDWARE/Physical_Interfaces/Ethernet := 5 $(HW_ETH_RJ45_PORTS), $(HW_ETH_SPEED_1000)
	HARDWARE/Physical_Interfaces/Status_leds := 4 x connection status LEDs, 6 x connection strength LEDs, 10 x Ethernet port status LEDs, 4 x WAN status LEDs, 1 x Power LED, 2 x 2.4G and 5G Wi-Fi LEDs
	HARDWARE/Physical_Interfaces/SIM := 2 $(HW_INTERFACE_SIM_HOLDERS)
	HARDWARE/Physical_Interfaces/Antennas := 4 x SMA for LTE, 2 x RP-SMA for WiFi, 1 x RP-SMA for Bluetooth, 1 x SMA for GNNS
	HARDWARE/Physical_Specification/Weight := 540 g
	HARDWARE/Physical_Specification/Dimensions := 132 x 44.2 x 95.1 mm

	DEVICE_CHECK_PATH := bt_check /sys/bus/usb/drivers/usb/1-1.4/ reboot 7.0-
endef
TARGET_DEVICES += TEMPLATE_teltonika_rutx12

define Device/TEMPLATE_teltonika_rutx14
	$(Device/teltonika_rutx_common)
	$(Device/template_rutx_common)
	DEVICE_MODEL := RUTX14
	DEVICE_INITIAL_FIRMWARE_SUPPORT := 2.6.1
	DEVICE_USB_JACK_PATH := /usb3/3-1/
	DEVICE_SWITCH_CONF := "switch0" \
		"0u@eth0" "1:lan" "2:lan" "3:lan" "4:lan" "0u@eth1" "5:wan"
	DEVICE_FEATURES := usb gps dual_sim mobile wifi dual_band_ssid bluetooth \
		ethernet ios at_sim nat_offloading multi_tag port_link gigabit_port \
		xfrm-offload tpm reset_button

	HARDWARE/Mobile/Module := 4G LTE Cat 12 up to 600 DL/150 UL Mbps; 3G to to 42 DL/ 11.2 UL Mbps
	HARDWARE/Mobile/3GPP_Release := Release 12
	HARDWARE/Bluetooth/Bluetooth_4.0 := $(HW_BT_LE)
	HARDWARE/LAN/Port := 4 $(HW_ETH_LAN_PORTS)
	HARDWARE/Power/Power_consumption := Idle < 4 W, Max < 22 W
	HARDWARE/Physical_Interfaces/Ethernet := 5 $(HW_ETH_RJ45_PORTS), $(HW_ETH_SPEED_1000)
	HARDWARE/Physical_Interfaces/Status_leds := 2 x connection status LEDs, 3 x connection strength LEDs, 10 x Ethernet port status LEDs, 4 x WAN status LEDs, 1 x Power LED, 2 x 2.4G and 5G Wi-Fi LEDs
	HARDWARE/Physical_Interfaces/SIM := 2 $(HW_INTERFACE_SIM_HOLDERS)
	HARDWARE/Physical_Interfaces/Antennas := 4 x SMA for LTE, 2 x RP-SMA for WiFi, 1 x RP-SMA for Bluetooth, 1 x SMA for GNNS
	HARDWARE/Physical_Specification/Weight := 515 g
	HARDWARE/Physical_Specification/Dimensions := 132 x 44 x 95 mm
endef
TARGET_DEVICES += TEMPLATE_teltonika_rutx14

define Device/TEMPLATE_teltonika_rutx50
	$(Device/teltonika_rutx_common)
	$(Device/template_rutx_common)
	DEVICE_MODEL := RUTX50
	DEVICE_INITIAL_FIRMWARE_SUPPORT := 7.2.8
	DEVICE_USB_JACK_PATH := /usb3/3-1/
	DEVICE_SWITCH_CONF := "switch0" \
		"0u@eth0" "1:lan" "2:lan" "3:lan" "4:lan" "0u@eth1" "5:wan"
	DEVICE_FEATURES := dual_sim usb gps mobile wifi dual_band_ssid ethernet ios \
		at_sim nat_offloading multi_tag port_link gigabit_port xfrm-offload \
		tpm reset_button

	HARDWARE/Mobile/Module := 5G Sub-6Ghz SA/NSA 2.1/3.3Gbps DL (4x4 MIMO), 900/600 Mbps UL (2x2); 4G LTE Cat 20 up to 2.0 Gbps DL/ 200M Mbps UL; 3G up to 42 DL/ 5.76 UL Mbps
	HARDWARE/Mobile/3GPP_Release := Release 15/16 depending on the hardware version
	HARDWARE/System_Characteristics/RAM := $(HW_RAM_SIZE_256M) (100 MB available for userspace)
	HARDWARE/System_Characteristics/Flash_Storage := $(HW_FLASH_SIZE_256M) (80 MB available for userspace)
	HARDWARE/LAN/Port := 4 $(HW_ETH_LAN_PORTS)
	HARDWARE/Power/Power_consumption := Idle < 4 W, Max < 18 W
	HARDWARE/Power/Input_voltage_range := $(HW_POWER_VOLTAGE_4PIN_50V)
	HARDWARE/Physical_Interfaces/Ethernet := 5 $(HW_ETH_RJ45_PORTS), $(HW_ETH_SPEED_1000)
	HARDWARE/Physical_Interfaces/Status_leds := 3 x connection status LEDs, 3 x connection strength LEDs, 10 x Ethernet port status LEDs, 4 x WAN status LEDs, 1 x Power LED, 2 x 2.4G and 5G Wi-Fi LEDs
	HARDWARE/Physical_Interfaces/SIM := 2 $(HW_INTERFACE_SIM_HOLDERS)
	HARDWARE/Physical_Interfaces/Antennas := 4 x SMA for Mobile, 2 x RP-SMA for Wi-Fi, 1 x SMA for GNNS
	HARDWARE/Physical_Specification/Weight := 533 g
	HARDWARE/Physical_Specification/Dimensions := 132 x 44.2 x 95.1 mm
endef
TARGET_DEVICES += TEMPLATE_teltonika_rutx50

define Device/TEMPLATE_teltonika_rutxr1
	$(Device/teltonika_rutx_common)
	$(Device/template_rutx_common)
	DEVICE_MODEL := RUTXR1
	DEVICE_SWITCH_CONF := "switch0" \
		"0u@eth0" "1:lan" "2:lan" "3:lan" "4:lan" "0u@eth1" "5:wan\#s"
	DEVICE_FEATURES := dual_sim usb mobile wifi dual_band_ssid ethernet sfp_port \
		sfp_switch console nat_offloading multi_tag port_link gigabit_port \
		xfrm-offload tpm reset_button

	DEVICE_USB_JACK_PATH := /usb1/1-1/1-1.2/
	DEVICE_INITIAL_FIRMWARE_SUPPORT := 2.3.1
	DEVICE_SERIAL_CAPABILITIES := \
			"rsconsole"                                             \
			"300 600 1200 2400 4800 9600 19200 38400 57600 115200"  \
			"7 8"                                                   \
			"rts/cts xon/xoff none"                                 \
			"1 2"                                                   \
			"even odd mark space none"                              \
			"none"                                                  \
			"/usb1/1-1/1-1.3/"

	HARDWARE/Mobile/Module := 4G LTE Cat 6 up to 300 DL/ 50 UL Mbps; 3G up to 42 DL/ 5.76 UL Mbps
	HARDWARE/Mobile/3GPP_Release := Release 11
	HARDWARE/LAN/Port := 4 $(HW_ETH_LAN_PORTS)
	HARDWARE/Fibre/Port := 1 $(HW_ETH_SFP_PORT) (cannot work simultaneously with Ethernet WAN port)
	HARDWARE/Input_Output/Input :=
	HARDWARE/Input_Output/Output :=
	HARDWARE/Power/Connector := 2 x 4-pin industrial DC power sockets for main and redundancy power source
	HARDWARE/Power/Power_consumption := Idle < 3 W, Max < 18 W
	HARDWARE/Power/PoE_Standards :=
	HARDWARE/Physical_Interfaces/IO :=
	HARDWARE/Physical_Interfaces/Ethernet := 5 $(HW_ETH_RJ45_PORTS), $(HW_ETH_SPEED_1000)
	HARDWARE/Physical_Interfaces/Status_leds := 2 x WAN type, 2 x Mobile connection type, 3 x Mobile signal strength, 2 x active SIM, 10 x Ethernet status, 2 x Console status, 2 x Power
	HARDWARE/Physical_Interfaces/SIM := 2 $(HW_INTERFACE_SIM_HOLDERS)
	HARDWARE/Physical_Interfaces/Antennas := 2 x SMA for LTE, 2 x RP-SMA for Wi-Fi
	HARDWARE/Physical_Interfaces/Power := 2 x 4-pin DC connector
	HARDWARE/Physical_Interfaces/Fibre := 1 $(HW_ETH_SFP_PORT)
	HARDWARE/Physical_Specification/Weight := 1093 g
	HARDWARE/Physical_Specification/Dimensions := 272 x 42.6 x 122.6 mm
	HARDWARE/Physical_Specification/Casing_material := $(HW_PHYSICAL_HOUSING_STEEL)
	HARDWARE/Physical_Specification/Mounting_options := $(HW_PHYSICAL_MOUNTING_RACK)
	HARDWARE/Operating_Environment/Ingress_Protection_Rating :=
endef
TARGET_DEVICES += TEMPLATE_teltonika_rutxr1
