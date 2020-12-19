#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE_COMMON=universal8895-common
VENDOR=samsung

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi


# Initialize the helper
setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}" true

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

# Fix proprietary blobs
BLOB_ROOT="$ANDROID_ROOT"/vendor/"$VENDOR"/"$DEVICE_COMMON"/proprietary

sed -i "s/xliff=\"urn:oasis:names:tc:xliff:document:1.2\"/android=\"http:\/\/schemas.android.com\/apk\/res\/android\"/" $BLOB_ROOT/etc/nfcee_access.xml
sed -i -z "s/    seclabel u:r:gpsd:s0\n//" $BLOB_ROOT/vendor/etc/init/init.gps.rc
sed -i -z "s/-g@android:wpa_wlan0\n    class main\n/-g@android:wpa_wlan0\n    interface android.hardware.wifi.supplicant@1.0::ISupplicant default\n    interface android.hardware.wifi.supplicant@1.1::ISupplicant default\n    interface android.hardware.wifi.supplicant@1.2::ISupplicant default\n    class main\n/" $BLOB_ROOT/vendor/etc/init/wifi.rc
sed -i -z "s/    setprop wifi.interface wlan0\n\n/    setprop wifi.interface wlan0\n    setprop wifi.concurrent.interface swlan0\n\n/" $BLOB_ROOT/vendor/etc/init/wifi.rc

# replace SSLv3_client_method with SSLv23_method
sed -i "s/SSLv3_client_method/SSLv23_method\x00\x00\x00\x00\x00\x00/" $BLOB_ROOT/vendor/bin/hw/gpsd

# Remove libhidltransport dependencie
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib/android.hardware.bluetooth.a2dp@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib/android.hardware.gnss@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib/android.hardware.gnss@1.1.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib/libGrallocWrapper.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib/libskeymaster.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib/vendor.samsung.hardware.gnss@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/android.hardware.bluetooth.a2dp@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/android.hardware.bluetooth@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/android.hardware.gnss@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/android.hardware.gnss@1.1.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/android.hardware.nfc@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/android.hardware.nfc@1.1.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/libGrallocWrapper.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/libskeymaster.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/vendor.samsung.hardware.bluetooth@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/vendor.samsung.hardware.gnss@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/vendor.samsung.hardware.nfc@1.1.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/lib64/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/bin/hw/android.hardware.bluetooth@1.0-service
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/bin/hw/android.hardware.drm@1.1-service.widevine
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/bin/hw/sec.android.hardware.nfc@1.1-service
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/bin/hw/vendor.samsung.hardware.gnss@1.0-service
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/bin/hw/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0-service
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/libril.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/libsec-ril-dsds.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/libsec-ril.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/libskeymaster3device.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/libstagefright_bufferqueue_helper_vendor.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/libstagefright_omx_vendor.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/libwvhidl.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/sensors.sensorhub.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/vendor.samsung.hardware.radio.bridge@2.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/vendor.samsung.hardware.radio.channel@2.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib/vendor.samsung.hardware.radio@2.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/hw/android.hardware.bluetooth@1.0-impl.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/hw/android.hardware.gnss@1.1-impl.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/hw/vendor.samsung.hardware.gnss@1.0-impl.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/libril.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/libsec-ril-dsds.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/libsec-ril.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/libskeymaster3device.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/nfc_nci_sec.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/sensors.sensorhub.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/vendor.samsung.hardware.radio.bridge@2.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/vendor.samsung.hardware.radio.channel@2.0.so
patchelf --remove-needed libhidltransport.so $BLOB_ROOT/vendor/lib64/vendor.samsung.hardware.radio@2.0.so
# Remove libhwbinder dependencie
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib/android.hardware.bluetooth.a2dp@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib/android.hardware.gnss@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib/android.hardware.gnss@1.1.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib/vendor.samsung.hardware.gnss@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/android.hardware.bluetooth.a2dp@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/android.hardware.bluetooth@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/android.hardware.gnss@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/android.hardware.gnss@1.1.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/android.hardware.nfc@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/android.hardware.nfc@1.1.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/vendor.samsung.hardware.bluetooth@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/vendor.samsung.hardware.gnss@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/vendor.samsung.hardware.nfc@1.1.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/lib64/vendor.samsung_slsi.hardware.ExynosHWCServiceTW@1.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/bin/hw/android.hardware.drm@1.1-service.widevine
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/bin/hw/sec.android.hardware.nfc@1.1-service
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib/libril.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib/libsec-ril-dsds.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib/libsec-ril.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib/libwvhidl.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib/vendor.samsung.hardware.radio.bridge@2.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib/vendor.samsung.hardware.radio.channel@2.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib/vendor.samsung.hardware.radio@2.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib64/hw/vendor.samsung.hardware.gnss@1.0-impl.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib64/libril.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib64/libsec-ril-dsds.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib64/libsec-ril.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib64/vendor.samsung.hardware.radio.bridge@2.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib64/vendor.samsung.hardware.radio.channel@2.0.so
patchelf --remove-needed libhwbinder.so $BLOB_ROOT/vendor/lib64/vendor.samsung.hardware.radio@2.0.so

# Protobuf
patchelf --replace-needed libprotobuf-cpp-lite.so libprotobuf-cpp-lite-v29.so $BLOB_ROOT/vendor/lib/libwvhidl.so
patchelf --replace-needed libprotobuf-cpp-lite.so libprotobuf-cpp-lite-v29.so $BLOB_ROOT/vendor/lib/mediadrm/libwvdrmengine.so
patchelf --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-full-v29.so $BLOB_ROOT/vendor/lib/libsec-ril-dsds.so
patchelf --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-full-v29.so $BLOB_ROOT/vendor/lib/libsec-ril.so
patchelf --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-full-v29.so $BLOB_ROOT/vendor/lib64/libsec-ril-dsds.so
patchelf --replace-needed libprotobuf-cpp-full.so libprotobuf-cpp-full-v29.so $BLOB_ROOT/vendor/lib64/libsec-ril.so

# charger
patchelf --add-needed libmemset.so $BLOB_ROOT/lib64/libpixelflinger.so

"${MY_DIR}/setup-makefiles.sh"
