require 'formula'

class HetsDependencies < Formula

  depends_on 'ghc'
  depends_on 'cabal-install'

  def install
    programatica_url = 'http://www.dfki.de/sks/hets/src-distribution/programatica-1.0.0.4.tar.gz'
    pre=`ghc --print-libdir | sed -e 's+/lib.*/.*++g'`
    opts="--enable-documentation -p --global --prefix=$pre"


    puts "Installing libraries..."
    packages = %w{aterm
      random utf8-string xml fgl HTTP haskeline
      HaXml hexpat uni-uDrawGraph parsec1 wai-extra
      warp tar}
    silent_system("cabal install #{packages.join(' ')} #{opts}"

    silent_system("cabal install #{programatica_url} --global --prefix=#{pre}")

    silent_system("ghc-pkg hide parsec1")
    silent_system("ghc-pkg hide programatica")

  end

  def silent_system(string)
    system(string + " 2>&1 /dev/null")
  end

end
