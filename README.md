[English](README.md) | [한국어](README.ko.md)

---

# 📝 daily-log

> Automatically capture your daily work with intelligent activity detection

Never miss documenting your work again. `daily-log` automatically detects what you've been working on (experiments, features, bugs, learning) and generates structured daily logs with appropriate questions for each activity type.

## ✨ What's New in v2.1

- 🤖 **Auto-Generation Mode** - No more questions! AI automatically generates detailed logs by analyzing your git commits, diffs, and code
- 🌍 **Automatic Language Detection** - Write in your language, get logs in your language (English, Korean, Japanese)
- ⚡ **Interactive Mode** - Add `--interactive` flag when you want to answer questions manually

## ✨ Features

- 🎯 **No setup required** - Works for anyone, any role
- 🔍 **Automatic activity detection** - Experiments, Features, Bug Fixes, Refactoring, Learning, Documentation, Testing
- 🤖 **Auto-generation** - AI analyzes code and generates comprehensive logs (no questions!)
- 🌍 **Multi-language** - Automatic language detection from your request
- 📝 **Never misses work** - Tracks last log timestamp, even with multi-day gaps
- 💡 **Activity-specific questions** - Each activity type gets relevant questions (in interactive mode)
- ✅ **Quality standards** - Enforces detailed answers (80+ words per item)
- 🚀 **Multi-source detection** - Git commits + uncommitted changes + untracked files

## 🚀 Quick Start

### Installation

**One-line install:**
```bash
curl -fsSL https://raw.githubusercontent.com/jwcho/daily-log-skill/main/install.sh | bash
```

**Or manual install:**
```bash
mkdir -p ~/.claude/skills/daily-log
curl -o ~/.claude/skills/daily-log/SKILL.md \
  https://raw.githubusercontent.com/jwcho/daily-log-skill/main/SKILL.md
```

**Or clone and install:**
```bash
git clone https://github.com/jwcho/daily-log-skill.git
cd daily-log-skill
./install.sh
```

### Windows Users

**Recommended**: Use Git Bash (comes with Git for Windows)

```bash
# 1. Install Git for Windows (if not already installed)
# Download from: https://git-scm.com/download/win

# 2. Open Git Bash and run the installation command
curl -fsSL https://raw.githubusercontent.com/jwcho/daily-log-skill/main/install.sh | bash

# 3. (Optional) Install jq for better performance
# Download from: https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe
# Place in: C:\Program Files\Git\usr\bin\jq.exe
```

**Alternative**: Use WSL (Windows Subsystem for Linux)
- Install WSL: `wsl --install` in PowerShell (admin)
- Follow Linux installation steps inside WSL

**Note**: The skill uses bash scripts and works in Git Bash or WSL. Native PowerShell/CMD is not supported.

### Usage

In your project directory:
```
"Create daily log"           # Auto-generates in English
"오늘 작업 기록해줘"         # Auto-generates in Korean
"Create daily log --interactive"  # Ask questions mode
```

The skill will:
1. Detect your language from the request
2. Analyze all changes since your last log
3. **Automatically generate** comprehensive answers by reading commits and code
4. Create a log in `./daily-notes/YYYY-MM-DD.md`

## 📖 Example Output

```markdown
# 2026-02-05 Daily Log
_Period: 2026-02-03 09:00 ~ 2026-02-05 18:30 (2 days)_

## Experiments (detected from: src/experiment.ts)
### Parallel Processing Performance Test
- **Hypothesis**: Testing if chunked parallel processing achieves 2x+ improvement
- **Method**: Implemented parallelProcess() with 100-item chunks using Promise.all
- **Results**: 2x improvement for 10k items (400ms → 200ms), but memory spikes at 100k items
- **Learnings**: Promise.all is concurrent, not parallel. Need Worker threads for true parallelism
- **Next**: Implement Worker thread pool with configurable max concurrency

## Bug Fixes (detected from: fix: typo commit)
### Documentation Typo Fix
- **Problem**: Incorrect method name in API documentation
- **Root Cause**: Copy-paste error from old version
- **Solution**: Updated all references to correct method name
- **Prevention**: Added documentation review checklist
- **Verification**: Built docs, checked all links
```

