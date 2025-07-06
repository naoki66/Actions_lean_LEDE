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
#sed -i 's/^.*mwan.htm.*/#&/' package/lean/default-settings/files/zzz-default-settings
#sed -i 's/^.*upnp.htm.*/#&/' package/lean/default-settings/files/zzz-default-settings
#sed -i 's/^.*ddns.htm.*/#&/' package/lean/default-settings/files/zzz-default-settings


# 日期
sed -i 's/os.date(/&"%Y-%m-%d %H:%M:%S"/' package/lean/autocore/files/x86/index.htm

# 把密码改成空
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

#干掉跑分程序
#sed -i 's, <%=luci.sys.exec("cat /etc/bench.log") or " "%><,<,g'  package/lean/autocore/files/x86/index.htm
#rm -rf ./feeds/packages/utils/coremark

# 删除WAN6接口配置
#sed -i "/uci commit fstab/a\uci delete network.wan6" package/lean/default-settings/files/zzz-default-settings

# 删除ULA前缀配置
sed -i "/uci commit fstab/a\uci delete network.globals.ula_prefix" package/lean/default-settings/files/zzz-default-settings

# 设置LAN和全局网络参数
sed -i "/uci commit fstab/a\nuci set dhcp.lan.start='50'" package/lean/default-settings/files/zzz-default-settings

# 设置IPv6分配长度
sed -i "/uci commit fstab/a\nuci set network.lan.ip6assign='64'" package/lean/default-settings/files/zzz-default-settings

# 设置IPv6后缀为eui64自动生成
sed -i "/uci set network.lan.ip6assign='64'/a\nuci set network.lan.ip6hint='eui64'" package/lean/default-settings/files/zzz-default-settings

# 设置RA flags为none
sed -i "/uci set network.lan.ip6hint='eui64'/a\nuci set network.lan.ra_flags='none'\nuci commit network" package/lean/default-settings/files/zzz-default-settings