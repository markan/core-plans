pkg_name=protobuf3-cpp
pkg_distname=protobuf
pkg_protobuf_runtime=cpp
pkg_origin=core
pkg_version=3.4.1
pkg_license=('BSD')
pkg_source=https://github.com/google/${pkg_distname}/releases/download/v${pkg_version}/${pkg_distname}-${pkg_protobuf_runtime}-${pkg_version}.tar.gz
pkg_shasum=2bb34b4a8211a30d12ef29fd8660995023d119c99fbab2e5fe46f17528c9cc78
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(core/gcc core/zlib)
pkg_build_deps=(core/make)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
