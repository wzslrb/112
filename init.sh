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
rm -rf Action-Openwrt xf_b70
echo "查看当前目录"
ls -al
echo "查看补丁目录"
ls -al ./user/lean-mt7621/files/

cd ./user/lean-mt7621/
# 在这里指定你的OpenWrt的Repo URL
#REPO_URL="https://github.com/coolsnowwolf/lede"
# 在这里指定你的OpenWrt的Branch
#REPO_BRANCH="master"
#上传 Packages 目录
sed -i  's/UPLOAD_PACKAGES_DIR.*/UPLOAD_PACKAGES_DIR="false"/g' settings.ini
#上传 Targets 目录
sed -i  's/UPLOAD_TARGETS_DIR.*/UPLOAD_TARGETS_DIR="false"/g' settings.ini
#上传固件
sed -i  's/UPLOAD_FIRMWARE.*/UPLOAD_FIRMWARE="true"/g' settings.ini
# 上传到 Artifacts
sed -i  's/UPLOAD_TO_ARTIFACTS.*/UPLOAD_TO_ARTIFACTS="true"/g' settings.ini
# 发布 Realease
sed -i  's/UPLOAD_TO_REALEASE.*/UPLOAD_TO_REALEASE="true"/g' settings.ini
# 上传到 奶牛快传
sed -i  's/UPLOAD_TO_COWTRANSFER.*/UPLOAD_TO_COWTRANSFER="true"/g' settings.ini
# 微信通知
sed -i  's/WECHAT_NOTIFICATION.*/WECHAT_NOTIFICATION="false"/g' settings.ini
cat settings.ini
exit 0
