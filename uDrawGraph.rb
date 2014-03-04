require "formula"

class Udrawgraph < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.
  # version "2014-01-06"
  # sha1 "8f7a8ee54c32e67933cb84f5c66fd08da98dd2a1"

  homepage 'http://www.informatik.uni-bremen.de/uDrawGraph/en/uDrawGraph/uDrawGraph.html'
  url "http://www.informatik.uni-bremen.de/uDrawGraph/download/uDrawGraph-3.1.1-5-macosx-i386.tar.gz"
  version "3.1.1-5"
  sha1 '6b70847a47b2a042e03572302eb3f90831f86f60'

  def install
    inreplace 'bin/.uDrawGraph-wrapper' do |s|
      s.sub! 'UDG_HOME=`dirname "$0"`/..', 'UDG_HOME=/usr/local/opt/udrawgraph/'
    end
    prefix.install Dir['*']
    system("rm -f #{bin.join('wish')}")
  end

  def caveats
  end

end
