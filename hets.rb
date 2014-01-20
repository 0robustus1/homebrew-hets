require "formula"

class Hets < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.
  version "2014-01-06"
  sha1 "8f7a8ee54c32e67933cb84f5c66fd08da98dd2a1"

  # General settings: should not change usually
  @@dmg_file = "Hets-#{version}.dmg"
  @@nightly_url = "http://www.informatik.uni-bremen.de/agbkb/forschung/formal_methods/CoFI/hets/intel-mac/daily/hets.bz2"
  homepage "http://www.informatik.uni-bremen.de/agbkb/forschung/formal_methods/CoFI/hets/index_e.htm"
  url "http://www.informatik.uni-bremen.de/agbkb/forschung/formal_methods/CoFI/hets/intel-mac/dmgs/#{@@dmg_file}"

  # Options
  option 'with-nightly', 'uses nightly version of the binary'

  depends_on :x11

  def install
    dmg_content = '/Volumes/Hets'
    app_dir = prefix.join('Hets.app')
    hets_dir = app_dir.join('Contents/Resources')
    binary = hets_dir.join('hets')

    system("hdiutil attach -quiet #{@@dmg_file}")

    system("cp -r #{dmg_content}/Hets.app #{app_dir}")

    # install hets in bin as script which sets according
    # environment variables
    # (taken and adjusted from script file in hets root dir)
    bin.mkdir
    bin.join("hets").open('w') do |f|
      f.write <<-BASH
#!/bin/bash
export PATH=#{hets_dir}/uDrawGraph-3.1/bin:$PATH
export HETS_LIB=#{hets_dir}/Hets-lib
export HETS_OWL_TOOLS=#{hets_dir}/hets-owl-tools
export HETS_APROVE=$HETS_OWL_TOOLS/AProVE.jar
export HETS_ONTODMU=$HETS_OWL_TOOLS/OntoDMU.jar
export PELLET_PATH=#{hets_dir}/pellet
"#{hets_dir}/hets" "$@"
      BASH
    end

    system("hdiutil detach -quiet #{dmg_content}")

    # automatically install latest nightly build
    if build.with? 'nightly'
      system("curl -O #{@@nightly_url}")
      system("bunzip2 hets.bz2")
      system("mv hets #{binary}")
      system("chmod +x #{binary}")
    end

  end

end
