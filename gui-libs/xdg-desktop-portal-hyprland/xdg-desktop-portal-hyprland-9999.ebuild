# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="xdg-desktop-portal backend for hyprland"
HOMEPAGE="https://github.com/hyprwm/xdg-desktop-portal-hyprland"

inherit git-r3
KEYWORDS=""
EGIT_REPO_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland.git"

LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	media-video/pipewire
	dev-cpp/sdbus-c++
	dev-libs/hyprlang
	gui-libs/hyprutils
	dev-libs/hyprland-protocols
	dev-util/hyprwayland-scanner
	dev-libs/inih
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtwayland:6
	media-libs/mesa
	sys-apps/util-linux
	x11-libs/libdrm
	|| (
		systemd? ( >=sys-apps/systemd-237 )
		elogind? ( >=sys-auth/elogind-237 )
		sys-libs/basu
	)
"

RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
"

BDEPEND="
	>=dev-libs/wayland-protocols-1.24
	dev-libs/hyprland-protocols
	virtual/pkgconfig
	|| ( >=sys-devel/gcc-13:* >=sys-devel/clang-17:* )
"

pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return

	if tc-is-gcc && ver_test $(gcc-version) -lt 13 ; then
		eerror "XDPH needs >=gcc-13 or >=clang-17 to compile."
		eerror "Please upgrade GCC: emerge -v1 sys-devel/gcc"
		die "GCC version is too old to compile XDPH!"
	elif tc-is-clang && ver_test $(clang-version) -lt 17 ; then
		eerror "XDPH needs >=gcc-13 or >=clang-17 to compile."
		eerror "Please upgrade Clang: emerge -v1 sys-devel/clang"
		die "Clang version is too old to compile XDPH!"
	fi
}

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	else
		default
		rmdir "${S}/subprojects/hyprland-protocols" || die
		mv "hyprland-protocols-${PROTO_COMMIT}" "${S}/subprojects/hyprland-protocols" || die
	fi
}

src_prepare() {
	cmake_src_prepare
}
