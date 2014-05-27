require 'formula'

class HetsDependencies < Formula

  url "https://gist.githubusercontent.com/0robustus1/9049050/raw/62b6f5a86b975e7c2db671c8c631643504d5f50e/install_cabal_hets_deps.sh"
  homepage 'https://gist.github.com/0robustus1/9049050'
  sha1 'f44ba593fd804baf9b18a94a8499e57228258345'

  depends_on 'ghc'
  depends_on 'cabal-install'

  def install
    system('bash install_cabal_hets_deps.sh')
  end

end
