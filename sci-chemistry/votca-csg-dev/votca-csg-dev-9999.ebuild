# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools bash-completion mercurial

DESCRIPTION="Votca coarse-graining engine (developer version)"
HOMEPAGE="http://www.votca.org"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
PROPERTIES="interactive"

DEPEND="!sci-chemistry/votca-csg
	sci-libs/fftw:3.0
	dev-libs/libxml2
	sci-libs/gsl
	>=dev-libs/boost-1.33.1
	sci-libs/votca-tools-dev
	!<=sci-chemistry/gromacs-4.0.5[mpi]
	=sci-chemistry/gromacs-4.0*
	dev-lang/perl
	app-shells/bash"

RDEPEND="${DEPEND}"

EHG_REPO_URI="http://dev.votca.org/votca/csg"

S="${WORKDIR}/csg"

pkg_setup() {
	export CPPFLAGS="${CPPFLAGS} -I/usr/include/gromacs"
}

src_prepare() {
	local dir
	for dir in share/scripts/inverse; do
		emake -C "$dir" -f Makefile.am.in Makefile.am || \
		  die "make -f Makefile.am.in Makefile.am in $dir failed"
	done
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
	dodoc README NOTICE

	sed -n -e '/^CSG\(BIN\|SHARE\)/p' "${D}"/usr/bin/CSGRC.bash > "${T}/80votca-csg"
	doenvd "${T}/80votca-csg"
	rm -f "${D}"/usr/bin/CSGRC*

	dobashcompletion "${D}"/usr/share/votca/completion.bash ${PN}
	rm -f "${D}"/usr/share/votca/completion.bash
}

pkg_postinst() {
	env-update && source /etc/profile
	elog
	elog "Please read and cite:"
	elog "VOTCA, J. Chem. Theory Comput. 5, 3211 (2009). "
	elog "http://dx.doi.org/10.1021/ct900369w"
	elog
}
