/*
 * Copyright (C) 2017 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "libexynosdisplay_shim"
#define LOG_NDEBUG 1

#include <cutils/log.h>
#include <cutils/native_handle.h>

//int32_t ExynosLayer::setLayerBuffer(buffer_handle_t buffer, int32_t acquireFence)
bool _ZN11ExynosLayer14setLayerBufferEPK13native_handlei(buffer_handle_t buffer, int32_t acquireFence)
{
    ALOGV("SHIM: hijacking %s!", __func__);

    /* Force this check to always return false */
    return 0;
}
