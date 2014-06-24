require 'formula'
require "language/haskell"

class HetsDependencies < Formula
  include Language::Haskell::Cabal

  url "https://gist.githubusercontent.com/0robustus1/9049050/raw/a9c8e0dcbefef624090b6d3bce279fd73c579598/install_cabal_hets_deps.sh"
  homepage 'https://gist.github.com/0robustus1/9049050'
  sha1 'cfa0ebdb51e6654ca3cea926b8e3106cda178de1'
  version '0.1.0'

  depends_on 'ghc'
  depends_on 'cabal-install'
  depends_on 'glib'
  depends_on 'cairo'
  depends_on 'gtk'
  depends_on 'gettext'
  depends_on 'fontconfig'

  def install
    opts = ['--force-reinstalls', '--enable-documentation', '-p', '--global']
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
      wai-extra
      warp
      tar
    }
    cabal_sandbox do
      cabal_install(*(opts + packages))
      system('ghc-pkg hide parsec1')
      system('ghc-pkg hide programatica')
    end
  end

end
