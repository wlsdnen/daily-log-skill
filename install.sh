#!/bin/bash
set -e

echo "📝 Installing daily-log skill v2.0..."
echo ""

# Check Claude directory exists
if [ ! -d ~/.claude ]; then
  echo "⚠️  Warning: ~/.claude directory not found"
  echo "   Make sure Claude Code is installed"
  read -p "   Continue anyway? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

# Create skill directory
mkdir -p ~/.claude/skills/daily-log

# Check if SKILL.md exists in current directory
if [ ! -f "SKILL.md" ]; then
  echo "⚠️  SKILL.md not found in current directory"
  echo "   Attempting to download from GitHub..."
  
  if command -v curl &> /dev/null; then
    curl -fsSL -o ~/.claude/skills/daily-log/SKILL.md \
      https://raw.githubusercontent.com/YOUR_USERNAME/daily-log-skill/main/SKILL.md
  elif command -v wget &> /dev/null; then
    wget -q -O ~/.claude/skills/daily-log/SKILL.md \
      https://raw.githubusercontent.com/YOUR_USERNAME/daily-log-skill/main/SKILL.md
  else
    echo "❌ Error: Neither curl nor wget found"
    echo "   Please install curl or wget, or run from cloned repository"
    exit 1
  fi
else
  # Copy from local
  cp SKILL.md ~/.claude/skills/daily-log/
fi

# Verify installation
if [ -f ~/.claude/skills/daily-log/SKILL.md ]; then
  echo "✅ daily-log skill installed successfully!"
  echo ""
  echo "📍 Location: ~/.claude/skills/daily-log/SKILL.md"
  echo ""
  echo "🚀 Usage:"
  echo "   1. Navigate to your project directory"
  echo "   2. Say: 'Create daily log'"
  echo ""
  echo "📖 Documentation:"
  echo "   - README: https://github.com/YOUR_USERNAME/daily-log-skill"
  echo "   - Migration Guide: MIGRATION-GUIDE.md"
  echo ""
  echo "💡 First use will capture last 7 days of work"
  echo "   Subsequent logs track since your last log"
else
  echo "❌ Installation failed"
  exit 1
fi
