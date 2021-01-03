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

PRODUCT_PROPERTY_OVERRIDES += \
    ro.arch=exynos8895 \
    persist.demo.hdmirotationlock=false \
    dev.usbsetting.embedded=on \
    ro.opengles.version=196610 \
    debug.slsi_platform=1 \
    debug.hwc.winupdate=1 \
    debug.sf.disable_backpressure=1 \
    ro.hdcp2.rx=tz \
    keyguard.no_require_sim=true \
    ro.carrier=unknown \
    vendor.sec.rild.libpath=/vendor/lib64/libsec-ril.so \
    vendor.sec.rild.libpath2=/vendor/lib64/libsec-ril-dsds.so \
    ro.dalvik.vm.native.bridge=0 \
    security.ASKS.policy_version=000000 \
    security.mdf.result=None \
    security.mdf=None \
    ro.security.mdf.ux=Enabled \
    ro.security.mdf.ver=3.1 \
    ro.security.wlan.ver=1.0 \
    ro.security.wlan.release=2 \
    ro.security.mdf.release=4 \
    ro.security.fips.ux=Enabled \
    ro.security.fips_bssl.ver=1.3 \
    ro.security.fips_skc.ver=1.8 \
    ro.security.fips_scrypto.ver=2.0 \
    ro.security.fips_fmp.ver=1.2 \
    ro.sf.lcd_density=480 \
    ro.sf.init.lcd_density=640 \
    ro.build.scafe.version=2019A \
    ro.error.receiver.default=com.samsung.receiver.error \
    ro.config.ringtone=Over_the_Horizon.ogg \
    ro.config.notification_sound=Skyline.ogg \
    ro.config.alarm_alert=Morning_Glory.ogg \
    ro.config.media_sound=Media_preview_Touch_the_light.ogg \
    ro.config.ringtone_2=Basic_Bell.ogg \
    ro.config.notification_sound_2=S_Charming_Bell.ogg \
    ro.hardware.keystore=mdfpp \
    ro.security.vpnpp.ver=2.1 \
    ro.security.vpnpp.release=2.0 \
    sys.config.activelaunch_enable=true \
    ro.frp.pst=/dev/block/persistent \
    persist.sys.tcpOptimizer.on=1 \
    ro.config.dha_cached_min=6 \
    ro.config.dha_cached_max=16 \
    ro.cfg.dha_cached_max=24 \
    ro.config.dha_empty_min=8 \
    ro.config.dha_empty_init=24 \
    ro.config.dha_empty_max=24 \
    ro.cfg.dha_empty_max=30 \
    ro.cfg.dha_empty_init=30 \
    ro.config.fha_enable=true \
    ro.cfg.enable_userspace_lmk=true \
    ro.cfg.kill_heaviest_task=true \
    ro.cfg.custom_tm_limit=1000 \
    ro.cfg.custom_sw_limit=275 \
    ro.cfg.enable_reentry_lmk=true \
    sys.use_fifo_ui=0 \
    ro.config.systemaudiodebug=abox&codecdsp \
    ro.gfx.driver.0=com.samsung.gpudriver.S8MaliG71_90 \
    ro.hardware.egl=mali \
    ro.zygote.disable_gl_preload=true \
    ro.config.vc_call_vol_steps=5 \
    debug.sf.latch_unsignaled=1 \
    debug.stagefright.ccodec=0

# Wifi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.direct.interface=p2p-dev-wlan0 \
    persist.debug.wfd.enable=1

# Configstore
PRODUCT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.max_frame_buffer_acquired_buffers=3

# HWC
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.disable_hwc=1
