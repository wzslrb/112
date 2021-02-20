#!/bin/bash

#/home/runner/work/112/112/openwrt
pwd
sed -i '/^exit 0/i /bin/bash /root/zzz-default-settings.sh' package/lean/default-settings/files/zzz-default-settings
echo -e "插入初始化脚本99-default-settings:\c"
grep "zzz-default-settings.sh" package/lean/default-settings/files/zzz-default-settings

echo "修改固件大小 TRX_MAX_LEN"
ls -l tools/firmware-utils/src/trx.c
grep "#define TRX_MAX_LEN" tools/firmware-utils/src/trx.c
sed -i '/^#define TRX_MAX_LEN.*/s/0x.*/0xfc0000/g' tools/firmware-utils/src/trx.c
sed -n '/^#define TRX_MAX_LEN.*/p' tools/firmware-utils/src/trx.c

echo "修改.config"
ls -al .config
#修改固件大小
sed -i "/.*PER_DEVICE_ROOTFS.*/a CONFIG_TARGET_KERNEL_PARTSIZE=200\nCONFIG_TARGET_ROOTFS_PARTSIZE=600" .config
#删除除b70之外的设备
sed -i -e '/CONFIG_TARGET_DEVICE/ { /5962/b' -e 'N; d; }' .config

#<<'COMMENT'
grep -q "^[^#].*apfree-wifidog.*=" .config || sed -i '$a CONFIG_PACKAGE_apfree-wifidog=y' .config && echo "add apfree-wifidog"
#grep -q "^[^#].*luci-app-frpc.*=" .config || sed -i '$a CONFIG_PACKAGE_luci-app-frpc=y' .config
grep -q "^[^#].*_tree.*=" .config || sed -i '$a CONFIG_PACKAGE_tree=y' .config
grep -q "^[^#].*_git-http.*=" .config || sed -i '$a CONFIG_PACKAGE_git-http=y' .config
grep -q "^[^#].*_curl.*=" .config || sed -i '$a CONFIG_PACKAGE_curl=y' .config
grep -q "^[^#].*_wget-nossl.*=" .config || sed -i '$a CONFIG_PACKAGE_wget-nossl=y' .config
grep -q "^[^#].*openssh-client.*=" .config || sed -i '$a CONFIG_PACKAGE_openssh-client=y' .config

sed -i "/.*automount.*=m/s/=m/=y/g" .config
sed -i "/.*autosamba.*=m/s/=m/=y/g" .config
sed -i "/.*filetransfer.*=m/s/=m/=y/g" .config
sed -i "/.*fileassistant.*=m/s/=m/=y/g" .config

# 防火墙
sed -i "/.*iptables-mod-filter=m/s/=m/=y/g" .config
sed -i "/.*iptables-mod-trace=m/s/=m/=y/g" .config
sed -i "/.*iptables-mod-tarpit=m/s/=m/=y/g" .config
sed -i "/.*iptables-mod-iprange=m/s/=m/=y/g" .config
sed -i "/.*iptables-mod-extra=m/s/=m/=y/g" .config
sed -i "/.*iptables-mod-nat-extra=m/s/=m/=y/g" .config
sed -i "/.*iptables-mod-length2=m/s/=m/=y/g" .config

## SQM
sed -i "/.*sqm.*=m/s/=m/=y/g" .config
#sed -i "/.*frpc.*=m/s/=m/=y/g" .config
sed -i "/.*aria2.*=m/s/=m/=y/g" .config
#sed -i "/.*ariang.*=m/s/=m/=y/g" .config
#sed -i "/.*webui-aria2.*=m/s/=m/=y/g" .config
#grep -q "^[^#].*webui-aria2.*=" .config || sed -i '$a CONFIG_PACKAGE_webui-aria2=y' .config
sed -i "/.*vsftpd.*=m/s/=m/=y/g" .config

#带宽、流量监测
sed -i "/.*nlbwmon.*=m/s/=m/=y/g" .config
#sed -i "/.*wrtbwmon.*=m/s/=m/=y/g" .config
#穿透
sed -i "/.*zerotier=m/s/=m/=y/g" .config

sed -i "/.*-sfe.*=m/s/=m/=y/g" .config
#ADG广告过滤
sed -i "/.*luci-app-adguardhome.*=m/s/=m/=y/g" .config
# 广告过滤
sed -i "/.*adbyby.*=m/s/=m/=y/g" .config
# 代理 luci-app-privoxy
sed -i "/.*privoxy.*=m/s/=m/=y/g" .config
sed -i "/.*tinyproxy.*=m/s/=m/=y/g" .config

