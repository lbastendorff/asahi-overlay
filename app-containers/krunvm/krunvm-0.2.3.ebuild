# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
        confy@0.4.0
        ansi_term@0.11.0
        atty@0.2.14
        bitflags@1.2.1
        cfg-if@0.1.10
        clap@2.33.3
        directories@2.0.2
        dirs-sys@0.3.5
        libc@0.2.90
        proc-macro2@1.0.24
        quote@1.0.9
        serde@1.0.124
        serde_derive@1.0.124
        strsim@0.8.0
        syn@1.0.64
        text_io@0.1.8
        textwrap@0.11.0
        toml@0.5.8
        unicode-width@0.1.8
        unicode-xid@0.2.1
        vec_map@0.8.2
        arrayref@0.3.6
        arrayvec@0.5.2
        autocfg@1.0.1
        base64@0.13.0
        blake2b_simd@0.5.11
        cfg-if@1.0.0
        constant_time_eq@0.1.5
        crossbeam-utils@0.8.3
        getrandom@0.1.16
        hermit-abi@0.1.18
        lazy_static@1.4.0
        redox_syscall@0.1.57
        redox_users@0.3.5
        rust-argon2@0.8.3
        wasi@0.9.0+wasi-snapshot-preview1
        winapi-i686-pc-windows-gnu@0.4.0
        winapi-x86_64-pc-windows-gnu@0.4.0
        winapi@0.3.9
"

inherit cargo

DESCRIPTION="Create microVMs from OCI images"
HOMEPAGE="https://github.com/containers/krunvm"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/containers/krunvm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-containers/buildah
	app-containers/libkrun
"
RDEPEND="${DEPEND}"
BDEPEND="dev-ruby/asciidoctor"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
#QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	dodoc README.md
}
