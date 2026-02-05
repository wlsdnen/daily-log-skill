# Changelog

All notable changes to the daily-log skill will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2026-02-05

### Added
- **Auto-Generation Mode** - AI automatically generates comprehensive logs by analyzing git commits, diffs, and code (no questions asked)
- **Automatic Language Detection** - Detects language from user request and generates entire log in that language
  - Supported languages: English, Korean (한국어), Japanese (日本語)
- **Interactive Mode Fallback** - `--interactive` flag for users who prefer answering questions manually
- **Cross-Platform Date Support** - Works on both macOS and Linux
- **Error Handling** - Graceful degradation when jq is missing or not in git repository
- **Windows Support Guide** - Comprehensive installation instructions for Git Bash and WSL
- **Korean README** - Complete Korean translation of documentation

### Changed
- Default behavior changed from interactive questioning to automatic generation
- Quality standards now enforced during auto-generation (80-100 words per section)
- Language detection uses expanded Japanese character set (hiragana + katakana + kanji)

### Fixed
- macOS-only date command now works on Linux
- Japanese language detection now includes all Japanese scripts
- jq dependency no longer causes silent failures
- Non-git directories now handled gracefully with find fallback
- Useless Use of Cat (UUOC) eliminated for efficiency

## [2.0.0] - 2026-02-02

### Added
- **Dynamic Activity Detection** - Automatically detects 7 activity types:
  - Experiments, Features, Bug Fixes, Refactoring, Learning, Documentation, Testing
- **State Tracking System** - Never misses work even with multi-day gaps
- **Multi-Source Detection** - Analyzes 7 sources: git log, uncommitted changes, staged, unstaged, untracked files, timestamps, TODOs
- **Activity-Specific Questions** - Each activity type gets relevant question templates
- **Quality Standards Enforcement** - Minimum 80-word requirement with follow-up for perfunctory answers

### Changed
- **BREAKING**: Removed profile system (Researcher/Developer/Learner/Hybrid)
- Simplified to universal approach that works for anyone without configuration

### Removed
- Profile selection requirement
- Onboarding process
- Profile-specific templates

## [1.0.0] - Initial Release

### Added
- Profile-based daily logging system
- Four profile types: Researcher, Developer, Learner, Hybrid
- Git commit analysis
- Manual question-answer workflow

---

[2.1.0]: https://github.com/jwcho/daily-log-skill/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/jwcho/daily-log-skill/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/jwcho/daily-log-skill/releases/tag/v1.0.0
