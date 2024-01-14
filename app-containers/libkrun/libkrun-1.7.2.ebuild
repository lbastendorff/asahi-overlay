# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	ahash@0.8.2
	aho-corasick@0.7.18
	atty@0.2.14
	autocfg@1.0.1
	bincode@1.3.3
	bitfield@0.13.2
	bitflags@1.3.2
	byteorder@1.4.3
	cc@1.0.70
	cfg-if@1.0.0
	chrono@0.4.19
	codicon@3.0.0
	crc32fast@1.2.1
	crossbeam-channel@0.5.6
	crossbeam-utils@0.8.11
	curl@0.4.44
	curl-sys@0.4.56+curl-7.83.1
	dirs@5.0.1
	dirs-sys@0.4.1
	env_logger@0.9.0
	flate2@1.0.21
	foreign-types@0.3.2
	foreign-types-shared@0.1.1
	getrandom@0.2.3
	hashbrown@0.13.2
	hermit-abi@0.1.19
	hex@0.4.3
	humantime@2.1.0
	iocuddle@0.1.1
	itoa@0.4.8
	kbs-types@0.5.1
	kvm-bindings@0.6.0
	kvm-ioctls@0.15.0
	lazy_static@1.4.0
	libc@0.2.151
	libz-sys@1.1.8
	log@0.4.14
	lru@0.9.0
	memchr@2.4.1
	memoffset@0.6.5
	miniz_oxide@0.4.4
	nix@0.24.3
	num-integer@0.1.44
	num-traits@0.2.14
	once_cell@1.17.0
	openssl@0.10.36
	openssl-probe@0.1.5
	openssl-sys@0.9.66
	option-ext@0.2.0
	pkg-config@0.3.19
	ppv-lite86@0.2.10
	proc-macro2@1.0.70
	procfs@0.12.0
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.3
	redox_syscall@0.2.10
	redox_users@0.4.0
	regex@1.5.6
	regex-syntax@0.6.26
	ryu@1.0.5
	schannel@0.1.20
	serde@1.0.130
	serde-big-array@0.5.1
	serde_bytes@0.11.5
	serde_derive@1.0.130
	serde_json@1.0.67
	sev@1.2.1
	socket2@0.4.4
	static_assertions@1.1.0
	syn@1.0.76
	syn@2.0.41
	termcolor@1.1.3
	thiserror@1.0.51
	thiserror-impl@1.0.51
	time@0.1.43
	unicode-ident@1.0.12
	unicode-xid@0.2.2
	uuid@1.6.1
	vcpkg@0.2.15
	version_check@0.9.4
	virtio-bindings@0.2.0
	vm-fdt@0.2.0
	vm-memory@0.13.1
	vmm-sys-util@0.11.0
	wasi@0.10.2+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.36.1
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.36.1
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.36.1
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.36.1
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.36.1
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.36.1
	windows_x86_64_msvc@0.48.5
"

inherit cargo

DESCRIPTION="A dynamic library providing Virtualization-based process isolation capabilities"
HOMEPAGE="https://github.com/containers/libkrun"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/containers/libkrun/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-containers/libkrunfw"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/patchelf"

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	dodoc README.md
}
