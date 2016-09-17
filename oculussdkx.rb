class Oculussdkx < Formula
  desc "OculusSDK (modified)"
  homepage "http://oculusvr.com"
  url "https://static.oculus.com/sdk-downloads/ovr_sdk_macos_0.5.0.1.tar.gz"
  sha256 "58636983f970467afd18594899c22e70aae923023cd282b913c7c76ae46a8a12"

  version "X"

  def install
    #prefix.install Dir["share/doc/openimageio/*"]

      system "rm", "-rf", "/usr/local/Cellar/oculussdkx/X/include" 
      system "rm", "-rf", "/usr/local/Cellar/oculussdkx/X/Frameworks" 
      system "mkdir", "-p", "/usr/local/Cellar/oculussdkx/X/include" 
      system "mkdir", "-p", "/usr/local/Cellar/oculussdkx/X/Frameworks" 
      system "cp", "-r", "LibOVR/Include", "/usr/local/Cellar/oculussdkx/X/include/OVR" 
      system "ditto", "./LibOVR/Lib/Mac/Release/LibOVR.framework", "/usr/local/Frameworks/LibOVR.framework" 
  end
    #system "cp", "-r", "." 
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

