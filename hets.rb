require "formula"

class Hets < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.

  homepage "http://www.informatik.uni-bremen.de/agbkb/forschung/formal_methods/CoFI/hets/index_e.htm"
  head "https://svn-agbkb.informatik.uni-bremen.de/Hets/trunk/"

  depends_on :x11
  depends_on 'hets_dependencies'
  depends_on 'hets-lib'
  depends_on 'pellet'
  depends_on 'uDrawGraph'

  option 'with-wrapper', 'install the wrapper script to actually run hets.'

  def install
    system('make')
    local_bin = prefix.join('bin')
    local_lib = prefix.join('lib')

    local_bin.mkpath
    local_lib.mkpath

    local_bin.install('hets')

    owl_tools = local_lib.join('hets-owl-tools')

    owl_tools.mkpath

    system('make initialize java')
    owl_tools.install('OWL2/OWL2Parser.jar')
    owl_tools.install('OWL2/OWLLocality.jar')
    owl_tools.install('DMU/OntoDMU.jar')
    owl_tools.install('CASL/Termination/AProVE.jar')
    owl_tools.join('lib').mkpath
    owl_tools.join('lib').install('OWL2/lib/owl2api-bin.jar')

    if build.with? 'wrapper'
      # install hets in bin as script which sets according
      # environment variables
      # (taken and adjusted from script file in hets root dir)
      bin.mkdir
      bin.join("hets").open('w') do |f|
        f.write <<-BASH
#!/bin/bash
export HETS_LIB=/usr/local/opt/hets-lib
export HETS_OWL_TOOLS=#{hets_dir}/hets-owl-tools
export HETS_APROVE=$HETS_OWL_TOOLS/AProVE.jar
export HETS_ONTODMU=$HETS_OWL_TOOLS/OntoDMU.jar
export PELLET_PATH=/usr/local/opt/pellet
"#{hets_dir}/hets" "$@"
      BASH
    end
    end
  end

  def caveats
  end

end
