#!/bin/bash

set -euxo pipefail

cd subprojects/gst-plugins-base
meson setup builddir \
  ${MESON_ARGS} \
  --wrap-mode=nofallback \
  -Dintrospection=enabled \
  -Dgl=enabled \
  -Dgl_platform=egl,glx \
  -Dgl_winsys=x11,wayland,egl,surfaceless \
  -Dexamples=disabled \
  -Dtests=disabled \

meson compile -C builddir -j "${CPU_COUNT}" -v
meson install -C builddir
