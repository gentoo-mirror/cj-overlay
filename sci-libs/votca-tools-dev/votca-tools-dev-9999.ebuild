# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools mercurial

DESCRIPTION="Votca tools library (developer version)"
HOMEPAGE="http://www.votca.org"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
PROPERTIES="interactive"

DEPEND="!sci-libs/votca-tools
	sci-libs/fftw:3.0
	dev-libs/libxml2
	sci-libs/gsl
	>=dev-libs/boost-1.33.1"

RDEPEND="${DEPEND}"

EHG_REPO_URI="http://dev.votca.org/votca/tools"

S="${WORKDIR}/tools"

src_prepare() {
	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	econf || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc NOTICE
}
