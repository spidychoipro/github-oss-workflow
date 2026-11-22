# github-oss-workflow

오픈소스 저장소를 수정할 때 사용자가 정한 방식 그대로 따라가는 AI 에디터 스킬입니다.

버그를 고칠 때는 **이슈를 먼저** 열고, 원인을 댓글로 남기고, `fix/issue-<번호>` 브랜치에서 PR을 올린 뒤 이슈를 바로 닫습니다. 기능 추가는 이슈 없이 `feat/<요약>` 브랜치에서 PR을 올립니다. 이슈·댓글·커밋·PR 본문은 사람이 쓴 것처럼 짧은 반말 한국어로 씁니다.

오픈소스 프로그램을 수정하거나 바이브 코딩을 하다가 "이거 문제야", "이거 안 돼", "오류 나", "불편해", "버그 같아"처럼 문제를 제보하면 슬래시 명령 없이 이 흐름이 자동으로 붙습니다.

## 들어있는 스킬

이 저장소에는 스킬이 두 개 들어 있고, **어떤 에디터를 골라도 항상 두 개가 같이 설치**됩니다.

- `github-oss-workflow` — 문제 제보 → 이슈 → 댓글 → 브랜치 → PR → 이슈 종료
- `humanize-korean` — 이슈·PR 글의 AI 티를 제거하고 사람 톤으로 다듬기

하나만 설치되는 상태는 버그입니다. 에디터를 하나만 골라도 두 스킬은 세트로 들어갑니다.

---

## 설치

### 0단계. 저장소 먼저 받기

에디터 상관없이 아래 한 줄을 먼저 실행합니다.

**Windows (PowerShell)**

```powershell
git clone https://github.com/spidychoipro/github-oss-workflow.git "$env:TEMP\github-oss-workflow"
```

**macOS / Linux**

```bash
git clone https://github.com/spidychoipro/github-oss-workflow.git /tmp/github-oss-workflow
```

이미 받아둔 사람은 이 단계를 건너뛰고 자기 에디터 항목만 실행하면 됩니다. 설치 스크립트는 기존 스킬을 temp의 `opencode-skill-backups/`로 백업한 뒤 새 걸 넣습니다. 옆에 있던 다른 스킬은 그대로 둡니다.

---

### 1-A. OpenCode만 쓰는 사람 (추천)

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:TEMP\github-oss-workflow\install.ps1" -Editor opencode
```

macOS / Linux:

```bash
bash /tmp/github-oss-workflow/install.sh opencode
```

설치 위치: `~/.config/opencode/skills/`

```
~/.config/opencode/skills/github-oss-workflow/
~/.config/opencode/skills/humanize-korean/
```

---

### 1-B. Codex만 쓰는 사람

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:TEMP\github-oss-workflow\install.ps1" -Editor codex
```

macOS / Linux:

```bash
bash /tmp/github-oss-workflow/install.sh codex
```

설치 위치: `~/.codex/skills/`

```
~/.codex/skills/github-oss-workflow/
~/.codex/skills/humanize-korean/
```

---

### 1-C. Claude Code만 쓰는 사람

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:TEMP\github-oss-workflow\install.ps1" -Editor claude
```

macOS / Linux:

```bash
bash /tmp/github-oss-workflow/install.sh claude
```

설치 위치: `~/.claude/skills/`

```
~/.claude/skills/github-oss-workflow/
~/.claude/skills/humanize-korean/
```

---

### 1-D. 여러 에디터에 한 번에 넣고 싶은 사람

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:TEMP\github-oss-workflow\install.ps1" -Editor all
```

macOS / Linux:

```bash
bash /tmp/github-oss-workflow/install.sh all
```

아무 옵션을 안 주면 기본값이 `all`이라 세 곳 전부에 들어갑니다.

---

### 에디터별 옵션 한눈에

| 에디터 | 옵션 값 | 설치 경로 |
| --- | --- | --- |
| OpenCode (추천) | `opencode` | `~/.config/opencode/skills/` |
| Codex | `codex` | `~/.codex/skills/` |
| Claude Code | `claude` | `~/.claude/skills/` |
| 전부 | `all` (기본값) | 위 세 경로 전부 |

설치 뒤에는 에디터를 한 번 다시 시작하면 스킬이 등록됩니다.

---

## 사용

```
/$github-oss-workflow 이 버그 고쳐줘
```

스킬 이름을 직접 부르지 않아도 됩니다. 문제 제보로 들어오면 이슈부터 열고 브랜치·PR·이슈 종료까지 이어갑니다. 요구가 완성된 기능 추가만 이슈 없이 `feat/` 브랜치로 갑니다.

## 구조

```
install.sh                                  설치 스크립트 (bash)
install.ps1                                 설치 스크립트 (Windows PowerShell)
skills/
  github-oss-workflow/
    SKILL.md                                스킬 본문
    references/workflow.md                  사용자 지정 GitHub 작업 규칙 원문
    references/human-tone.md                이슈·PR 글의 사람 톤 규칙
    agents/openai.yaml                      스킬 표시 이름과 기본 프롬프트
  humanize-korean/
    SKILL.md                                한국어 윤문 스킬 본문
    references/                             윤문 룰북
    scripts/                                보조 스크립트
    agents/openai.yaml
```

## 규칙 출처

`skills/github-oss-workflow/references/workflow.md`는 사용자의 `AGENTS.md`에 적힌 GitHub 작업 흐름 규칙을 그대로 옮긴 것입니다. 이슈 우선, 브랜치 + PR, 댓글 필수, 이슈 즉시 종료, 사람 톤 한국어가 핵심입니다.
