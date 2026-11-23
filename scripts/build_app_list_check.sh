#!/bin/sh
# SPDX-FileCopyrightText: 2026 RiftWii contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Builds app_list_check from a checkout of RiftWii: the Wii's own parser for
# apps.json (src/net/applist.cpp), so the list is judged by the code that
# reads it on the console.
#
#   build_app_list_check.sh <riftwii checkout> <output binary>
set -eu
riftwii="$1"
out="$2"
c++ -std=c++17 -O2 -Wall -Wextra -I "$riftwii/include" \
    "$riftwii/tools/app_list_check.cpp" "$riftwii/src/net/applist.cpp" -o "$out"
