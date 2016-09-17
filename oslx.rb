# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Oslx < Formula
  desc "Open Shading Language"
  homepage ""
  url "https://github.com/imageworks/OpenShadingLanguage.git" #, :revision => "e9b5e2fdb18c0b70379671e254badc73a42db336"

  depends_on "cmake" => :build
  depends_on "homebrew/versions/llvm35"
  depends_on "opencolorio"
  depends_on "openimageiox"
  depends_on "partio"

  #depends_on :x11 # if your formula requires any X11/XQuartz components

  version "X"

  fails_with :gcc
  fails_with :llvm
  
  def install
    mkdir "build" do
    # ENV.deparallelize  # if your formula fails when building in parallel
      ENV['CC'] = '/usr/local/bin/clang-3.5'
      ENV['LD'] = '/usr/local/bin/clang++-3.5'
      ENV['CXX'] = '/usr/local/bin/clang++-3.5'
      ENV["VERBOSE"] = "1"
      ENV["OPENIMAGEIOHOME"] = "/usr/local/"
      ENV["LLVM_CONFIG_PATH"]="/usr/local/Cellar/llvm/3.5/bin/llvm-config"
      ENV["CXXFLAGS"]="-I/usr/local/Cellar/flex/2.6.0/include/"

      system "cmake", 
             "-G", "Unix Makefiles",
             "-DLLVM_CUSTOM=1",
             "-DBUILD_WITH_INSTALL_RPATH=1",
             "-DUSE_SIMD=sse4.1",
             "-DLLVM_DIRECTORY=/usr/local/Cellar/llvm35/3.5.1/lib/llvm-3.5",
             "-DUSE_CPP11=1",
             "-DOSL_BUILD_CPP11=1",
             "-DOSL_BUILD_LIBCPLUSPLUS=1",
             "-DVERBOSE=1",
             "-DEXTRA_OSLEXEC_LIBRARIES=curses",
             #{}"-DUSE_fPIC=1",
             "..", *std_cmake_args
      system "make" # if this fails, try separate make/make install steps
      system "make install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test oslx`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
