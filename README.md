# Actions-OpenWrt  
🚀 本仓库永久每天会编译出最新固件。跟踪上游源码变化，自动编译。</br>
   ➦openwrt主源码来自https://github.com/coolsnowwolf/lede</br>
   ➦packages源码来自https://github.com/coolsnowwolf/packages</br>
   ➦luci源码来自 https://github.com/coolsnowwolf/luci</br>
   ➦helloworld源码来自 https://github.com/fw876/helloworld</br>
   ➦passwall源码来自 https://github.com/xiaorouji/openwrt-passwall</br>
   ➦ddns源码来自 https://github.com/sirpdboy/luci-app-ddns-go</br> 
   ➦ddns源码来自 https://github.com/jeessy2/ddns-go</br> 
   ➦smartdns源码来自 https://github.com/pymumu/smartdns</br>
   ➦lucky源码来自 https://github.com/gdy666/luci-app-lucky</br>



首次编译：
```bash
git clone https://github.com/coolsnowwolf/lede
cd lede
./scripts/feeds update -a  && ./scripts/feeds install -a
make menuconfig
make download -j8
make V=s -j1
```

二次编译：
```bash
cd lede 
git pull  && ./scripts/feeds update -a  && ./scripts/feeds install -a 
make defconfig && make download -j8
make V=s -j$(nproc)
```
重新配置：
```bash
rm -rf ./tmp && rm -rf .config
make menuconfig
make V=s -j$(nproc)
```

## 使用方法

前面的自动编译以及个性化定制等修改，全部来源于P3TER大神的[代码](https://github.com/P3TERX/Actions-OpenWrt)及[教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)。</br>
这里只说发布release的方法，部分代码借鉴或使用[id77](https://github.com/id77/OpenWrt-K2P-firmware)和[ncipollo](https://github.com/ncipollo/release-action)两位大神：</br>
 1、自动编译及自动发布你也可以使用本仓库模板，请点击上面的Use this template(使用此模板）来创建你自己的新仓库。</br>
 2、点击右上角你的头像-settings-Developer settings-Personal access tokens生成新的令牌，选中public_repo，随便起名保存，同时复制令牌内容。</br>
 3、回到刚建的新仓库，settings-Secrets-Add a new secret(添加密匙），取名RELEASES_TOKEN,把刚才复制的令牌粘贴进去保存。</br>
 4、定时编译的时间、触发自动编译的方法修改都在上面P3TERX大佬的教程里有说明。 </br>
 5、最关键一步，因为我在里面加入了开始编译和编译成功的微信消息提醒，所以除以上步骤外，还要把serverchan（微信推送）</br>
 的令牌保存到secret里，取名ServerChan.和前面第三步的添加密匙方法一致，否则差了这一步，刚开始编译就因为微信推送</br>
 找不到令牌而宣告失败。或者取消微信推送，注释掉yml文件中开始编译和编译结束的代码（共四行代码）即可。</br>
 
## 致谢

- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt)   
- [id77](https://github.com/id77/OpenWrt-K2P-firmware)
- [Microsoft](https://www.microsoft.com)
- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub](https://github.com)
- [GitHub Actions](https://github.com/features/actions)
- [tmate](https://github.com/tmate-io/tmate)
- [mxschmitt/action-tmate](https://github.com/mxschmitt/action-tmate)
- [csexton/debugger-action](https://github.com/csexton/debugger-action)
- [Cisco](https://www.cisco.com/)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [ncipollo](https://github.com/ncipollo/release-action)

