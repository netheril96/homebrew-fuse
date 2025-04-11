class Cryptopp < Formula
  desc "Free C++ class library of cryptographic schemes"
  homepage "http://www.cryptopp.com/"
  url "https://www.cryptopp.com/cryptopp890.zip"
  sha256 "4cc0ccc324625b80b695fcd3dee63a66f1a460d3e51b71640cdbfc4cd1a3779c"
  version "8.9.0"

  def install
    ENV.append "CXXFLAGS", "-std=gnu++17"
    system "make", "lean", "CXX=#{ENV.cxx}"
    system "make", "test"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <cryptopp/sha.h>
      #include <string>
      using namespace CryptoPP;
      using namespace std;

      int main()
      {
        byte digest[SHA::DIGESTSIZE];
        string data = "Hello World!";
        SHA().CalculateDigest(digest, (byte*) data.c_str(), data.length());
        return 0;
      }
    EOS
    ENV.append "CXXFLAGS", "-std=gnu++17"
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lcryptopp", "-o", "test"
    system "./test"
  end
end
