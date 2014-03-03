require "formula"

class HetsLib < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.

  @@revision = 1830
  homepage 'http://www.informatik.uni-bremen.de/cofi/Libraries/'
  url "https://svn-agbkb.informatik.uni-bremen.de/Hets-lib/trunk/", :using => :svn, :revision => @@revision
  version "unknown-#{@@revision}"

  def install
    prefix.install Dir['*']
  end

  def caveats
  end

end
