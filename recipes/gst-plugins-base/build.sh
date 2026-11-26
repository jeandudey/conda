#!/bin/bash

set -euxo pipefail

cd subprojects/gst-plugins-base
meson setup builddir \
  ${MESON_ARGS} \
  --wrap-mode=nofallback \
  -Dintrospection=enabled \
  -Dgl=enabled \
  -Dexamples=disabled \
  -Dtests=disabled \

meson compile -C builddir -j "${CPU_COUNT}" -v
meson install -C builddir
