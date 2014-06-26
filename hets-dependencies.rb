require 'formula'
require "language/haskell"

class HetsDependencies < Formula
  include Language::Haskell::Cabal

  url "https://gist.githubusercontent.com/0robustus1/9049050/raw/a9c8e0dcbefef624090b6d3bce279fd73c579598/install_cabal_hets_deps.sh"
  homepage 'https://gist.github.com/0robustus1/9049050'
  sha1 'cfa0ebdb51e6654ca3cea926b8e3106cda178de1'
  version '0.1.2'

  depends_on 'ghc'
  depends_on 'cabal-install'
  depends_on 'glib'
  depends_on 'cairo'
  depends_on 'gtk'
  depends_on 'gettext'
  depends_on 'fontconfig'

  def install
    ghc_prefix = `ghc --print-libdir | sed -e 's+/lib.*/.*++g'`
    opts = ['--force-reinstalls', '--enable-documentation', '-p', '--global', "--prefix=#{ghc_prefix}"]
    packages = %w{
      aterm
      random
      utf8-string
      xml
      fgl
      HTTP
      haskeline
      HaXml
      hexpat
      uni-uDrawGraph
      parsec1
      wai-extra-2.1.0.1
      warp-2.1.1.1
      http://www.informatik.uni-bremen.de/agbkb/forschung/formal_methods/CoFI/hets/src-distribution/programatica-1.0.0.5.tar.gz
      tar
    }
    system('cabal update')
    cabal_install(*(opts + packages))
    system('ghc-pkg hide parsec1')
    system('ghc-pkg hide programatica')
  end

end
