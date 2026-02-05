---
name: daily-log
description: Use when creating daily logs of work. Automatically detects activity types (experiments, features, bugs, learning) from git history and generates appropriate sections. Works for anyone - researchers, developers, learners, designers, etc. Triggers on "daily log", "create log", "log today's work".
---

# Daily Work Log

## Overview

**Core Principle**: Git commits capture only 10-30% of daily work. Most important work (experiments, in-progress changes, discoveries) is uncommitted. This skill ensures complete daily documentation by automatically detecting what you've been working on and generating appropriate sections.

**Critical**: NEVER rely on git log alone. Always check uncommitted changes first.

**How It Works**:
- Analyzes your git history and uncommitted changes
- Automatically detects activity types (experiments, features, bugs, refactoring, learning)
- Generates dynamic sections based on what you actually did
- Never misses work by tracking last log timestamp
- Works for anyone - no profile setup needed

## When to Use

- End of day: "Create daily log"
- Before context switching to new task
- Weekly review preparation
- When git commits don't tell the full story
- Before team standups or reviews

## State Tracking System

**State File**: `~/.claude/daily-log-state.json`

Schema:
```json
{
  "lastLogDate": "2026-02-05T18:30:00Z",
  "logDirectory": "./daily-notes/"
}
```

**First Use**: If no state file exists, defaults to 1-week lookback to ensure nothing is missed.

**After Each Log**: Updates lastLogDate to current timestamp, so next log captures exactly the work since the last one.

## Core Workflow

### Step 1: Load Last Log Timestamp

```bash
STATE_FILE="$HOME/.claude/daily-log-state.json"

if [ -f "$STATE_FILE" ]; then
  LAST_LOG=$(cat "$STATE_FILE" | jq -r '.lastLogDate')
  LOG_DIR=$(cat "$STATE_FILE" | jq -r '.logDirectory')
else
  # First use - default to 1 week lookback
  LAST_LOG=$(date -u -v-7d +%Y-%m-%dT%H:%M:%SZ)
  LOG_DIR="./daily-notes/"
fi
```

### Step 2: Multi-Source Change Detection

Execute ALL of these (not just git log):

```bash
# 1. Git commits since last log
git log --oneline --since="$LAST_LOG"

# 2. Uncommitted changes (CRITICAL - Don't skip!)
git status

# 3. Staged changes
git diff --cached

# 4. Unstaged changes
git diff

# 5. Untracked files
git ls-files --others --exclude-standard

# 6. Modified files by time (fallback if no git)
find . -type f -newermt "$LAST_LOG" ! -path "*/\.*" | head -20

# 7. Search for issue references
git log --since="$LAST_LOG" --grep="#[0-9]" --oneline
git diff --name-only | xargs grep -n "TODO\|FIXME\|XXX\|HACK\|BUG" 2>/dev/null
```

**RED FLAG**: If you only ran git log, STOP. You're missing 90% of work.

### Step 3: Dynamic Activity Detection

Analyze ALL detected changes and identify activity types:

| Activity | Detection Pattern | Section to Create |
|----------|------------------|-------------------|
| **Experiments** | `experiment*.*, hypothesis, results` keywords, `experiments/` path, test harnesses, data files | "Experiments" |
| **Features** | `feat:, add:, implement` commits, new files, new functions/classes | "Features" |
| **Bug Fixes** | `fix:, bug:, issue` commits, error handling code, validation | "Bug Fixes" |
| **Refactoring** | `refactor:, clean` commits, file moves, restructuring | "Refactoring" |
| **Learning** | `tutorial/, notes/, learning/` paths, `.md` files, example code | "Learning" |
| **Documentation** | `docs/, README, *.md` files, comments | "Documentation" |
| **Testing** | `test/, spec/, *.test.*` files, test utilities | "Testing" |

**Key Rule**: Only create sections for activities that were actually detected. Don't create empty sections.

### Step 4: Group Related Changes

Cluster files by context:
- Same feature or experiment
- Related functionality
- Same research question
- Same bug or issue

### Step 5: Generate Activity-Specific Questions

Questions adapt to the detected activity type. Always ask at least 3 specific questions per activity group.

