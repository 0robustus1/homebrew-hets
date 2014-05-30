require 'formula'

class HetsDependencies < Formula

  url "https://gist.githubusercontent.com/0robustus1/9049050/raw/a9c8e0dcbefef624090b6d3bce279fd73c579598/install_cabal_hets_deps.sh"
  homepage 'https://gist.github.com/0robustus1/9049050'
  sha1 'cfa0ebdb51e6654ca3cea926b8e3106cda178de1'

  depends_on 'ghc'
  depends_on 'cabal-install'

  def install
    system('bash install_cabal_hets_deps.sh')
  end

end
