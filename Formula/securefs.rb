require_relative "../require/macfuse"

class Securefs < Formula
  desc "Filesystem with transparent authenticated encryption"
  homepage "https://github.com/netheril96/securefs"
  url "https://github.com/netheril96/securefs.git",
      tag:      "0.12.0",
      revision: "a4972834d93e89117e67dae58998f10f8a7c0fbb"
  license "MIT"
  head "https://github.com/netheril96/securefs.git"

  depends_on "cmake" => :build
  depends_on MacfuseRequirement
  depends_on :macos

  def install
    setup_fuse
    system "cmake", ".", *fuse_cmake_args, *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/securefs", "version" # The sandbox prevents a more thorough test
  end
end
