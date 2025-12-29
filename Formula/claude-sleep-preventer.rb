class ClaudeSleepPreventer < Formula
  desc "Keep your Mac awake while Claude Code is working"
  homepage "https://github.com/CharlonTank/claude-code-sleep-preventer"
  url "https://github.com/CharlonTank/claude-code-sleep-preventer/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "f5de93167c9f8f243184df832fec71020b387a9eefd853384b93b16dea20f55e"
  license "MIT"

  depends_on :macos
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      To complete installation, run:
        claude-sleep-preventer install

      After installation, restart Claude Code to activate.

      Commands:
        claude-sleep-preventer status   - Show current state
        claude-sleep-preventer cleanup  - Clean up stale PIDs
        claude-sleep-preventer daemon   - Run cleanup daemon
    EOS
  end

  test do
    assert_match "Claude Code Sleep Preventer", shell_output("#{bin}/claude-sleep-preventer --help")
  end
end
