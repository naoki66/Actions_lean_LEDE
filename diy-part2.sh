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


#添加额外软件包
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/applications/luci-app-smartdns
git clone --depth 1 https://github.com/pymumu/smartdns package/applications/smartdns

#添加passwall
git clone https://github.com/xiaorouji/openwrt-passwall.git -b packages ./package/applications/passwall_package
git clone https://github.com/xiaorouji/openwrt-passwall.git -b luci ./package/applications/passwall
#git clone https://github.com/xiaorouji/openwrt-passwall.git -b luci-smartdns-new-version ./package/applications/passwall
cp -rf ./package/applications/passwall_package/* ./package/applications/passwall
rm -rf ./package/applications/passwall_package

#恢复主机型号
#sed -i 's/(dmesg | grep .*/{a}${b}${c}${d}${e}${f}/g' package/lean/autocore/files/x86/autocore
#sed -i '/h=${g}.*/d' package/lean/autocore/files/x86/autocore
#sed -i 's/echo $h/echo $g/g' package/lean/autocore/files/x86/autocore

# 添加新主题
#git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/applications/luci-app-argon-config
#if [ ! -d "./package/lean/luci-app-argon-config" ]; then git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/lean/luci-app-argon-config;   else cd ./package/lean/luci-app-argon-config; git stash; git stash drop; git pull; cd ..; cd ..; cd ..; fi;


#升级smartdns版本到最新2023
#sed -i 's/1.2023.41/2023.03.08/g' feeds/packages/net/smartdns/Makefile
sed -i 's/60a3719ec739be2cc1e11724ac049b09a75059cb/1ac2b2ad98bef602bc7f4631ae3f84cb448fa4ee/g' feeds/packages/net/smartdns/Makefile
sed -i 's/^PKG_MIRROR_HASH/#&/' feeds/packages/net/smartdns/Makefile


#修复mosdns到V4版本
sed -i 's/5.1.2/4.5.3/g' feeds/packages/net/mosdns/Makefile
sed -i 's/cc24a30f014fa563ca2065d198fcb0bdfe2949488f1944498f815a2a73969572/2a13b1b1d862731cf946a8ceaa99523a0eb0eaae56045dd31207b61a5a6d47ae/g' feeds/packages/net/mosdns/Makefile

