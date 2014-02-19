require 'formula'

class HetsDependencies < Formula

  url "https://gist.github.com/0robustus1/9049050/raw/57625927b7f155611eb0dfe353c96128dce45fe7/install_cabal_hets_deps.sh"
  homepage 'https://gist.github.com/0robustus1/9049050'
  sha1 'becccbe9553856203641bd18f054ecd0a3af7fcf'

  depends_on 'ghc'
  depends_on 'cabal-install'

  def install
    system('bash install_cabal_hets_deps.sh')
  end

end
