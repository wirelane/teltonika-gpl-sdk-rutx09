#! /bin/sh
. /lib/functions.sh

add_limit_rules() {
	config_get limit "$1" "limit"
	config_get limit_burst "$1" "limit_burst"
	config_get name "$1" "name"

	[ -n "$limit" ] || return

	[ "$name" = "Allow-Ping" ] && {
		iptables -I INPUT -p icmp -m icmp --icmp-type 8 -m comment --comment "!fw3: Reject ICMP" -j REJECT
		iptables -I INPUT -p icmp -m icmp --icmp-type 8 -m limit --limit $limit --limit-burst $limit_burst -m comment --comment "!fw3: Limit ICMP" -j ACCEPT
	}
}

config_load firewall
config_foreach add_limit_rules rule