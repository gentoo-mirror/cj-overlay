# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit mercurial

DESCRIPTION="Christoph's useful scripts"
HOMEPAGE="http://code.google.com/p/cj-overlay/source/list?repo=evergreens"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples tk"

DEPEND=""
RDEPEND="dev-lang/perl
		sys-apps/gawk
		tk? ( dev-util/tkdiff )"

EHG_REPO_URI="https://evergreens.cj-overlay.googlecode.com/hg/"

S="${WORKDIR}/hg"

src_install () {
	local exe
	for exe in fcat findgrep fvim guard hgrep in2m4 loggrep qtar sshalias vimless; do
		dobin ${exe}
	done
	dosym fcat /usr/bin/fless
	dosym fcat /usr/bin/fview
	dodoc README
	exeinto /usr/share/${PN}/examples
	doexe skeleton.*
}
