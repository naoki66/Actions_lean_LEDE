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

# Modify default IP 修改默认IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate


#添加额外软件包
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/applications/luci-app-smartdns



#升级smartdns版本
sed -i 's/1.2021.35/1.2022.37.2/g' feeds/packages/net/smartdns/Makefile
sed -i 's/f50e4dd0813da9300580f7188e44ed72a27ae79c/64e5b326cc53df1fec680cfa28ceec5d8a36fcbc/g' feeds/packages/net/smartdns/Makefile
sed -i 's/^PKG_MIRROR_HASH/#&/' feeds/packages/net/smartdns/Makefile
