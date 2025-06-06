# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic toolchain-funcs

DESCRIPTION="Hyprland's GPU-accelerated screen locking utility"
HOMEPAGE="https://github.com/hyprwm/hyprlock"

inherit git-r3
EGIT_REPO_URI="https://github.com/hyprwm/${PN^}.git"
LICENSE="BSD"
SLOT="0"

KEYWORDS=""

RDEPEND="
	gui-libs/hyprutils
	dev-libs/date
	dev-libs/wayland
	media-libs/mesa[opengl]
	sys-libs/pam
	dev-libs/glib:2
	dev-libs/hyprlang
	media-libs/libglvnd
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/libdrm
	x11-libs/pango
	dev-libs/hyprgraphics
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"

BDEPEND="
	~dev-util/hyprwayland-scanner-9999
	virtual/pkgconfig
"

src_configure() {
	if [[ "$(tc-getCC)" = "clang" ]]; then
		append-flags "-fexperimental-library"
	fi
	CMAKE_BUILD_TYPE="Release" cmake_src_configure
}
