#!/bin/bash

set -euxo pipefail

cd subprojects/gstreamer
meson setup builddir \
  ${MESON_ARGS} \
  --wrap-mode=nofallback \
  -Dintrospection=enabled \
  -Dptp-helper-permissions=none \
  -Dexamples=disabled \
  -Dtests=disabled

meson compile -C builddir -j "${CPU_COUNT}" -v
meson install -C builddir

# remove gdb files
rm -rf $PREFIX/share/gdb
rm -rf $PREFIX/share/gstreamer-1.0/gdb
