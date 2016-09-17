require 'formula'

class Csoundaccelerate < Formula
    homepage ''
    url 'https://github.com/eddyc/CsoundAccelerate/archive/v0.001.tar.gz'
    head 'https://github.com/eddyc/CsoundAccelerate.git'
    version '0.001'
    sha256 '3b14f81cc13f218b73919c504284012e49e5f5235d7592dc0def6c3fbbcdccc1'
    
    depends_on 'hdf5'
    depends_on 'Csound'
    
    def install
        
        system "xcodebuild -configuration Release ONLY_ACTIVE_ARCH=YES"
    end
end
