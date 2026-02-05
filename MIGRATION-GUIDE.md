# Migration Guide: v1.x to v2.0

## Overview

**Version 2.0** migrates from a static profile system to dynamic section detection. This change makes the skill more flexible and removes configuration burden from users.

**Good news**: If you're an existing user, there's nothing you need to do. The system automatically detects your work style.

---

## What's New in v2.1 (Language & Auto-Generation)

### New: Auto-Generation Mode

**v2.0 behavior**: Asked 5 questions per activity (What, How, Why, Effect, Issues)
**v2.1 behavior**: AI automatically generates all content by analyzing git commits, diffs, and code

No migration needed - just use it! If you want the old question-based mode, add `--interactive` flag.

### New: Automatic Language Detection

**How it works**:
- "Create daily log" → English log
- "오늘 작업 기록해줘" → Korean log (한국어)
- "今日の作業記録を作成" → Japanese log (日本語)

No configuration needed - language is detected from your request message.

---

## What Changed

### Removed: Profile System (v1.x)

In v1.x, you selected a profile during onboarding:
- **Researcher**: For experiments and hypothesis testing
- **Developer**: For features and bug fixes
- **Learner**: For learning and skill-building
- **Hybrid**: For mixed work

This required you to pick a category and commit to it.

### Added: Dynamic Section Detection (v2.0)

In v2.0, sections are detected automatically by analyzing:
- **Git commits**: What files changed?
- **File structure**: New code, tests, docs?
- **Keywords**: Are there experiments, bugs, features?
- **Recent activity**: What type of work is happening?

**Example**: If you modify code in `src/` and commit with "fix: bug in parser", the system detects a bug fix and surfaces a "Bug Fixes" section. If you also create a file in `experiments/`, it detects experiments and adds an "Experiments" section.

---

## What Stays the Same

- Daily log creation workflow
- Section-based organization
- Markdown format
- All existing logs remain readable
- Template questions and guidance

---

## For Existing Users

### Automatic Migration

When you first use v2.0:
1. System reads your old profile (if it exists)
2. Stores state in: `~/.claude/daily-log-state.json`
3. Detection runs automatically
4. Old profile file is left untouched (not deleted)

You can continue using the skill immediately. No manual steps required.

### Optional: Clean Up Old Profile

If you want to remove the old profile file:
```bash
rm ~/.claude/daily-log-profile.json
```

This is optional. The v2.0 system ignores the old profile file.

---

## State File Location

v2.0 uses a new state file instead of profiles:

```
~/.claude/daily-log-state.json
```

**What it stores**:
- Last detection results
- Section history
- Work type patterns
- Recent contexts

**Purpose**: Improves detection accuracy over time by remembering your work patterns.

**Privacy**: All local, never sent anywhere.

---

## Dynamic Detection Examples

### Example 1: Software Developer

**Your work**:
- Commit: "feat: add user authentication"
- Commit: "fix: race condition in cache"
- New file: `src/auth/login.ts`

**Detected sections**:
- Features
- Bug Fixes
- Implementation Details

### Example 2: Researcher

**Your work**:
- New directory: `experiments/hypothesis-1/`
- File: `analysis/results.md`
- Commit: "Add experiment results"

**Detected sections**:
- Experiments
- Analysis & Results
- Findings

### Example 3: Learner

**Your work**:
- New file: `notes/typescript-generics.md`
- Commit: "Learning TypeScript"
- New file: `tutorials/async-await.js`

**Detected sections**:
- Learning
- Concepts & Notes
- Practice Code

### Example 4: Mixed Work (Designer + Developer)

**Your work**:
- Files in `design/`: UI mockups
- Commit: "feat: implement login screen"
- Files in `src/`: React components
- File: `research/user-feedback.md`

**Detected sections**:
- Design Work
- Features
- User Research
- Implementation

---

## No Onboarding Profile Choice

v2.0 removes the profile selection from onboarding.

**Before (v1.x)**:
```
Agent: "Which profile matches you best?"
  1. Researcher
  2. Developer
  3. Learner
  4. Hybrid

User: "2"
```

**After (v2.0)**:
```
Agent: "I'll create your daily log."
[Automatically detects your work type]
```

---

## Troubleshooting

### "I miss the old profile system"

The dynamic system should cover the same work types. If it's not detecting your work correctly, the system learns over time as you use it.

You can also:
1. Use explicit markers in your code/commits:
   - `experiment/` directory for experiments
   - `test/`, `spec/` for testing
   - `doc/`, `notes/` for learning
   - `src/` for development

2. Use clear commit messages:
   - "feat:" for features
   - "fix:" for bugs
   - "test:" for testing
   - "docs:" for documentation

### "The sections don't match my work"

The system detects sections based on recent changes. If you work on multiple things:

1. **Different projects**: Create separate skill instances
2. **Same project, different work**: The system will show mixed sections
3. **Rare work types**: Manually add sections if needed

### "Where is my old profile?"

Your old profile file is untouched at:
```
~/.claude/daily-log-profile.json
```

It's no longer used, but you can reference it if needed.

---

## Benefits of Dynamic Detection

1. **Zero Configuration**: No profile choice, system figures it out
2. **Flexible**: Handles mixed work types naturally
3. **Accurate**: Based on actual code/files, not a guess
4. **Evolving**: Improves accuracy over time
5. **Universal**: Works for any type of work

---

## Technical Details

### Detection Logic (Simplified)

```
1. Analyze recent git commits
   → Detect commit types (feat, fix, docs, etc.)

2. Scan file structure
   → Look for test/, experiments/, docs/, notes/

3. Check recent modifications
   → What files changed in last 24 hours?

4. Match patterns
   → Map to standard section types

5. Store results
   → Save to state file for next time
```

### Section Types (v2.0)

- Features
- Bug Fixes
- Experiments
- Analysis & Results
- Learning
- Design Work
- Testing & QA
- Documentation
- Refactoring
- Performance
- Infrastructure
- Research

---

## Questions?

This is a new system. If you have feedback:

1. Does the dynamic detection work for your workflow?
2. Are you missing any section types?
3. Would you like more customization options?

Let us know and we can improve the detection.
