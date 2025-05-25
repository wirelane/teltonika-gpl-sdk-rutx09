#!/bin/sh

. /lib/functions.sh

[ "$(id -u)" -eq 0 ] &&
    printf "\n \
  ${CLR_YELLOW}╭─────────────────────────────────╮${CLR_RESET}\n \
  ${CLR_YELLOW}│${CLR_RESET}                                 ${CLR_YELLOW}│${CLR_RESET}\n \
  ${CLR_YELLOW}│${CLR_RESET}   ${CLR_RED}ROOT LOGIN WILL BE DISABLED${CLR_RESET}   ${CLR_YELLOW}│${CLR_RESET}\n \
  ${CLR_YELLOW}│${CLR_RESET}                                 ${CLR_YELLOW}│${CLR_RESET}\n \
  ${CLR_YELLOW}│${CLR_RESET}   ${CLR_CYAN}Please use:${CLR_RESET}                   ${CLR_YELLOW}│${CLR_RESET}\n \
  ${CLR_YELLOW}│${CLR_RESET}    - '${CLR_GREEN}admin${CLR_RESET}' user               ${CLR_YELLOW}│${CLR_RESET}\n \
  ${CLR_YELLOW}│${CLR_RESET}    - '${CLR_GREEN}doas${CLR_RESET}' for admin tasks     ${CLR_YELLOW}│${CLR_RESET}\n \
  ${CLR_YELLOW}│${CLR_RESET}                                 ${CLR_YELLOW}│${CLR_RESET}\n \
  ${CLR_YELLOW}╰─────────────────────────────────╯${CLR_RESET}\n\n"
