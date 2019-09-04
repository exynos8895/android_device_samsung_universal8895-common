#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/universal8895-common

BUILD_BROKEN_DUP_RULES := true

# Include path
TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Audio
USE_XML_AUDIO_POLICY_CONF := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth

# Firmware
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
TARGET_BOARD_PLATFORM := exynos5
TARGET_SOC := exynos8895
TARGET_BOOTLOADER_BOARD_NAME := universal8895
BOARD_VENDOR := samsung

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := exynos-m1

# Secondary Architecture
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53.a57

# Binder
TARGET_USES_64_BIT_BINDER := true

# Apex
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Extracted with libbootimg
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := hardware/samsung/mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_IMAGE_NAME := Image
#BOARD_KERNEL_CMDLINE := The bootloader ignores the cmdline from the boot.img
BOARD_KERNEL_SEPARATED_DT := true
TARGET_CUSTOM_DTBTOOL := dtbhtoolExynos
BOARD_ROOT_EXTRA_FOLDERS += efs cpefs
TARGET_KERNEL_CLANG_COMPILE := true

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

# Kernel config
TARGET_KERNEL_SOURCE := kernel/samsung/universal8895

# Use these flags if the board has a ext4 partition larger than 2gb
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE     :=  41943040 #(40960 sda7)
BOARD_RECOVERYIMAGE_PARTITION_SIZE :=  48234496 #(47104 sda8)
BOARD_SYSTEMIMAGE_PARTITION_SIZE   :=  4508876800 #(4454400 sda17)
BOARD_USERDATAIMAGE_PARTITION_SIZE :=  58556678144 #(57184256 sda24)
BOARD_CACHEIMAGE_PARTITION_SIZE    :=  524288000 #(512000 sda18)
BOARD_FLASH_BLOCK_SIZE := 4096

# Exclude AudioFX
TARGET_EXCLUDES_AUDIOFX := true

# Vendor separation
TARGET_COPY_OUT_VENDOR := system/vendor

# Properties
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop

# Device Tree
BOARD_USES_DT := true

# Renderscript
OVERRIDE_RS_DRIVER := libRSDriverArm.so

# Samsung HALs
TARGET_POWERHAL_VARIANT := samsung

# Bluetooth
BOARD_CUSTOM_BT_CONFIG := $(LOCAL_PATH)/bluetooth/libbt_vndcfg.txt
BOARD_HAVE_BLUETOOTH := true

# Backlight
BACKLIGHT_PATH := "/sys/class/backlight/panel/brightness"

# Recovery
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/ramdisk/etc/fstab.samsungexynos8895

# Wifi
TARGET_USES_64_BIT_BCMDHD        := true
BOARD_WLAN_DEVICE                := bcmdhd
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
WPA_SUPPLICANT_USE_HIDL          := true
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/dhd/parameters/firmware_path"
WIFI_DRIVER_NVRAM_PATH_PARAM     := "/sys/module/dhd/parameters/nvram_path"
WIFI_DRIVER_NVRAM_PATH           := "/vendor/etc/wifi/nvram_net.txt"
WIFI_DRIVER_FW_PATH_STA          := "/vendor/etc/wifi/bcmdhd_sta.bin"
WIFI_DRIVER_FW_PATH_AP           := "/vendor/etc/wifi/bcmdhd_apsta.bin"
WIFI_BAND                        := 802_11_ABG
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_FEATURE_DISABLE_AP_MAC_RANDOMIZATION := true

# MACLOADER
BOARD_HAVE_SAMSUNG_WIFI          := true

BOARD_SEPOLICY_DIRS += device/samsung/universal8895-common/sepolicy
BOARD_SEPOLICY_VERS := $(PLATFORM_SDK_VERSION).0

# Shims
TARGET_LD_SHIM_LIBS += \
    /system/lib/libexynoscamera.so|/vendor/lib/libexynoscamera_shim.so \
    /system/lib64/libexynoscamera.so|/vendor/lib64/libexynoscamera_shim.so

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)
