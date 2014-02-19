require "formula"

class Hets < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.
  revision = 18505
  homepage "http://www.informatik.uni-bremen.de/agbkb/forschung/formal_methods/CoFI/hets/index_e.htm"
  head "https://svn-agbkb.informatik.uni-bremen.de/Hets/trunk/", :using => :svn
  url "https://svn-agbkb.informatik.uni-bremen.de/Hets/trunk/", :using => :svn, :revision => revision
  version "0.99-#{revision}"

  depends_on :x11
  depends_on 'hets_dependencies'
  depends_on 'hets-lib'
  depends_on 'pellet'
  depends_on 'uDrawGraph'

  conflicts_with 'hets-binary'

  option 'with-wrapper', 'install the wrapper script to actually run hets.'

  def install
    # ENV['PATH'] = "~/.cabal/bin:/usr/local/opt/ghc/bin:/usr/local/opt/cabal-install/bin:/usr/local/opt/uDrawGraph/bin:#{ENV['PATH']}"

    puts 'Compiling hets...'
    system('make -j 1')
    system('strip hets')

    puts 'Compiling owl-tools...'
    system('make initialize_java')

    puts 'Putting everything together'
    local_bin = prefix.join('bin')
    local_lib = prefix.join('lib')

    local_bin.mkpath
    local_lib.mkpath

    local_bin.install('hets')

    owl_tools = local_lib.join('hets-owl-tools')

    owl_tools.mkpath

    owl_tools.install('OWL2/OWL2Parser.jar')
    owl_tools.install('OWL2/OWLLocality.jar')
    owl_tools.install('DMU/OntoDMU.jar')
    owl_tools.install('CASL/Termination/AProVE.jar')
    owl_tools.join('lib').mkpath
    owl_tools.join('lib').install('OWL2/lib/owl2api-bin.jar')

    if build.with? 'wrapper'
      puts 'Install the wrapper script'
      FileUtils.mv bin.join('hets').to_s, bin.join('hets-bin').to_s
      # install hets in bin as script which sets according
      # environment variables
      # (taken and adjusted from script file in hets root dir)
      bin.join("hets").open('w') do |f|
        f.write <<-BASH
#!/bin/bash
export HETS_LIB=/usr/local/opt/hets-lib
export HETS_OWL_TOOLS=/usr/local/opt/hets/lib/hets-owl-tools
export HETS_APROVE=$HETS_OWL_TOOLS/AProVE.jar
export HETS_ONTODMU=$HETS_OWL_TOOLS/OntoDMU.jar
export PELLET_PATH=/usr/local/opt/pellet
"/usr/local/opt/hets/bin/hets-bin" "$@"
      BASH
    end
    end
  end

  def caveats
  end

end
