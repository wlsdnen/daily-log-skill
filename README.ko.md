[English](README.md) | [한국어](README.ko.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai/code)
![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)
[![Version](https://img.shields.io/badge/Version-2.1.0-green.svg)](CHANGELOG.md)

---

# 📝 daily-log

> 자동으로 당신의 일일 작업을 지능적인 활동 감지로 캡처합니다

다시는 작업 문서화를 놓치지 마세요. `daily-log`는 여러분이 무엇을 작업했는지(실험, 기능, 버그, 학습) 자동으로 감지하고 각 활동 유형에 적합한 구조화된 일일 로그를 생성합니다.

## ✨ v2.1의 새로운 기능

- 🤖 **자동 생성 모드** - 더 이상 질문 없음! AI가 git 커밋, diff, 코드를 분석하여 자동으로 상세한 로그 생성
- 🌍 **자동 언어 감지** - 당신의 언어로 작성하면, 당신의 언어로 로그 생성 (영어, 한국어, 일본어)
- ⚡ **대화형 모드** - 직접 질문에 답하고 싶을 때 `--interactive` 플래그 추가

## ✨ 기능

- 🎯 **설정 불필요** - 누구나, 어떤 역할이든 사용 가능
- 🔍 **자동 활동 감지** - 실험, 기능, 버그 수정, 리팩토링, 학습, 문서화, 테스트
- 🤖 **자동 생성** - AI가 코드를 분석하여 포괄적인 로그 생성 (질문 없음!)
- 🌍 **다국어** - 요청에서 자동 언어 감지
- 📝 **작업을 놓치지 않음** - 마지막 로그 타임스탬프 추적, 여러 날 공백에도 대응
- 💡 **활동별 맞춤 질문** - 각 활동 유형마다 관련 질문 제공 (대화형 모드)
- ✅ **품질 기준** - 상세한 답변 강제 (항목당 80+ 단어)
- 🚀 **다중 소스 감지** - Git 커밋 + 커밋되지 않은 변경사항 + 추적되지 않는 파일

## 🚀 빠른 시작

### 설치

**한 줄 설치:**
```bash
curl -fsSL https://raw.githubusercontent.com/wlsdnen/daily-log-skill/main/install.sh | bash
```

**또는 수동 설치:**
```bash
mkdir -p ~/.claude/skills/daily-log
curl -o ~/.claude/skills/daily-log/SKILL.md \
  https://raw.githubusercontent.com/wlsdnen/daily-log-skill/main/SKILL.md
```

**또는 클론 후 설치:**
```bash
git clone https://github.com/wlsdnen/daily-log-skill.git
cd daily-log-skill
./install.sh
```

### Windows 사용자

**권장**: Git Bash 사용 (Git for Windows에 포함됨)

```bash
# 1. Git for Windows 설치 (아직 설치하지 않았다면)
# 다운로드: https://git-scm.com/download/win

# 2. Git Bash를 열고 설치 명령어 실행
curl -fsSL https://raw.githubusercontent.com/wlsdnen/daily-log-skill/main/install.sh | bash

# 3. (선택적) 더 나은 성능을 위해 jq 설치
# 다운로드: https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe
# 위치: C:\Program Files\Git\usr\bin\jq.exe
```

**대안**: WSL (Windows Subsystem for Linux) 사용
- WSL 설치: PowerShell(관리자)에서 `wsl --install`
- WSL 내부에서 Linux 설치 단계 따르기

**참고**: 이 스킬은 bash 스크립트를 사용하며 Git Bash 또는 WSL에서 작동합니다. 네이티브 PowerShell/CMD는 지원되지 않습니다.

### 사용법

프로젝트 디렉토리에서:
```
"Create daily log"           # 영어로 자동 생성
"오늘 작업 기록해줘"         # 한국어로 자동 생성
"Create daily log --interactive"  # 질문 모드
```

스킬이 수행하는 작업:
1. 요청에서 언어 감지
2. 마지막 로그 이후 모든 변경사항 분석
3. 커밋과 코드를 읽어 **자동으로 포괄적인 답변 생성**
4. `./daily-notes/YYYY-MM-DD.md`에 로그 생성

## 📖 예제 출력

```markdown
# 2026-02-05 일일 로그
_기간: 2026-02-03 09:00 ~ 2026-02-05 18:30 (2일)_

## 실험 (감지 위치: src/experiment.ts)
### 병렬 처리 성능 테스트
- **가설**: 청크 단위 병렬 처리가 2배 이상 개선을 달성하는지 테스트
- **방법**: Promise.all을 사용하여 100개 항목 청크로 parallelProcess() 구현
- **결과**: 10k 항목에서 2배 개선 (400ms → 200ms), 하지만 100k 항목에서 메모리 급증
- **학습**: Promise.all은 동시 실행이지 병렬 실행이 아님. 진정한 병렬 처리를 위해서는 Worker 스레드 필요
- **다음 단계**: 설정 가능한 최대 동시성을 가진 Worker 스레드 풀 구현

## 버그 수정 (감지 위치: fix: typo commit)
### 문서 오타 수정
- **문제**: API 문서의 잘못된 메서드 이름
- **근본 원인**: 이전 버전에서 복사-붙여넣기 오류
- **해결책**: 모든 참조를 올바른 메서드 이름으로 업데이트
- **예방**: 문서 검토 체크리스트 추가
- **검증**: 문서 빌드, 모든 링크 확인
```

전체 예제는 [여기](examples/sample-log.md)를 참조하세요.

## 🎯 왜 daily-log인가?

### 문제점
- Git 커밋은 일일 작업의 10-30%만 캡처
- 가장 중요한 작업(실험, 진행 중인 변경사항)은 커밋되지 않음
- 수동 로깅은 지루하고 잊기 쉬움
- 다른 역할은 다른 문서화 스타일이 필요

### 해결책
- **자동 감지** - git 히스토리, 파일 변경사항, 커밋 메시지 분석
- **동적 섹션** - 실제로 수행한 활동에 대한 섹션만 생성
- **스마트 질문** - 활동 유형에 따라 관련 질문 제시
- **작업을 놓치지 않음** - 상태 추적으로 공백이 있어도 연속성 보장

## 📚 문서

- [마이그레이션 가이드](MIGRATION-GUIDE.md) - v1.x(프로필 기반)에서 업그레이드
- [예제 로그](examples/sample-log.md) - 생성된 로그 예시 확인
- [SKILL.md](SKILL.md) - 완전한 스킬 문서

## 🔄 v2.0의 새로운 기능

**v1.x의 주요 변경사항:**
- ✅ 프로필 시스템 제거 (연구자/개발자/학습자/하이브리드)
- ✅ 동적 활동 감지 추가
- ✅ 연속성을 위한 상태 추적 추가
- ✅ 이제 설정 없이 누구나 사용 가능

**마이그레이션:** v2.1을 설치하기만 하면 됩니다 - 설정 없이 자동으로 작동합니다.

## 🛠️ 작동 원리

1. **상태 추적** - `~/.claude/daily-log-state.json`에 마지막 로그 타임스탬프 저장
2. **다중 소스 감지** - git log, 스테이징/언스테이징 변경사항, 추적되지 않는 파일 확인 (7개 소스)
3. **활동 분류** - 변경사항을 패턴과 매칭 (experiments/, feat:, fix: 등)
4. **동적 생성** - 감지된 활동에 대한 섹션만 생성
5. **품질 강제** - 후속 질문을 통해 상세한 답변 보장

## 🧪 감지되는 활동 유형

| 활동 | 감지 패턴 | 질문 항목 |
|----------|------------------|-----------------|
| **실험** | `experiment*.*, experiments/` 경로 | 가설, 방법, 결과, 학습, 다음 단계 |
| **기능** | `feat:, add:` 커밋, 새 파일 | 무엇을, 어떻게, 왜 (대안), 효과, 이슈 |
| **버그 수정** | `fix:, bug:` 커밋 | 문제, 근본 원인, 해결책, 예방, 검증 |
| **리팩토링** | `refactor:, clean` 커밋 | 이유, 변경사항, 개선사항, 메트릭 |
| **학습** | `notes/, tutorials/` 경로, `.md` 파일 | 주제, 난이도, 돌파구, 적용 |
| **문서화** | `docs/, README` 파일 | 목적, 대상, 개선사항 |
| **테스트** | `test/, *.test.*` 파일 | 커버리지, 발견사항, 이슈 |

## 🎓 품질 기준

- 항목당 최소 80-100 단어
- 구체적인 세부사항 (일반적인 "좋음"/"빠름" 금지)
- 가능한 경우 정량적 메트릭
- 고려한 대안
- 향후 검토를 위한 컨텍스트

**스킬은 이러한 기준을 강제합니다** - 답변이 너무 짧으면 후속 질문을 제시합니다.

## 💻 요구사항

- Claude Code CLI
- **Git Bash** (Windows), **bash** (macOS/Linux), 또는 **WSL**
- Git 저장소 (선택사항이지만 권장)
- `jq` (JSON 파싱용) - 선택사항, 없어도 폴백 기능으로 작동

### 플랫폼별 참고사항

- **macOS/Linux**: 바로 작동합니다
- **Windows**: Git Bash([Git for Windows](https://git-scm.com/download/win)에 포함) 또는 WSL이 필요합니다
- **jq 설치**: 선택사항이지만 더 나은 성능을 위해 권장됩니다
  - macOS: `brew install jq`
  - Linux: `apt install jq` 또는 `yum install jq`
  - Windows (Git Bash): [jq releases](https://github.com/stedolan/jq/releases)에서 다운로드

## 🤝 기여

이슈와 PR 환영합니다! 이것은 v2.1입니다 - 버그를 발견하거나 기능 요청이 있으면 알려주세요.

## 📝 라이선스

MIT License - LICENSE 파일 참조

## 🙏 크레딧

Claude Code의 스킬 시스템으로 구축되었습니다. 6개의 테스트 시나리오로 광범위하게 테스트되어 100% 통과율 달성.

---

**버전:** 2.1.0
**상태:** 프로덕션 준비 완료 ✅
**마지막 업데이트:** 2026-02-05
