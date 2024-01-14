# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A dynamic library bundling the guest payload consumed by libkrun"
HOMEPAGE="https://github.com/containers/libkrunfw"
SRC_URI="
	https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.4.7.tar.xz -> ${P}-linux-6.4.7.tar.xz
	https://github.com/containers/libkrunfw/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-arch/cpio
	dev-python/pyelftools
"

src_unpack() {
	unpack ${P}.tar.gz
	sed -i "s/strip/ldd/g" ${P}/Makefile
}

src_compile() {
        env -i LC_CTYPE="${LC_ALL:-${LC_CTYPE:-$LANG}}" PATH="$PATH" make ${MAKEOPTS} KERNEL_TARBALL="${DISTDIR}/${P}-linux-6.4.7.tar.xz"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	dodoc README.md
}
