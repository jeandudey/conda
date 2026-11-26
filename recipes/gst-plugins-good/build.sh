#!/bin/bash

set -euxo pipefail

cd subprojects/gst-plugins-good
meson setup builddir \
  ${MESON_ARGS} \
  --wrap-mode=nofallback \
  -Dadaptivedemux2=enabled \
  -Dhls-crypto=openssl \
  -Dbz2=enabled \
  -Dflac=enabled \
  -Djack=enabled \
  -Djpeg=enabled \
  -Dlame=enabled \
  -Dmpg123=enabled \
  -Dpng=enabled \
  -Dpulse=enabled \
  -Dsoup=enabled \
  -Dv4l2=enabled \
  -Dv4l2-gudev=disabled \
  -Dv4l2-libv4l2=disabled \
  -Dvpx=enabled \
  -Dximagesrc=enabled \
  -Dximagesrc-xshm=enabled \
  -Dximagesrc-xfixes=enabled \
  -Dximagesrc-xdamage=enabled \
  -Dximagesrc-navigation=enabled \
  -Damrnb=disabled \
  -Damrwbdec=disabled \
  -Dcairo=disabled \
  -Ddv=disabled \
  -Ddv1394=disabled \
  -Dgdk-pixbuf=disabled \
  -Dgtk3=disabled \
  -Dqt5=disabled \
  -Dqt6=disabled \
  -Drpicamsrc=disabled \
  -Dshout2=disabled \
  -Dspeex=disabled \
  -Dtaglib=disabled \
  -Dtwolame=disabled \
  -Dwavpack=disabled \
  -Dexamples=disabled \
  -Dtests=disabled

meson compile -C builddir -j "${CPU_COUNT}" -v
meson install -C builddir
