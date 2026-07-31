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
# 文件名：diy-part2.sh
# 描述：OpenWrt DIY脚本第二部分（更新feeds之后）

# 设置默认的 Lan 口 IP地址
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# 修改默认的主题
sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci/Makefile

# ---------- 集成 destan19/luci-app-harbor-file 开始 ----------
# 将 luci-app-harbor-file 克隆到 package/community（如果还没存在）
if [ ! -d "package/community/luci-app-harbor-file" ]; then
  mkdir -p package/community
  git clone --depth=1 https://github.com/destan19/luci-app-harbor-file.git package/community/luci-app-harbor-file
fi

# （可选）如果希望在默认配置中自动启用包，向 .config 添加配置项
# 注意：workflow 在运行本脚本前会把仓库根的 .config 移动到 openwrt/.config，
# 因此这里修改的是 openwrt 下的 .config（当前工作目录为 openwrt）
if [ -f ".config" ]; then
  # 避免重复添加：先删除已有的相同行（如果存在），再追加
  sed -i '/CONFIG_PACKAGE_luci-app-harbor-file/d' .config || true
  echo 'CONFIG_PACKAGE_luci-app-harbor-file=y' >> .config
fi
# ---------- 集成 destan19/luci-app-harbor-file 结束 ----------
