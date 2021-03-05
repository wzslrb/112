#!/bin/bash

#git clone https://github.com/fw876/helloworld.git                                   package/molun/luci-app-ssr-plus
#git clone https://github.com/rufengsuixing/luci-app-adguardhome.git                 package/molun/luci-app-adguardhome
#git clone https://github.com/vernesong/OpenClash.git                                package/molun/luci-app-openclash
pwd
echo "初始化xf_b70……"
git clone https://github.com/wzslrb/xf_b70.git 
echo "初始化hyird……"
git clone https://github.com/hyird/Action-Openwrt.git
echo "拷贝Action-Openwrt文件"
cd Action-Openwrt
echo "Action-Openwrt/user目录 删除多于目录"
find user -maxdepth 1 -type d -not -name "." -not -name "*common*" -not -name "*mt7621*" -not -name "user" -exec rm -rf {} \;
#cd user
#echo "测试个命令"
#find . -maxdepth 1 -type d -not -name "." -not -name "*common*" -not -name "*mt7621*" -exec rm -rf {} \;
#ls -al
#cd ..
mv user ..
mv version ..
echo "拷贝自定义文件"
cd ../xf_b70/
cp -rfp files ../user/lean-mt7621/

echo "删除临时文件"
cd ..
rm -rf Action-Openwrt xf_b70
#echo "查看当前目录"
#ls
#echo "查看补丁目录"
#ls ./user/lean-mt7621/files/

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
sed -i  's/UPLOAD_TO_REALEASE.*/UPLOAD_TO_REALEASE="false"/g' settings.ini
# 上传到 奶牛快传
sed -i  's/UPLOAD_TO_COWTRANSFER.*/UPLOAD_TO_COWTRANSFER="true"/g' settings.ini
# 微信通知
sed -i  's/WECHAT_NOTIFICATION.*/WECHAT_NOTIFICATION="false"/g' settings.ini
[ -f "settings.ini" ] && echo "重设settings.ini文件完毕"

echo "调整脚本内的svn co"
sed -i 's/^svn co.*/& | grep "Checked out"/g' custom.sh

echo "删除custom.sh内部分补丁"
sed -i 's/^git clone.*OpenAppFilter.*/# &/g' custom.sh
sed -i 's/^git clone.*smartdns.*/# &/g' custom.sh
#sed -i 's/^svn co.*/# &/g' custom.sh
sed -i 's/^svn co.*smartdns.*/# &/g' custom.sh

#eqos
echo git clone https://github.com/garypang13/luci-app-eqos.git package/eqos >> custom.sh
# adguardhome编译出错
# sed -i 's/.*adguardhome.*/# &/g' custom.sh
# echo git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/adg >> custom.sh
# koolproxyR广告过滤
# echo git clone https://github.com/jefferymvp/luci-app-koolproxyR.git package/luci-app-koolproxyR >> custom.sh
# C语言测速
# echo git clone https://github.com/feiying1460/speedtest-cli.git package/speedtest-cli >> custom.sh
#echo "调整custom.sh内opkg"
#sed -i 's/^sed.*http.*zzz-default.*/# &/g' custom.sh
#sed -i 's/^sed.*\/R20.*zzz-default.*/# &/g' custom.sh
#sed -i 's/openwrt.download/mirrors.bfsu.edu.cn/g' custom.sh
#echo "检查修改结果"
#cat custom.sh
cd patches
echo "删除patches部分补丁"
rm -f 000*
echo "删除完成"
ls -l
# 调试
# echo 查看修改结果
# cat custom.sh
# echo 查看修改结果sed
# sed '1,$=' custom.sh

# user\common\
echo "删除common/custom.sh不相关app"
cd ${GITHUB_WORKSPACE}/user/common
sed -i 's/.*serverchan.*/# &/g' custom.sh
#sed -i 's/.*OpenClash.*/# &/g' custom.sh
sed -i '/feed-netkeeper/s/ -b openwrt-18.06//' custom.sh #去除出错分支
sed -i '/^git clone/s/.*/& >\/dev\/null 2>\&1/g' custom.sh   #禁止输出
sed -i 's/.*adguardhome.*/# &/g' custom.sh

cp custom.sh ${GITHUB_WORKSPACE}/other/7621/common_custom.sh
#强迫症 删除无用文件
rm -f ${GITHUB_WORKSPACE}/user/common/files/common
rm -f ${GITHUB_WORKSPACE}/user/lean-mt7621/files/ipq40xx
echo "删除完成,备份关键文件"
cp -rfp ${GITHUB_WORKSPACE}/*.sh ${GITHUB_WORKSPACE}/other/
cp -rfp ${GITHUB_WORKSPACE}/user/lean-mt7621/*.* ${GITHUB_WORKSPACE}/other/7621/
cp -rfp ${GITHUB_WORKSPACE}/.github/workflows/*.yml ${GITHUB_WORKSPACE}/other/

#临时下载脚本
#cd ${GITHUB_WORKSPACE}/other/7621/
#wget -O speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py --no-check-certificate

#ls -l ${GITHUB_WORKSPACE}/other/
exit 0

#svn 下载 github 上的单个目录或文件
#https://github.com/Lienol/openwrt/tree/main/package/diy/luci-app-adguardhome 
#tree/main  tree/分支  换成 /trunk/，使用 svn 命令即检出:
# https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome  package/adg
# 主仓库就这样拉取，如果要拉取分支的呢？也简单的，把tree改成branches就行，比如
# https://github.com/281677160/openwrt-package/tree/19.07/luci-app-eqos   <--- 在浏览器上复制出来的真正链接

# https://github.com/281677160/openwrt-package/branches/19.07/luci-app-eqos   <--- 用的时候修改过的链接

# svn co https://github.com/281677160/openwrt-package/branches/19.07/luci-app-eqos package/luci-app-eqos  <--- 完整拉取链接

