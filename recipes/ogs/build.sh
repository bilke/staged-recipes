declare -a CMAKE_PLATFORM_FLAGS
if [[ ${HOST} =~ .*darwin.* ]]; then
  CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
  export LDFLAGS=$(echo "${LDFLAGS}" | sed "s/-Wl,-dead_strip_dylibs//g")
else
  CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")
fi

mkdir build && cd build
cmake -G Ninja \
  -DOGS_BUILD_PROCESSES=HT \
  -DOGS_BUILD_TESTING=OFF \
  -DOGS_USE_MFRONT=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DOGS_USE_PYTHON=ON \
  -DOGS_USE_POETRY=OFF \
  -DPython_EXECUTABLE="$PYTHON" \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_RPATH:STRING=${PREFIX}/lib \
  -DCMAKE_INSTALL_LIBDIR="lib" \
  {CMAKE_PLATFORM_FLAGS[@]} \
  ${SRC_DIR}
cmake --build . --target install
