curl -s https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf | sed -e 's|^server=/\(.*\)/114.114.114.114$|\1|' | grep -Ev -e '^#' -e '^$' > china.txt
curl -s https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf | sed -e 's|^server=/\(.*\)/114.114.114.114$|\1|' | grep -Ev -e '^#' -e '^$' > google.txt
curl -s https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf | sed -e 's|^server=/\(.*\)/114.114.114.114$|\1|' | grep -Ev -e '^#' -e '^$' > apple.txt
sort -u china.txt apple.txt google.txt | sed -e 's/^/add forward-to=$dnsserver type=FWD address-list=CN_List match-subdomain=yes name=/g' -e '1i:global dnsserver 223.5.5.5\n/ip dns static\nremove [/ip dns static find address-list=CN_List]' -e '$a/ip dns cache flush' >CNDOMAIN.RSC
sort -u china.txt apple.txt google.txt | sed -e 's/^/[\//g' -e 's/$/\/]h3:\/\/223.5.5.5\/dns-query https:\/\/1.12.12.12\/dns-query/g' -e '1ih3:\/\/8.8.8.8\/dns-query\nh3:\/\/1.1.1.1\/dns-query'> ADGRULE.TXT
rm -rf *.txt