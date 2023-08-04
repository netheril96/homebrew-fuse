class Cryptopp < Formula
  desc "Free C++ class library of cryptographic schemes"
  homepage "http://www.cryptopp.com/"
  url "https://cryptopp.com/cryptopp880.zip"
  sha256 "ace1c7b010a409eba5e86c4fd5a8845c43a6ac39bb6110e64ca5d7fea08583f4"
  version "8.8.0"

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
