#!/bin/bash

#
# Copyright 2021-2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Fail on any error.
set -e
# Display commands being run.
set -x

# Compile Android build target.
bazel build \
  -c opt \
  --cxxopt='-std=c++17' \
  --experimental_repo_remote_exec \
  --verbose_failures \
  --copt -DBOOST_ERROR_CODE_HEADER_ONLY \
  --copt -DMESA_EGL_NO_X11_HEADERS \
  --copt -DEGL_NO_X11 \
  --crosstool_top=//external:android/crosstool \
  --host_crosstool_top=@bazel_tools//tools/cpp:toolchain \
  --fat_apk_cpu=arm64-v8a,armeabi-v7a,x86,x86_64 \
  --cpu=x86 \
  --define EXCLUDE_OPENCV_SO_LIB=1 \
  //magritte/examples/android/demo/java:magritte_demo
