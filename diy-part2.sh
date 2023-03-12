#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改默认IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 恢复首页显示
sed -i 's/^.*mwan.htm.*/#&/' package/lean/default-settings/files/zzz-default-settings
sed -i 's/^.*upnp.htm.*/#&/' package/lean/default-settings/files/zzz-default-settings
sed -i 's/^.*ddns.htm.*/#&/' package/lean/default-settings/files/zzz-default-settings


# 日期
sed -i 's/os.date(/&"%Y-%m-%d %H:%M:%S"/' package/lean/autocore/files/x86/index.htm

# 把密码改成空
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings



#添加passwall
git clone https://github.com/xiaorouji/openwrt-passwall.git -b packages ./package/applications/passwall_package
git clone https://github.com/xiaorouji/openwrt-passwall.git -b luci ./package/applications/passwall
cp -rf ./package/applications/passwall_package/* ./package/applications/passwall
rm -rf ./package/applications/passwall_package
#mkdir -p ./package/applications/passwall
#cp -rf ./feeds/passwall_luci/* ./package/applications/passwall
#cp -rf ./feeds/passwall_packages/* ./package/applications/passwall

#恢复主机型号
#sed -i 's/(dmesg | grep .*/{a}${b}${c}${d}${e}${f}/g' package/lean/autocore/files/x86/autocore
#sed -i '/h=${g}.*/d' package/lean/autocore/files/x86/autocore
#sed -i 's/echo $h/echo $g/g' package/lean/autocore/files/x86/autocore

# 添加新主题
#git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/applications/luci-app-argon-config
#if [ ! -d "./package/lean/luci-app-argon-config" ]; then git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/lean/luci-app-argon-config;   else cd ./package/lean/luci-app-argon-config; git stash; git stash drop; git pull; cd ..; cd ..; cd ..; fi;


#升级smartdns版本到最新commits
sed -i 's/1.2023.41/'"$(date +"%Y%m%d")"'/g' feeds/packages/net/smartdns/Makefile
sed -i '/PKG_SOURCE_VERSION:=/d' feeds/packages/net/smartdns/Makefile
sed -i "/smartdns.git/a\PKG_SOURCE_VERSION:=$(curl -s https://api.github.com/repos/pymumu/smartdns/commits | grep '"sha"' | head -1 | cut -d '"' -f 4)" feeds/packages/net/smartdns/Makefile
#sed -i 's/60a3719ec739be2cc1e11724ac049b09a75059cb/60a3719ec739be2cc1e11724ac049b09a75059cb/g' feeds/packages/net/smartdns/Makefile
sed -i 's/^PKG_MIRROR_HASH/#&/' feeds/packages/net/smartdns/Makefile
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/applications/luci-app-smartdns
git clone --depth 1 https://github.com/pymumu/smartdns package/applications/smartdns
#mkdir -p ./package/applications/smartdns_luci
#mkdir -p ./package/applications/smartdns
#cp -rf ./feeds/smartdns_luci/* ./package/applications/smartdns_luci
#cp -rf ./feeds/smartdns/* ./package/applications/smartdns

#修复mosdns到V4版本
#sed -i 's/5.1.2/4.5.3/g' feeds/packages/net/mosdns/Makefile
#sed -i 's/cc24a30f014fa563ca2065d198fcb0bdfe2949488f1944498f815a2a73969572/2a13b1b1d862731cf946a8ceaa99523a0eb0eaae56045dd31207b61a5a6d47ae/g' feeds/packages/net/mosdns/Makefile

#修复luci-app-lucky引用
sed -i 's/^#LUCI_DEPENDS/LUCI_DEPENDS/g' feeds/lucky/luci-app-lucky/Makefile

#干掉跑分程序
sed -i 's, <%=luci.sys.exec("cat /etc/bench.log") or " "%><,<,g'  package/lean/autocore/files/x86/index.htm
rm -rf ./feeds/packages/utils/coremark

##干掉wan6和ula_prefix
sed -i "/uci commit fstab/a\uci delete network.wan6\nuci delete network.globals.ula_prefix\nuci set dhcp.lan.start=\'50\'\nuci set network.lan.ip6assign=\'64\'\nuci set network.globals.packet_steering=0\nuci commit network" package/lean/default-settings/files/zzz-default-settings

