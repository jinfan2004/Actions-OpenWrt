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

## 1. 在正确路径查找 MT7981_*EEPROM.bin
EEPROM_FILES=$(find ./package/mtk/drivers/mt_wifi -type f -name "MT7981_*EEPROM.bin")
if [ -n "$EEPROM_FILES" ]; then
    echo -e "\n✅ 找到驱动内置EEPROM文件："
    echo "$EEPROM_FILES"
else
    echo -e "\nℹ️ 未找到 MT7981_*EEPROM.bin"
fi

## 2. 全局搜索宏（不再限定feeds，在package/mtk范围搜索）
HEADER=$(find ./package/mtk -type f -name "*.h" | xargs grep -l "EEPROM_FROM_FILE" 2>/dev/null | head -n1)

if [ -n "$HEADER" ]; then
    echo -e "\n✅ 找到宏定义头文件：$HEADER"
    echo "当前宏定义内容："
    grep "EEPROM_FROM_FILE" "$HEADER"
else
    echo -e "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "⚠️ 未检索到 EEPROM_FROM_FILE 宏！无法切换文件EEPROM优先模式"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "::warning::源码未找到EEPROM_FROM_FILE宏，文件优先EEPROM方案失效"
fi

echo -e "\n============================================="
echo "检测完成，脚本仅打印信息，未修改任何源码文件"
echo "============================================="
