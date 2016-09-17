require 'formula'

class Csoundx < Formula
  homepage 'http://csound.github.io'
  url 'https://github.com/csound/csound/archive/6.07.0.tar.gz'
  sha256 '606af463da477cf4a3f89d00a4fda63c7eb0dc7f50a8923069f009dfdc545799'
  head 'https://github.com/csound/csound.git', :branch => 'develop'
  version '6.07.0'

  depends_on 'cmake' => :build
  depends_on 'swig' => :build

  depends_on 'libsndfile'

  depends_on 'portaudio' => :recommended
  depends_on 'portmidi' => :recommended
  depends_on 'liblo' => :recommended
  depends_on 'boost' => :recommended
  depends_on 'libpng' => :recommended
  depends_on 'stk' => :optional
  depends_on 'fltk' => :optional
  depends_on 'eigen' => :recommended

  option :universal

  option 'with-acpython', "build acpython interface"
  option 'with-aclua', "build aclua interface"

  def install
    framework = "#{prefix}/Framework"
    inreplace "CMakeLists.txt", "~/Library/Frameworks", framework
    stk = (build.with? "stk") ? 1 : 0
    acpython = (build.with? "acpython") ? 1 : 0
    aclua = (build.with? "aclua") ? 1 : 0
    system "cmake", ".", "-DUSE_GETTEXT=0", "-DBUILD_STK_OPCODES=#{stk}", "-D BUILD_CSOUND_AC_PYTHON_INTERFACE=#{acpython}", "-D BUILD_CSOUND_AC_LUA_INTERFACE=#{aclua}", "-DCMAKE_MACOSX_RPATH=ON", "-DCMAKE_INSTALL_RPATH=#{framework}", *std_cmake_args
    system "make", "install"
  end

  test do
    system "csound"
  end
end
