pkg_name=libpq
pkg_origin=core
pkg_version=9.6.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="LibPQ is the client side library for PostgreSQL, a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/postgresql-${pkg_version}.tar.bz2
pkg_dirname=postgresql-${pkg_version}
pkg_shasum=399cdffcb872f785ba67e25d275463d74521566318cfef8fe219050d063c8154

pkg_deps=(
  core/glibc
  core/openssl
  core/readline
  core/zlib
  core/libossp-uuid
)

pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
)

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
    # ld manpage: "If -rpath is not used when linking an ELF
    # executable, the contents of the environment variable LD_RUN_PATH
    # will be used if it is defined"
    ./configure --disable-rpath \
              --with-openssl \
              --prefix="$pkg_prefix" \
              --with-uuid=ossp \
              --with-includes="$LD_INCLUDE_PATH" \
              --with-libraries="$LD_LIBRARY_PATH" \
              --sysconfdir="$pkg_svc_config_path" \
              --localstatedir="$pkg_svc_var_path" \
              --without-tcl --without-perl --without-python
    # making everything and throwing away all but the client side is a
    # little bit slow, but seems to be the simplest way to go
    make
}

do_install() {
    # This is straight out of the 'client-only installation' section of:
    # https://www.postgresql.org/docs/9.6/static/install-procedure.html#INSTALL
    # we could delete everthing but psql and be fine, but that is messy
    make -C src/bin install
    # not all of the include files are needed for client side, but for simplicit's sake we install them all.
    make -C src/include install
    make -C src/interfaces install
}