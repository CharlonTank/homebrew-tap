class ClaudeSleepPreventer < Formula
  desc "Keep your Mac awake while Claude Code is working"
  homepage "https://github.com/CharlonTank/claude-code-sleep-preventer"
  url "https://github.com/CharlonTank/claude-code-sleep-preventer/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2e6f9ef4eca05c6cd4f5fd5e28981eb84c6f1d8268bb714cc5d46676e316ac27"
  license "MIT"

  depends_on :macos

  def install
    # Install scripts to libexec
    libexec.install "hooks/prevent-sleep.sh"
    libexec.install "hooks/allow-sleep.sh"
    libexec.install "hooks/thermal-monitor.sh"
    libexec.install "swiftbar/claude-sleep-status.1s.sh"
    libexec.install "install.sh"
    libexec.install "uninstall.sh"

    # Create wrapper script
    (bin/"claude-sleep-preventer").write <<~EOS
      #!/bin/bash
      case "$1" in
        install)
          "#{libexec}/install.sh"
          ;;
        uninstall)
          "#{libexec}/uninstall.sh"
          ;;
        status)
          echo "PID files:"
          ls -la /tmp/claude_working_pids/ 2>/dev/null || echo "  (none)"
          echo ""
          echo "Sleep state:"
          pmset -g | grep -E "(SleepDisabled|sleep)"
          ;;
        *)
          echo "Claude Code Sleep Preventer"
          echo ""
          echo "Usage: claude-sleep-preventer <command>"
          echo ""
          echo "Commands:"
          echo "  install    - Set up hooks and SwiftBar plugin"
          echo "  uninstall  - Remove hooks and restore defaults"
          echo "  status     - Show current sleep prevention state"
          ;;
      esac
    EOS
  end

  def caveats
    <<~EOS
      To complete installation, run:
        claude-sleep-preventer install

      This will:
        - Install hooks to ~/.claude/hooks/
        - Configure passwordless sudo for pmset
        - Optionally install SwiftBar HUD

      After installation, restart Claude Code to activate.
    EOS
  end

  test do
    system "#{bin}/claude-sleep-preventer", "--help"
  end
end
