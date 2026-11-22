# github-oss-workflow

오픈소스 저장소를 수정할 때 사용자가 정한 방식 그대로 따라가는 AI 에디터 스킬입니다.

버그를 고칠 때는 **이슈를 먼저** 열고, 원인을 댓글로 남기고, `fix/issue-<번호>` 브랜치에서 PR을 올린 뒤 이슈를 바로 닫습니다. 기능 추가는 이슈 없이 `feat/<요약>` 브랜치에서 PR을 올립니다. 이슈·댓글·커밋·PR 본문은 사람이 쓴 것처럼 짧은 반말 한국어로 씁니다.

## 들어있는 스킬

이 저장소에는 스킬이 두 개 들어 있고, 설치할 때 **무조건 같이** 설치됩니다.

- `github-oss-workflow` — 문제 제보를 받으면 이슈 → 댓글 → 브랜치 → PR → 이슈 종료까지 처리
- `humanize-korean` — 이슈·PR 글의 AI 티를 제거하고 사람 톤으로 다듬기

하나만 설치되는 상태는 버그입니다. 설치 스크립트가 두 디렉터리를 함께 복사합니다.

## 설치

### OpenCode (추천)

OpenCode가 이 스킬에 가장 잘 맞습니다. 다른 에디터는 부가 옵션으로 같이 넣으면 됩니다.

```bash
git clone https://github.com/spidychoipro/github-oss-workflow.git /tmp/github-oss-workflow
bash /tmp/github-oss-workflow/install.sh opencode
```

Windows PowerShell:

```powershell
git clone https://github.com/spidychoipro/github-oss-workflow.git "$env:TEMP\github-oss-workflow"
powershell -ExecutionPolicy Bypass -File "$env:TEMP\github-oss-workflow\install.ps1" -Editor opencode
```

### Codex / Claude Code까지 같이 설치

```bash
bash install.sh all
```

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Editor all
```

에디터 하나만 골라서 넣으려면 `-Editor codex`, `-Editor claude`처럼 주면 됩니다. bash 쪽은 `bash install.sh codex` 형태입니다.

이미 설치돼 있는 스킬 디렉터리는 건드리기 전에 temp의 `opencode-skill-backups/`로 백업한 뒤 새 걸 복사합니다. 백업이 skills 폴더에 남아 중복 스킬로 잡히지 않게 한 것입니다. 옆에 있던 다른 스킬은 그대로 둡니다. 설치 뒤 에디터를 다시 시작하면 스킬이 등록됩니다.

### 에디터별 설치 경로

| 에디터 | 경로 | 옵션 값 |
| --- | --- | --- |
| OpenCode (추천) | `~/.config/opencode/skills/` | `opencode` |
| Codex | `~/.codex/skills/` | `codex` |
| Claude Code | `~/.claude/skills/` | `claude` |

각 경로 아래에 `github-oss-workflow/`와 `humanize-korean/`이 함께 들어갑니다.

## 사용

```
/$github-oss-workflow 이 버그 고쳐줘
```

스킬 이름을 직접 부르지 않아도 자동으로 붙습니다. 오픈소스 프로그램을 수정하거나 바이브 코딩을 하다가 "이거 문제야", "이거 안 돼", "오류 나", "불편해", "버그 같아"처럼 문제를 제보하면 이슈부터 열고 브랜치·PR·이슈 종료까지 이어갑니다. 요구가 완성된 기능 추가는 이슈 없이 `feat/` 브랜치로 갑니다.

## 구조

```
install.sh                                  설치 스크립트 (bash, OpenCode 추천)
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
