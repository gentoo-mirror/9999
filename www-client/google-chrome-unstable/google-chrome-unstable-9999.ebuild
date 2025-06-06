# Copyright 2011-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk ur vi zh-CN zh-TW"

inherit chromium-2 desktop pax-utils unpacker xdg

DESCRIPTION="The web browser from Google"
HOMEPAGE="https://www.google.com/chrome"

if [[ ${PN} == google-chrome ]]; then
	MY_PN=${PN}-stable
else
	MY_PN=${PN}
fi

MY_PN="google-chrome-canary"
SRC_URI="https://dl.google.com/linux/direct/google-chrome-canary_current_amd64.deb"
S=${WORKDIR}

LICENSE="google-chrome"
SLOT="0"
KEYWORDS=""

IUSE="qt5 qt6 selinux"

RESTRICT="bindist mirror strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	>=dev-libs/nss-3.26
	media-fonts/liberation-fonts
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	sys-libs/libcap
	gui-libs/gtk
	x11-libs/libdrm
	x11-libs/pango
	x11-misc/xdg-utils
	qt6? ( dev-qt/qtbase:6[gui,widgets] )
	selinux? ( sec-policy/selinux-chromium )
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/google-chrome.*\\.desktop"
CHROME_HOME="opt/google/chrome${MY_PN#google-chrome}"

pkg_nofetch() {
	eerror "Please wait 24 hours and sync your tree before reporting a bug for google-chrome fetch failures."
}

pkg_pretend() {
	# Protect against people using autounmask overzealously
	use amd64 || die "google-chrome only works on amd64"
}

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	rm -r etc usr/share/menu || die
	mv usr/share/doc/${MY_PN} usr/share/doc/${PF} || die

	gzip -d usr/share/doc/${PF}/changelog.gz || die
	gzip -d usr/share/man/man1/${MY_PN}.1.gz || die
	if [[ -L usr/share/man/man1/google-chrome.1.gz ]]; then
		rm usr/share/man/man1/google-chrome.1.gz || die
		dosym ${MY_PN}.1 usr/share/man/man1/google-chrome.1
	fi

	pushd "${CHROME_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	if ! use qt5; then
		rm "${CHROME_HOME}/libqt5_shim.so" || die
	fi
	if ! use qt6; then
		rm "${CHROME_HOME}/libqt6_shim.so" || die
	fi

	local suffix=
	[[ ${PN} == google-chrome-beta ]] && suffix=_beta
	[[ ${PN} == google-chrome-unstable ]] && suffix=_canary

	local size
	for size in 16 24 32 48 64 128 256 ; do
		newicon -s ${size} "${CHROME_HOME}/product_logo_${size}${suffix}.png" ${PN}.png
	done

	pax-mark m "${CHROME_HOME}/chrome"
}
