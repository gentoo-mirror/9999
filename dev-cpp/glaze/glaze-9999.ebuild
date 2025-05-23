# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="Extremely fast, in memory, JSON and interface library for modern C++"
HOMEPAGE="https://github.com/stephenberry/${PN}"
EGIT_REPO_URI="${HOMEPAGE}.git"
SLOT=0

KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
}
