#!/bin/bash

#git clone https://github.com/fw876/helloworld.git                                   package/molun/luci-app-ssr-plus
#git clone https://github.com/rufengsuixing/luci-app-adguardhome.git                 package/molun/luci-app-adguardhome
#git clone https://github.com/vernesong/OpenClash.git                                package/molun/luci-app-openclash
pwd
echo "初始化xf_b70……"
git clone https://github.com/wzslrb/xf_b70.git 
echo "初始化hyird……"
git clone https://github.com/hyird/Action-Openwrt.git
ls -al
cd Action-Openwrt
mv user ..
mv version ..
cd ../xf_b70
mv -f files ../user/lean-mt7621/
cd ..
echo "查看当前目录"
ls -al
echo "查看补丁目录"
ls -al ./user/lean-mt7621/files/
rm -rf Action-Openwrt xf_b70

exit 0
