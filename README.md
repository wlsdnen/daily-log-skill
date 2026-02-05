# 📝 daily-log

> Automatically capture your daily work with intelligent activity detection

Never miss documenting your work again. `daily-log` automatically detects what you've been working on (experiments, features, bugs, learning) and generates structured daily logs with appropriate questions for each activity type.

## ✨ Features

- 🎯 **No setup required** - Works for anyone, any role
- 🔍 **Automatic activity detection** - Experiments, Features, Bug Fixes, Refactoring, Learning, Documentation, Testing
- 📝 **Never misses work** - Tracks last log timestamp, even with multi-day gaps
- 💡 **Activity-specific questions** - Each activity type gets relevant questions
- ✅ **Quality standards** - Enforces detailed answers (80+ words per item)
- 🚀 **Multi-source detection** - Git commits + uncommitted changes + untracked files

## 🚀 Quick Start

### Installation

**One-line install:**
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/daily-log-skill/main/install.sh | bash
```

**Or manual install:**
```bash
mkdir -p ~/.claude/skills/daily-log
curl -o ~/.claude/skills/daily-log/SKILL.md \
  https://raw.githubusercontent.com/YOUR_USERNAME/daily-log-skill/main/SKILL.md
```

**Or clone and install:**
```bash
git clone https://github.com/YOUR_USERNAME/daily-log-skill.git
cd daily-log-skill
./install.sh
```

### Usage

In your project directory:
```
"Create daily log"
```

The skill will:
1. Detect all changes since your last log (or 1 week for first use)
2. Identify activity types automatically
3. Generate dynamic sections based on what you actually did
4. Ask relevant questions for each activity
5. Create a comprehensive log in `./daily-notes/YYYY-MM-DD.md`

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

**Migration:** Just install v2.0 - it works automatically, no configuration needed.

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
- Git repository (optional but recommended)
- `jq` (for JSON parsing) - usually pre-installed

## 🤝 Contributing

Issues and PRs welcome! This is v2.0 - let me know if you find bugs or have feature requests.

## 📝 License

MIT License - see LICENSE file

## 🙏 Credits

Built with Claude Code's skill system. Tested extensively with 6 test scenarios achieving 100% pass rate.

---

**Version:** 2.0.0  
**Status:** Production Ready ✅  
**Last Updated:** 2026-02-05