#### For Experiments:
- **Hypothesis**: What were you trying to discover or test?
- **Method**: How did you approach it?
- **Results**: What did you find? (Include failures!)
- **Learnings**: What did you learn that you didn't expect?
- **Next**: What's the next experiment or step?

#### For Features:
- **What**: What feature or capability was added?
- **How**: What implementation approach did you choose?
- **Why**: Why this approach over alternatives? (At least 1 alternative)
- **Effect**: What measurable impact does it have? (Metrics, user benefit)
- **Issues**: What issues did you resolve or discover?

#### For Bug Fixes:
- **Problem**: What was the bug? How was it discovered?
- **Root Cause**: What was the underlying cause?
- **Solution**: How did you fix it?
- **Prevention**: How did you prevent recurrence?
- **Verification**: How did you verify the fix works?

#### For Refactoring:
- **Reason**: What problem were you solving?
- **Changes**: What did you change?
- **Improvements**: How did code quality improve?
- **Metrics**: What metrics improved? (Complexity, performance, maintainability)

#### For Learning:
- **Topic**: What concept or skill were you learning?
- **Difficulty**: What was difficult to understand?
- **Breakthrough**: What made it click for you?
- **Application**: How will you use this knowledge?

#### For Documentation:
- **Purpose**: Why was this documentation needed?
- **Audience**: Who is the target audience?
- **Improvements**: What gaps does this fill?

#### For Testing:
- **Coverage**: What areas did you test?
- **Findings**: What issues did you discover?
- **Issues**: What's still untested or problematic?

#### Universal Questions (Always Ask):
- **"Why"**: Why this approach? (Require detailed answer with alternatives)
- **"Effect"**: What was the measurable effect? (Require specifics: metrics, percentages, user impact)

**NEVER skip "why" and "effect" questions** - these are most valuable for future review.

### Step 6: Handle Perfunctory Answers

**RED FLAG ANSWERS** (Must dig deeper):
- "Because it's good"
- "Because it's fast"
- "Because it's easy"
- "Just because"
- One-word answers: "Yes", "No", "Done"

**When you get perfunctory answer**:
1. Acknowledge: "I understand"
2. Follow-up with specific probe:
   - "In what way is it [good/fast/easy]?"
   - "How does it compare to other approaches?"
   - "What specific advantage or metrics?"
   - "Were there any disadvantages or tradeoffs?"
3. If still perfunctory, one more try:
   - "When you review this decision in 6 months, what information would help you evaluate it?"

**Minimum acceptable answer**:
- At least 2 sentences
- Specific reason (not generic "good")
- OR quantitative data (numbers, metrics)
- OR comparison with alternative

**Examples**:

UNACCEPTABLE:
- Why: Because it's good
- Effect: Made it faster

ACCEPTABLE:
- Why: Redis allows sharing across multiple servers, while in-memory cache is per-instance. Considered Memcached but Redis has richer data structures we need.
- Effect: Response time 200ms to 50ms (75% reduction), DB queries reduced 70%

### Step 7: Generate Dynamic Log Structure

Create sections ONLY for detected activities. Save to: `./daily-notes/YYYY-MM-DD.md`

```markdown
# YYYY-MM-DD Daily Log

_Period: YYYY-MM-DD HH:MM ~ YYYY-MM-DD HH:MM (X days/hours since last log)_

## [Activity Type 1] (detected from: commit messages, file paths, code patterns)

### [Specific Item Name]
- **[Question 1]**: Answer
- **[Question 2]**: Answer
- **[Question 3]**: Answer
- **Files**: List of related files

### [Another Item]
...

## [Activity Type 2] (detected from: ...)

### [Item Name]
...

## Files Modified

- `path/to/file.ts` - Brief description
- `path/to/file2.py` - Brief description

---
**Last Updated**: YYYY-MM-DD HH:MM:SS
**Time Period Covered**: X days/hours since last log
```

### Step 8: Update State File

After log creation, update the state file:

```bash
STATE_FILE="$HOME/.claude/daily-log-state.json"
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
LOG_DIR="./daily-notes/"

echo "{\"lastLogDate\": \"$NOW\", \"logDirectory\": \"$LOG_DIR\"}" > "$STATE_FILE"
```

## Example Dynamic Log

