svcadm disable svc:/network/dns/client:default

svccfg -s dns/client
listcust
delcust
select dns/client:default
listcust
delcust
quit

svccfg -s dns/client
setprop config/domain = astring: prod.health.local
setprop config/search = astring: ("prod.health.local" "prod.hial.healthbc.org" "cdc.health.local" "mgmt.health.local")
setprop config/nameserver = net_address: (192.168.160.10 192.168.60.20)
quit

svccfg -s dns/client
select network/dns/client:default
refresh
quit

svcadm enable svc:/network/dns/client:default
svcs -av svc:/network/dns/client:default

more /etc/resolv.conf