# EQOS
sed -i '$a\CONFIG_PACKAGE_luci-app-eqos=y' .config
sed -i '$a\CONFIG_PACKAGE_luci-i18n-eqos-zh_Hans=y' .config
# 网址过滤
sed -i "/.*control-weburl.*=m/s/=m/=y/g" .config
#访问限制
sed -i "/.*webrestriction.*=m/s/=m/=y/g" .config
# DDNS
sed -i "/.*ddns.*=m/s/=m/=y/g" .config
# 科学上网
sed -i "/.*openclash.*=m/s/=m/=y/g" .config
sed -i "/.*ssr-plus.*=m/s/=m/=y/g" .config
#luci-app-ssr-plus
#sed -i "/.*luci-app-ssr-plus.*=m/s/=m/=y/g" .config
#sed -i "/luci-app-ssr-plus=y/a CONFIG_PACKAGE_luci-i18n-ssr-plus-zh-cn=y" .config
# 命令行工具
sed -i "/.*curl.*=m/s/=m/=y/g" .config
sed -i "/.*wget.*=m/s/=m/=y/g" .config
sed -i "/.*wget-nossl.*=m/s/=m/=y/g" .config
sed -i "/.*tree.*=m/s/=m/=y/g" .config
sed -i "/.*lscpu.*=m/s/=m/=y/g" .config
sed -i "/.*lsof.*=m/s/=m/=y/g" .config
sed -i "/.*lrzsz.*=m/s/=m/=y/g" .config
sed -i "/.*bash.*=m/s/=m/=y/g" .config
grep -q "^[^#].*_rename=" .config || sed -i '$a CONFIG_PACKAGE_rename=y' .config
sed -i '$a CONFIG_PACKAGE_diffutils=y' .config
sed -i '$a CONFIG_PACKAGE_patch=y' .config
sed -i '$a\CONFIG_PACKAGE_sshpass=y' .config	#SSH免密码
sed -i '$a\CONFIG_PACKAGE_netperf=y' .config	#网络测速
sed -i '$a\CONFIG_PACKAGE_speedtest-netperf=y' .config	#网络测速脚本
sed -i '$a\CONFIG_PACKAGE_speedtest-cli=y' .config	#C语言测速
sed -i '$a\CONFIG_PACKAGE_coreutils=y' .config
sed -i '$a\CONFIG_PACKAGE_coreutils-nohup=y' .config	#nohup后台允许
sed -i '$a\CONFIG_PACKAGE_screen=y' .config

#互动的进程查看器
sed -i '$a\CONFIG_PACKAGE_htop=y' .config
#iw
sed -i '$a\CONFIG_PACKAGE_iw=y' .config
sed -i '$a\CONFIG_PACKAGE_iwinfo=y' .config
# 主题
sed -i "/.*luci-theme-opentomato.*=m/s/=m/=y/g" .config
sed -i "/.*luci-theme-atmaterial.*=m/s/=m/=y/g" .config
sed -i "/.*luci-theme-netgear.*=m/s/=m/=y/g" .config

#新近更新=y 去除https-dns-proxy默认安装
sed -i "/^CONFIG.*dns-proxy.*/{s/^/# &/g; s/=.*/ is not set/g}" .config && echo "去除https-dns-proxy默认安装"
#防火墙upnpd
sed -i "/CONFIG_MINIUPNPD_IGDv2/s/\(.*\)=.*/# \1 is not set/g" .config && echo "防火墙upnpd"

echo "其他的全部不打包"
sed -i "/^CONFIG.*=m/s/\(.*\)=.*/# \1 is not set/g" .config
sed -i "/^CONFIG.*_INCLUDE_.*=.*/s/\(.*\)=.*/# \1 is not set/g" .config

#Error closing /dev/crypto: Bad file descriptor
sed -i '$a\# CONFIG_OPENSSL_ENGINE_BUILTIN_DEVCRYPTO is not set' .config
dump222(){			#定义函数多行注释
CONFIG_PACKAGE_kmod-crypto-aead=y
CONFIG_PACKAGE_kmod-crypto-arc4=y
CONFIG_PACKAGE_kmod-crypto-authenc=y
CONFIG_PACKAGE_kmod-crypto-crc32c=y
CONFIG_PACKAGE_kmod-crypto-ecb=y
CONFIG_PACKAGE_kmod-crypto-hash=y
CONFIG_PACKAGE_kmod-crypto-manager=y
CONFIG_PACKAGE_kmod-crypto-null=y
CONFIG_PACKAGE_kmod-crypto-pcompress=y
CONFIG_PACKAGE_kmod-crypto-sha1=y
CONFIG_PACKAGE_kmod-crypto-user=y
CONFIG_PACKAGE_kmod-cryptodev=y
}
#方法二
#sed -i "/^CONFIG.*=m/{s/^/# &/g;s/=.*/ is not set/g;}" .config
#sed -i "/^CONFIG.*_INCLUDE_.*=.*/{s/^/# &/g;s/=.*/ is not set/g;q}" .config 
#COMMENT
#echo "查看成果……cat .config"
#cat .config
cat .config > ../other/diy的config.txt
env | tee ../other/env环境变量.txt >/dev/null 2>&1

