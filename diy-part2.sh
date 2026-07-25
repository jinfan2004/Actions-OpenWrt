#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
###########################################################################
echo "============================================="
echo "           EEPROM 配置检测脚本（仅观测）"
echo "============================================="

## 1. 查找驱动内 MT7981_*EEPROM.bin 文件
EEPROM_FILES=$(find ./feeds/mtk/mtwifi -type f -name "MT7981_*EEPROM.bin")
if [ -n "$EEPROM_FILES" ]; then
    echo -e "\n✅ 找到驱动内置EEPROM文件："
    echo "$EEPROM_FILES"
else
    echo -e "\n⚠️ 未在 feeds/mtk/mtwifi 找到 MT7981_*EEPROM.bin"
fi

## 2. 查找包含 EEPROM_FROM_FILE 宏的头文件
HEADER=$(find ./feeds/mtk/mtwifi -type f -name "*.h" | xargs grep -l "EEPROM_FROM_FILE" 2>/dev/null | head -n1)

if [ -n "$HEADER" ]; then
    echo -e "\n✅ 找到宏定义头文件：$HEADER"
    echo "当前宏定义内容："
    grep "EEPROM_FROM_FILE" "$HEADER"
else
    echo -e "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "⚠️ WARNING: 源码中未检索到 EEPROM_FROM_FILE 宏！"
    echo "文件优先加载EEPROM的补丁无法使用！"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
fi

echo -e "\n============================================="
echo "检测完成，脚本仅打印信息，未修改任何文件"
echo "============================================="
