#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt

# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# 文件名：diy-part1.sh
# 描述：OpenWrt DIY脚本第一部分（更新feeds之前）

# 例如：
# Uncomment a feed source / 取消注释一个软件包源
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source / 添加自定义软件包源到feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# 避免重复追加，确保末尾换行并移除 CRLF
FEEDS_FILE="feeds.conf.default"

# 如果没有在当前目录找到 feeds.conf.default，尝试使用 openwrt 自带的（通常脚本在 openwrt 目录下运行）
[ -f "$FEEDS_FILE" ] || FEEDS_FILE="feeds.conf.default"

# 要增加的源（以 .git 结尾更保险）
LINE="src-git luci-app-harbor-file https://github.com/destan19/luci-app-harbor-file.git"

# 只在不存在时追加
if ! grep -Fxq "$LINE" "$FEEDS_FILE" 2>/dev/null; then
  printf '%s\n' "$LINE" >>"$FEEDS_FILE"
fi

# 去掉可能的 CR 字符，确保 Unix 格式
if command -v sed >/dev/null 2>&1; then
  sed -i 's/\r$//' "$FEEDS_FILE" || true
fi

