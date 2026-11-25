#!/bin/bash

set -xeuo pipefail

cmake -GNinja ${CMAKE_ARGS} \
    -DGPU_TARGETS=${CONDA_FORGE_DEFAULT_ROCM_GPU_TARGETS} \
    -DAMDGPU_TARGETS=${CONDA_FORGE_DEFAULT_ROCM_GPU_TARGETS} \
    -DCMAKE_C_COMPILER="${CC}" \
    -DCMAKE_CXX_COMPILER="${CXX}" \
    -DLIBDRM_AMDGPU_INCLUDE_DIR="${PREFIX}/include" \
    -DLIBDRM_AMDGPU_LIBRARY="${PREFIX}/lib/libdrm_amdgpu.so" \
    -DLIBVA_INCLUDE_DIR="${PREFIX}/include" \
    -DLIBVA_DRM_LIBRARY="${PREFIX}/lib/libva-drm.so" \
    -DLIBVA_LIBRARY="${PREFIX}/lib/libva.so" \
    -Bbuild -S.
cmake --build ./build
cmake --install ./build
rm -rf "${PREFIX}/share/rocjpeg"
