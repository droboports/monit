### MONIT ###
_build_monit() {
local VERSION="5.15"
local FOLDER="monit-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="https://mmonit.com/monit/dist/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="" \
  --enable-static --disable-shared \
  --without-pam --without-ssl \
  libmonit_cv_setjmp_available=yes libmonit_cv_vsnprintf_c99_conformant=yes
make
make install DESTDIR="${DEST}"
"${STRIP}" -s -R .comment -R .note -R .note.ABI-tag "${DEST}/bin/monit"
popd
}

_build() {
  _build_monit
  _package
}