```markdown
# 2026-02-05 Daily Log

_Period: 2026-02-03 09:00 ~ 2026-02-05 18:30 (2 days, 9 hours since last log)_

## Experiments (detected from: experiments/ directory, test files, "benchmark" in commits)

### Algorithm Optimization Performance Test
- **Hypothesis**: What were you testing?
  Switching from map() to for-loop would improve performance by 20%+
- **Method**: How did you test it?
  Benchmarked with 10k item arrays, measured execution time over 1000 runs
- **Results**: What did you find?
  30% improvement (200ms → 140ms), plus memory usage decreased 15%
- **Learnings**: What surprised you?
  Early return for empty arrays had bigger impact than expected (10% gain)
- **Next**: What's next?
  Test with 100k+ items, profile memory allocation patterns
- **Files**: experiments/optimization.ts, experiments/benchmark.ts

## Features (detected from: "feat:" commits, new API files)

### User Authentication Endpoint
- **What**: What was built?
  Added POST /api/auth/login endpoint with JWT token generation
- **How**: What implementation approach?
  Used bcrypt for password hashing, JWT with 24hr expiry, Redis for session storage
- **Why**: Why this approach over alternatives?
  Considered session cookies but JWT allows stateless scaling. Redis chosen over in-memory for multi-instance support. Bcrypt over SHA for password security (slower = harder to crack).
- **Effect**: What's the measurable impact?
  Users can now authenticate, supports 10k concurrent sessions (load tested)
- **Issues**: What issues were found?
  RESOLVED: #234 - Rate limiting on failed logins (5 attempts = 15min lockout)
  DISCOVERED: Need password reset flow (not yet implemented)
- **Files**: src/api/auth.ts, src/middleware/jwt.ts

## Bug Fixes (detected from: "fix:" commits, error handling patterns)

### Memory Leak in WebSocket Handler
- **Problem**: How was it discovered?
  Production monitoring showed memory climbing to 8GB over 2 hours, crashing server
- **Root Cause**: What caused it?
  WebSocket connections not properly cleaned up on disconnect, event listeners accumulated
- **Solution**: How was it fixed?
  Added explicit cleanup in disconnect handler, moved to WeakMap for connection tracking
- **Prevention**: How prevent recurrence?
  Added integration test for connection lifecycle, memory profiling in CI
- **Verification**: How verified?
  Load test with 1000 connect/disconnect cycles - memory stable at 200MB
- **Files**: src/websocket/handler.ts, tests/integration/websocket.test.ts

## Learning (detected from: notes/ directory, .md files, tutorial code)

### React Server Components Deep Dive
- **Topic**: What were you learning?
  How React Server Components work, especially data fetching patterns
- **Difficulty**: What was hard to understand?
  The mental model shift from client-side rendering - when does code run where?
- **Breakthrough**: What made it click?
  Building a simple example helped - seeing the network waterfall in DevTools
- **Application**: How will you use this?
  Refactor dashboard to use RSC, eliminate client-side loading states
- **Files**: notes/react-rsc.md, examples/rsc-demo/

## Files Modified

- `experiments/optimization.ts` - Performance benchmark for loop vs map
- `experiments/benchmark.ts` - Test harness for algorithm comparison
- `src/api/auth.ts` - New authentication endpoint with JWT
- `src/middleware/jwt.ts` - JWT token generation and validation
- `src/websocket/handler.ts` - Fixed memory leak in connection cleanup
- `tests/integration/websocket.test.ts` - Added connection lifecycle test
- `notes/react-rsc.md` - Learning notes on React Server Components
- `examples/rsc-demo/` - Practice code for RSC patterns

---
**Last Updated**: 2026-02-05 18:30:00
**Time Period Covered**: 2 days, 9 hours (2026-02-03 09:00 ~ 2026-02-05 18:30)
```

## Quality Standards

**CRITICAL**: Daily logs must be detailed enough for others to understand quickly.

### Minimum Content Requirements

**Per Item** (minimum 80-100 words):
- Context: 2-3 sentences explaining what and why
- Details: Specific implementation or approach
- Rationale: Why this way? (Must include alternatives considered)
- Impact: Quantitative (metrics) or qualitative (user/code benefit)
- Minimum 3 activity-specific questions answered

