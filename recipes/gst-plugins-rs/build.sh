#!/bin/bash

set -euxo pipefail

meson setup builddir \
  ${MESON_ARGS} \
  --wrap-mode=nodownload \
  -Dgtk4=enabled \
  -Dvalidate=disabled

meson compile -C builddir -j "${CPU_COUNT}" -v
meson install -C builddir
