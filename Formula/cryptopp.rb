class Cryptopp < Formula
  desc "Free C++ class library of cryptographic schemes"
  homepage "http://www.cryptopp.com/"
  url "https://cryptopp.com/cryptopp870.zip"
  sha256 "d0d3a28fcb5a1f6ed66b3adf57ecfaed234a7e194e42be465c2ba70c744538dd"
  version "8.7.0"

  def install
    ENV.cxx11 
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
    ENV.cxx11
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lcryptopp", "-o", "test"
    system "./test"
  end
end
