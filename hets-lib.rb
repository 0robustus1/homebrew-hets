require "formula"

class HetsLib < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.
  # version "2014-01-06"
  # sha1 "8f7a8ee54c32e67933cb84f5c66fd08da98dd2a1"

  homepage 'http://www.informatik.uni-bremen.de/cofi/Libraries/'
  url "http://www.informatik.uni-bremen.de/cofi/Libraries/lib.tgz"
  version 'unknown'
  sha1 '25156a085a0f299f93ca49c6232ca5836e393e5f'

  def install
    prefix.install Dir['*']
  end

  def caveats
  end

end
