require "formula"

class HetsLib < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.

  @@revision = 'ecafeecc94554392d70022a2d9e9fce1448298c8'
  homepage 'http://www.informatik.uni-bremen.de/cofi/Libraries/'
  url "https://github.com/spechub/Hets-lib.git", :using => :git, :revision => @@revision
  version "unknown-#{@@revision}"

  def install
    prefix.install Dir['*']
  end

  def caveats
  end

end
