#!/bin/bash

pwd
echo "修改固件大小 TRX_MAX_LEN"
ls -l tools/firmware-utils/src/trx.c
grep "#define TRX_MAX_LEN" tools/firmware-utils/src/trx.c
sed -i '/^#define TRX_MAX_LEN.*/s/0x.*/0xfc0000/g' tools/firmware-utils/src/trx.c
sed -n '/^#define TRX_MAX_LEN.*/p' tools/firmware-utils/src/trx.c

echo "修改.config"
ls -al .config
#<<'COMMENT'
grep -q "^[^#].*apfree-wifidog.*=" || sed -i '$a CONFIG_PACKAGE_apfree-wifidog=y' .config
grep -q "^[^#].*luci-app-frpc.*=" || sed -i '$a CONFIG_PACKAGE_luci-app-frpc=y' .config
grep -q "^[^#].*_tree.*=" || sed -i '$a CONFIG_PACKAGE_tree=y' .config
grep -q "^[^#].*_git-http.*=" || sed -i '$a CONFIG_PACKAGE_git-http=y' .config
grep -q "^[^#].*_curl.*=" || sed -i '$a CONFIG_PACKAGE_curl=y' .config
grep -q "^[^#].*_wget-nossl.*=" || sed -i '$a CONFIG_PACKAGE_wget-nossl=y' .config
grep -q "^[^#].*openssh-client.*=" || sed -i '$a CONFIG_PACKAGE_openssh-client=y' .config

sed -i "/.*automount.*=m/s/=m/=y/g" .config
sed -i "/.*autosamba.*=m/s/=m/=y/g" .config
sed -i "/.*filetransfer.*=m/s/=m/=y/g" .config
sed -i "/.*fileassistant.*=m/s/=m/=y/g" .config

## SQM
sed -i "/.*sqm.*=m/s/=m/=y/g" .config
sed -i "/.*frpc.*=m/s/=m/=y/g" .config
sed -i "/.*aria2.*=m/s/=m/=y/g" .config
sed -i "/.*ariang.*=m/s/=m/=y/g" .config
sed -i "/.*vsftpd.*=m/s/=m/=y/g" .config

#实时流量监测
sed -i "/.*nlbwmon.*=m/s/=m/=y/g" .config
sed -i "/.*wrtbwmon.*=m/s/=m/=y/g" .config

sed -i "/.*-sfe.*=m/s/=m/=y/g" .config
#ADG广告过滤
#sed -i "/.*luci-app-adguardhome.*=m/s/=m/=y/g" .config

# 命令行工具
sed -i "/.*curl.*=m/s/=m/=y/g" .config
sed -i "/.*wget.*=m/s/=m/=y/g" .config
sed -i "/.*wget-nossl.*=m/s/=m/=y/g" .config
sed -i "/.*tree.*=m/s/=m/=y/g" .config

# 主题
sed -i "/.*luci-theme-freifunk-generic.*=m/s/=m/=y/g" .config
sed -i "/.*luci-theme-material.*=m/s/=m/=y/g" .config
sed -i "/.*luci-theme-netgear.*=m/s/=m/=y/g" .config
echo "其他的全部不打包"
sed -i "/^CONFIG.*=m/s/\(.*\)=.*/# \1 is not set/g" .config
sed -i "/^CONFIG.*_INCLUDE_.*=.*/s/\(.*\)=.*/# \1 is not set/g" .config
#方法二
#sed -i "/^CONFIG.*=m/{s/^/# &/g;s/=.*/ is not set/g;q}" .config
#sed -i "/^CONFIG.*_INCLUDE_.*=.*/{s/^/# &/g;s/=.*/ is not set/g;q}" .config 
#COMMENT
