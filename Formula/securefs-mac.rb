require_relative "../require/macfuse"

class SecurefsMac < Formula
  desc "Filesystem with transparent authenticated encryption"
  homepage "https://github.com/netheril96/securefs"
  url "https://github.com/netheril96/securefs.git",
      tag:      "0.14.3",
      revision: "8345530d700a6ff73ef59c5074403dede9f9ce96"
  license "MIT"
  head "https://github.com/netheril96/securefs.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on MacfuseRequirement
  depends_on :macos
  depends_on "utf8proc"
  depends_on "cryptopp"
  depends_on "jsoncpp"
  depends_on "argon2"
  depends_on "abseil"
  depends_on "tclap"
  depends_on "doctest"

  def install
    setup_fuse
    system "cmake", "-DSECUREFS_USE_VCPKG=OFF", "-DSECUREFS_ENABLE_INTEGRATION_TEST=OFF", ".", *fuse_cmake_args, *std_cmake_args
    system "make"
    system "make", "test"
    system "make", "install"
  end

  test do
    system "#{bin}/securefs", "version" # The sandbox prevents a more thorough test
  end
end
