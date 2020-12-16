svccfg -s network/dns/client
> setprop config/search = astring: ("domain1" "domain2")
> setprop config/nameserver = net_address: (address1 address2)
> select network/dns/client:default
> refresh
> validate
> select name-service/switch
> setprop config/host = astring: "files dns"
> select system/name-service/switch:default
refresh
validate
quit
svcadm enable dns/client
svcadm enable name-service/switch