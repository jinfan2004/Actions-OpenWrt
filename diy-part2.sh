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

## 全局搜索所有目录（包含build_dir解压出来的驱动源码）
EEPROM_FILES=$(find . -type f -name "MT7981_*EEPROM.bin" 2>/dev/null)
if [ -n "$EEPROM_FILES" ]; then
    echo -e "\n✅ 找到 MT7981 EEPROM 模板文件："
    echo "$EEPROM_FILES"
else
    echo -e "\nℹ️ 全目录未检索到 MT7981_*EEPROM.bin"
fi

## 全局搜索宏，所有.h文件
HEADER=$(find . -type f -name "*.h" | xargs grep -l "EEPROM_FROM_FILE" 2>/dev/null | head -n1)
if [ -n "$HEADER" ]; then
    echo -e "\n✅ 找到 EEPROM_FROM_FILE 头文件：$HEADER"
    grep "EEPROM_FROM_FILE" "$HEADER"
else
    echo -e "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "⚠️ 未检索到 EEPROM_FROM_FILE 宏！文件优先EEPROM方案不可用"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "::warning::源码未找到EEPROM_FROM_FILE宏，无法启用固件内置EEPROM优先加载"
fi

echo -e "\n============================================="
echo "检测结束，仅打印日志，未修改任何文件"
echo "============================================="
