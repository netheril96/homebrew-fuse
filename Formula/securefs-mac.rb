require_relative "../require/macfuse"

class SecurefsMac < Formula
  desc "Filesystem with transparent authenticated encryption"
  homepage "https://github.com/netheril96/securefs"
  url "https://github.com/netheril96/securefs.git",
      tag:      "v1.1.1",
      revision: "c338d857cfbc51d9af3c6689ca84131314d4915e"
  license "MIT"
  head "https://github.com/netheril96/securefs.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "abseil"
  depends_on "argon2"
  depends_on "cryptopp"
  depends_on "doctest"
  depends_on "fruit"
  depends_on MacfuseRequirement
  depends_on :macos
  depends_on "protobuf"
  depends_on "sqlite"
  depends_on "tclap"
  depends_on "uni-algo"

  def install
    setup_fuse
    system "cmake", "-DSECUREFS_USE_VCPKG=OFF",
           "-DSECUREFS_ENABLE_INTEGRATION_TEST=OFF", ".", *fuse_cmake_args, *std_cmake_args
    system "make", "-j4"
    begin
      system "make", "test"
    rescue
      odie "maybe you need to install protobuf from source, i.e. run `brew install --build-from-source protobuf`."
    end
    system "make", "install"
  end

  test do
    system "#{bin}/securefs", "version" # The sandbox prevents a more thorough test
  end
end
