require "formula"
require 'rexml/document'

class Hets < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.
  @@version_commit = 'c06297f09e2ee831878281b5bfb9d7b210df8546'
  @@version_unix_timestamp = '1441029199'
  homepage "http://www.informatik.uni-bremen.de/agbkb/forschung/formal_methods/CoFI/hets/index_e.htm"
  head "https://github.com/spechub/Hets.git", :using => :git
  url "https://github.com/spechub/Hets.git", :using => :git, :revision => @@version_commit
  version "0.99-#{@@version_unix_timestamp}"

  depends_on :x11
  depends_on 'hets-dependencies'
  depends_on 'hets-lib'
  depends_on 'pellet'
  depends_on 'ant'
  depends_on 'udrawgraph'
  depends_on 'darwin'
  depends_on 'eprover'
  depends_on 'spass'
  depends_on 'graphviz'

  conflicts_with 'hets-binary'

  option 'with-wrapper', 'install the wrapper script to actually run hets.'

  def install

    inject_version_suffix

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
    owl_api_jars = %w(lib/owlapi-osgidistribution-3.5.2.jar
                      lib/guava-18.0.jar
                      lib/trove4j-3.0.3.jar)
    owl_api_jars.each do |jar|
      owl_tools.join('lib').install("OWL2/#{jar}")
    end

    local_lib.install('magic/hets.magic')

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
export HETS_MAGIC=/usr/local/opt/hets/lib/hets.magic
export HETS_OWL_TOOLS=/usr/local/opt/hets/lib/hets-owl-tools
export HETS_APROVE=$HETS_OWL_TOOLS/AProVE.jar
export HETS_ONTODMU=$HETS_OWL_TOOLS/OntoDMU.jar
export PELLET_PATH=/usr/local/opt/pellet
exec "/usr/local/opt/hets/bin/hets-bin" "$@"
      BASH
    end
    end
  end

  def version_suffix
    if build.head?
      version = nil
      FileUtils.cd(cached_download) { version = `git log -1 --format=%ct`.to_i }
      version
    else
      @@version_unix_timestamp.to_i
    end
  end

  def inject_version_suffix
    File.open('rev.txt', 'w') { |f| f << version_suffix }
  end

  def caveats
  end

end