### Red Flags (Too Short - Unacceptable)

UNACCEPTABLE (too short):
```markdown
### Performance improvement
- What: Code optimization
- How: Refactoring
- Why: It was slow
- Effect: Made it faster
```
Only ~20 words, zero context.

ACCEPTABLE (minimum):
```markdown
### processData Performance Optimization
- **What**: Converted map()-based processing to for loop with early return for empty arrays
- **How**: Direct for loop implementation removes map overhead, integrated empty string filtering
- **Why**: Benchmarking identified map() as bottleneck. Considered reduce() but readability suffered. For loop maintains readability while improving performance. Early return for empty arrays handles edge case while boosting performance.
- **Effect**: Benchmark improved 30% (200ms → 140ms). Empty string filtering improved downstream processing by 10%.
- **Files**: src/processors/data.ts
```
~110 words, rich context for future review.

### Readability Guidelines

**Structure for quick scanning**:
- Use bullet points (not paragraphs)
- Bold key terms: **2x faster**, **memory issue**
- Use numbers: "30% improvement", "10k items"
- Use status markers: RESOLVED, DISCOVERED, IN PROGRESS, FAILED

**Write for audience**:
- Assume reader has NO context
- Explain acronyms on first use
- Link related work: "Builds on previous experiment"
- Highlight surprises: "Unexpectedly, ..."

**Balance detail and brevity**:
- Not too short: No one-liners
- Not too long: No 500-word essays per item
- Sweet spot: 80-150 words per item

## Quick Mode (Time Pressure)

When user says "quick", "fast", "urgent", "before meeting", activate quick mode:

1. **Still check all sources** (don't skip uncommitted!)
2. **Minimal questions** - one line per activity group:
   - "Experiments: What were you testing?"
   - "Features: What did you build?"
3. **Add DRAFT flag**:
   ```markdown
   # YYYY-MM-DD Daily Log [DRAFT - Quick Mode]

   > WARNING: Generated in quick mode - needs expansion
   > Run this skill again to expand, or edit manually

   ## Needs Expansion
   - [ ] Add "why" rationale to all items
   - [ ] Add "effect" measurements
   - [ ] Expand activity details
   - [ ] Add issue references
   ```
4. **Structure maintained** (dynamic sections still created)

**CRITICAL**: Quick mode saves time on questions, NOT on change detection. Always check uncommitted changes.

## Common Mistakes

| Mistake | Reality | Fix |
|---------|---------|-----|
| "Only checked git log" | 90% work uncommitted | Check git status first |
| "No commits, nothing to log" | Uncommitted work exists | Check working directory |
| "Skipped 'why' questions" | Most valuable for review | Mandatory question |
| "Skipped failed experiments" | Failures teach most | Always document failures |
| "No issue tracking" | Lost context | Search + ask about issues |
| "Quick = skip uncommitted" | Misses most work | Quick = fewer questions only |
| "Just list file names" | No context captured | Always ask for context |
| "Used wrong activity type" | Hard to find later | Let detection be automatic |

## Red Flags - STOP if you think:

- "Git log shows 2 commits, done" → Check uncommitted changes
- "No time for questions" → Quick mode still asks minimum questions
- "Failed experiment, skip it" → Document failure (most valuable)
- "Just 'what' and 'how' is enough" → Require "why" and "effect"
- "One-word answer is fine" → Dig deeper with follow-up questions
- "Create all standard sections" → Only create sections for detected activities

## Storage Location

Default: `./daily-notes/YYYY-MM-DD.md` (project-local)

The state file tracks your log directory, so you can use different directories per project.

Optional: Link to global index for cross-project search:
```bash
ln -s "$(pwd)/daily-notes" ~/.claude/daily-notes/$(basename $(pwd))
```

## Why This Matters

**Without this skill**: Agent checks git log, misses 90% of work, draws wrong conclusions.

**With this skill**: Complete picture captured, context preserved, decisions documented for future reference.

**Future you** will thank present you for:
- "Why" rationale (when reconsidering decisions)
- Failed experiments (avoid repeating mistakes)
- Effect measurements (evaluate success)
- Issue context (solve similar problems faster)
- Activity-specific insights (understand what you were doing)
- Never missing work (state tracking ensures continuity)
