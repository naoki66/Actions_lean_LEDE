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
#git clone https://github.com/xiaorouji/openwrt-passwall.git -b luci ./package/applications/passwall
git clone https://github.com/xiaorouji/openwrt-passwall.git -b luci-smartdns-new-version ./package/applications/passwall
cp -rf ./package/applications/passwall_package/* ./package/applications/passwall
rm -rf ./package/applications/passwall_package
#mkdir -p ./package/applications/passwall
#cp -rf ./feeds/passwall_luci/* ./package/applications/passwall
#cp -rf ./feeds/passwall_packages/* ./package/applications/passwall


#升级smartdns版本到最新commits
#sed -i 's/1.2023.41/'"$(date +"%Y%m%d")"'/g' feeds/packages/net/smartdns/Makefile
#sed -i '/PKG_SOURCE_VERSION:=/d' feeds/packages/net/smartdns/Makefile
#sed -i "/smartdns.git/a\PKG_SOURCE_VERSION:=$(curl -s https://api.github.com/repos/pymumu/smartdns/commits | grep '"sha"' | head -1 | cut -d '"' -f 4)" feeds/packages/net/smartdns/Makefile
#sed -i 's/^PKG_MIRROR_HASH/#&/' feeds/packages/net/smartdns/Makefile
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/applications/luci-app-smartdns
git clone --depth 1 https://github.com/pymumu/smartdns package/applications/smartdns
mkdir -p ./package/applications/smartdns_luci
mkdir -p ./package/applications/smartdns
cp -rf ./feeds/smartdns_luci/* ./package/applications/smartdns_luci
cp -rf ./feeds/smartdns/* ./package/applications/smartdns

#添加luci-app-mosdns
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#干掉跑分程序
sed -i 's, <%=luci.sys.exec("cat /etc/bench.log") or " "%><,<,g'  package/lean/autocore/files/x86/index.htm
rm -rf ./feeds/packages/utils/coremark

##干掉wan6和ula_prefix
sed -i "/uci commit fstab/a\uci delete network.wan6\nuci delete network.globals.ula_prefix\nuci set dhcp.lan.start=\'50\'\nuci set network.lan.ip6assign=\'64\'\nuci set network.globals.packet_steering=0\nuci commit network" package/lean/default-settings/files/zzz-default-settings
