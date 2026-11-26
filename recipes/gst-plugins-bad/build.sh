#!/bin/bash

set -euxo pipefail

cd subprojects/gst-plugins-bad

# conda-forge's onnxruntime-cpp does not ship a pkg-config file and puts
# its headers in include/onnxruntime/core/session.
ORT_VERSION=$(basename $PREFIX/lib/libonnxruntime.so.*.*.* | sed 's/^libonnxruntime\.so\.//')
mkdir -p $SRC_DIR/pkgconfig-shim
cat > $SRC_DIR/pkgconfig-shim/libonnxruntime.pc <<EOF
prefix=$PREFIX
libdir=\${prefix}/lib
includedir=\${prefix}/include/onnxruntime

Name: libonnxruntime
Description: ONNX Runtime
Version: $ORT_VERSION
Libs: -L\${libdir} -lonnxruntime
Cflags: -I\${includedir}
EOF

export PKG_CONFIG_PATH=$SRC_DIR/pkgconfig-shim:$PKG_CONFIG_PATH

meson setup builddir \
  ${MESON_ARGS} \
  --wrap-mode=nofallback \
  -Dexamples=disabled \
  -Dtests=disabled \
  -Dnvcomp=disabled \
  -Dnvdswrapper=disabled \
  -Dcuda-nvmm=disabled \
  -Dnvcodec=enabled \
  -Dhip=enabled \
  -Ddecklink=disabled \
  -Ddecklink2=disabled \
  -Donnx=enabled

meson compile -C builddir -j "${CPU_COUNT}" -v
meson install -C builddir
