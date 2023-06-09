require_relative "../require/macfuse"

class SecurefsMac < Formula
  desc "Filesystem with transparent authenticated encryption"
  homepage "https://github.com/netheril96/securefs"
  url "https://github.com/netheril96/securefs.git",
      tag:      "0.13.1",
      revision: "bb7088e3fe43cd5978ec6b09b4cd9615a4ab654c"
  license "MIT"
  head "https://github.com/netheril96/securefs.git"

  depends_on "cmake" => :build
  depends_on MacfuseRequirement
  depends_on :macos
  depends_on "utf8proc"
  depends_on "cryptopp"
  depends_on "jsoncpp"
  depends_on "argon2"
  depends_on "abseil"
  depends_on "tclap"
  depends_on "catch2"

  def install
    setup_fuse
    system "cmake", ".", *fuse_cmake_args, *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/securefs", "version" # The sandbox prevents a more thorough test
  end
end
