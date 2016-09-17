require 'formula'

class Rtmidi < Formula
  homepage 'http://www.music.mcgill.ca/~gary/rtmidi'
  url 'http://www.music.mcgill.ca/~gary/rtmidi/release/rtmidi-2.0.1.tar.gz'
  sha256 'b5017a91df0c2bc4c0d5c6548ac5f9696c5bc0c202f6bec704563c6f6bec64ec'

  def install
    ENV.j1
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    #lib.install %w{ librtmidi.2.0.0.dylib, librtmidi.a, librtmidi.dylib  }
    lib.install Dir['librtmidi*']
    include.install Dir['*.h']
  end

#  test do
#    system "false"
#  end
end
