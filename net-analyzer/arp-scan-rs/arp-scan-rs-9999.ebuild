# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.14.0

EAPI=8

CRATES="
	aho-corasick@1.1.2
	ansi_term@0.12.1
	anstream@0.6.7
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.4
	bitflags@2.4.1
	cfg-if@1.0.0
	clap@4.4.16
	clap_builder@4.4.16
	clap_lex@0.6.0
	colorchoice@1.0.0
	csv-core@0.1.11
	csv@1.3.0
	ctrlc@3.4.2
	dns-lookup@2.0.4
	equivalent@1.0.1
	getrandom@0.2.12
	glob@0.3.1
	hashbrown@0.14.3
	indexmap@2.1.0
	ipnetwork@0.20.0
	itoa@1.0.10
	libc@0.2.152
	memchr@2.7.1
	nix@0.27.1
	no-std-net@0.6.0
	pnet@0.34.0
	pnet_base@0.34.0
	pnet_datalink@0.34.0
	pnet_macros@0.34.0
	pnet_macros_support@0.34.0
	pnet_packet@0.34.0
	pnet_sys@0.34.0
	pnet_transport@0.34.0
	ppv-lite86@0.2.17
	proc-macro2@1.0.76
	quote@1.0.35
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	ryu@1.0.16
	serde@1.0.195
	serde_derive@1.0.195
	serde_json@1.0.111
	serde_yaml@0.9.30
	socket2@0.5.5
	strsim@0.10.0
	syn@2.0.48
	unicode-ident@1.0.12
	unsafe-libyaml@0.2.10
	utf8parse@0.2.1
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
"

inherit cargo git-r3

DESCRIPTION="A minimalistic ARP scan tool"
HOMEPAGE="https://github.com/Saluki/arp-scan-rs"
SRC_URI="
	${CARGO_CRATE_URIS}
"

EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="AGPL-3+"
# Dependent crate licenses
LICENSE+="
	MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS=""

RDEPEND="!net-analyzer/arp-scan"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
