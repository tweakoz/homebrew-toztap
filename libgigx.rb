require "extend/pathname"
require "tmpdir"
require "install_renamed"

class Libgigx < Formula
  desc "library for Gigasampler and DLS (Downloadable Sounds) Level 1/2 files"
  homepage "https://www.linuxsampler.org/libgig/"
  #url "https://download.linuxsampler.org/packages/libgig-4.0.0.tar.bz2"
  url "https://github.com/tweakoz/LS-libgig.git"
  #sha256 "5f4db3fbc4effe1b85dd1a2ff791fd3fc418afa6a79cd497f9de5e5c25af28f3"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libsndfile"
  conflicts_with "libgig", :because => "they overlap"

  def install
    # parallel make does not work, fixed in next version (4.0.0)
    ENV.deparallelize
    # link with CoreFoundation, default in next version (4.0.0)
    #ENV.append "LDFLAGS", "-framework CoreFoundation"

    #base_name = `basename #{buildpath}`.delete!("\n")
    #build_base_dir = "#{buildpath}/../temp_build"
    #build_style = "Default"
    #build_dir="#{build_base_dir}/#{build_style}/#{base_name}.build"
    #tools_dir="#{build_dir}/src/tools"

    #ENV["PROJECT_DIR"]="./osx/"
    #system "./configure", "--disable-dependency-tracking",
    #                      "--disable-silent-rules",
    #                      "--prefix=#{prefix}"
    #system "make", "install"

    ENV["WITH_INSTALL"] = "1"
    ENV["CONFIG_OPTIONS"] = "--prefix=#{prefix}"

    system "sh ./osx/autoconf_builder.sh"

  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <gig.h>
      #include <iostream>
      using namespace std;

      int main()
      {
        cout << gig::libraryName() << endl;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lgig", "-o", "test"
    assert_match "libgig", shell_output("./test")
  end
end