See [full example](examples/sample-log.md) for complete output.

## 🎯 Why daily-log?

### The Problem
- Git commits capture only 10-30% of daily work
- Most important work (experiments, in-progress changes) is uncommitted
- Manual logging is tedious and easy to forget
- Different roles need different documentation styles

### The Solution
- **Automatic detection** - Analyzes git history, file changes, and commit messages
- **Dynamic sections** - Only creates sections for activities you actually did
- **Smart questions** - Asks relevant questions based on activity type
- **Never misses work** - State tracking ensures continuity even with gaps

## 📚 Documentation

- [Migration Guide](MIGRATION-GUIDE.md) - Upgrading from v1.x (profile-based)
- [Example Log](examples/sample-log.md) - See what generated logs look like
- [SKILL.md](SKILL.md) - Complete skill documentation

## 🔄 What's New in v2.0

**Breaking changes from v1.x:**
- ✅ Removed profile system (Researcher/Developer/Learner/Hybrid)
- ✅ Added dynamic activity detection
- ✅ Added state tracking for continuity
- ✅ Now works for anyone without setup

**Migration:** Just install v2.1 - it works automatically, no configuration needed.

## 🛠️ How It Works

1. **State Tracking** - Remembers last log timestamp in `~/.claude/daily-log-state.json`
2. **Multi-Source Detection** - Checks git log, staged/unstaged changes, untracked files (7 sources)
3. **Activity Classification** - Matches changes against patterns (experiments/, feat:, fix:, etc.)
4. **Dynamic Generation** - Creates sections only for detected activities
5. **Quality Enforcement** - Ensures detailed answers with follow-up questions

## 🧪 Activity Types Detected

| Activity | Detection Pattern | Questions Asked |
|----------|------------------|-----------------|
| **Experiments** | `experiment*.*, experiments/` paths | Hypothesis, Method, Results, Learnings, Next |
| **Features** | `feat:, add:` commits, new files | What, How, Why (alternatives), Effect, Issues |
| **Bug Fixes** | `fix:, bug:` commits | Problem, Root Cause, Solution, Prevention, Verification |
| **Refactoring** | `refactor:, clean` commits | Reason, Changes, Improvements, Metrics |
| **Learning** | `notes/, tutorials/` paths, `.md` files | Topic, Difficulty, Breakthrough, Application |
| **Documentation** | `docs/, README` files | Purpose, Audience, Improvements |
| **Testing** | `test/, *.test.*` files | Coverage, Findings, Issues |

## 🎓 Quality Standards

- Minimum 80-100 words per item
- Specific details (not generic "good"/"fast")
- Quantitative metrics when possible
- Alternatives considered
- Context for future review

**The skill enforces these standards** with follow-up questions if answers are too brief.

## 💻 Requirements

- Claude Code CLI
- **Git Bash** (Windows), **bash** (macOS/Linux), or **WSL**
- Git repository (optional but recommended)
- `jq` (for JSON parsing) - optional, skill has fallback if missing

### Platform-Specific Notes

- **macOS/Linux**: Works out of the box
- **Windows**: Requires Git Bash (included with [Git for Windows](https://git-scm.com/download/win)) or WSL
- **jq installation**: Optional but recommended for better performance
  - macOS: `brew install jq`
  - Linux: `apt install jq` or `yum install jq`
  - Windows (Git Bash): Download from [jq releases](https://github.com/stedolan/jq/releases)

## 🤝 Contributing

Issues and PRs welcome! This is v2.1 - let me know if you find bugs or have feature requests.

## 📝 License

MIT License - see LICENSE file

## 🙏 Credits

Built with Claude Code's skill system. Tested extensively with 6 test scenarios achieving 100% pass rate.

---

**Version:** 2.1.0
**Status:** Production Ready ✅
**Last Updated:** 2026-02-05
