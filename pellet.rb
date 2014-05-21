require "formula"

class Pellet < Formula
  # Both the version and the sha1 need to be adjusted when a new
  # dmg-version of hets is released.
  # version "2014-01-06"
  # sha1 "8f7a8ee54c32e67933cb84f5c66fd08da98dd2a1"

  homepage 'http://clarkparsia.com/pellet'
  head 'https://github.com/clarkparsia/pellet'
  url "https://github.com/clarkparsia/pellet/archive/2.3.1.tar.gz"
  version "2.3.1"
  sha1 '7d46c04fdae8d8a15af07521c4cb033fd39385eb'

  option 'with-script', 'includes a pellet script which is placed in PATH'

  def install
    system('ant')
    prefix.install Dir['dist/*']

    if build.with? 'script'
      bin.mkdir
      bin.join('pellet').open('w') do |f|
        f.write <<-SH
#!/bin/sh

if [ -n "${JAVA_HOME}" -a -x "${JAVA_HOME}/bin/java" ]; then
  java="${JAVA_HOME}/bin/java"
else
  java=java
fi

if [ -z "${pellet_java_args}" ]; then
  pellet_java_args="-Xmx512m"
fi

exec ${java} ${pellet_java_args} -jar #{prefix.join('lib/pellet-cli.jar')} "$@"
        SH
      end
    end
  end

  def caveats
  end

end
