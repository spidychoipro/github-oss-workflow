# github-oss-workflow

오픈소스 저장소를 수정할 때 사용자가 정한 방식 그대로 따라가는 OpenCode 스킬입니다.

버그를 고칠 때는 **이슈를 먼저** 열고, 원인을 댓글로 남기고, `fix/issue-<번호>` 브랜치에서 PR을 올린 뒤 이슈를 바로 닫습니다. 기능 추가는 이슈 없이 `feat/<요약>` 브랜치에서 PR을 올립니다. 이슈·댓글·커밋·PR 본문은 사람이 쓴 것처럼 짧은 반말 한국어로 씁니다.

## 설치

OpenCode 스킬 디렉터리에 이 저장소를 넣으면 됩니다.

```bash
git clone https://github.com/spidychoipro/github-oss-workflow.git ~/.config/opencode/skills/github-oss-workflow
```

Windows PowerShell:

```powershell
git clone https://github.com/spidychoipro/github-oss-workflow.git "$env:USERPROFILE\.config\opencode\skills\github-oss-workflow"
```

이미 디렉터리가 있으면 `git pull`로 갱신하면 됩니다. 설치 후 OpenCode를 다시 시작하면 스킬이 등록됩니다.

## 사용

```
/$github-oss-workflow 이 버그 고쳐줘
```

스킬 이름을 직접 부르지 않아도 "이거 불편해", "버그 같아", "기능 추가해줘", "이슈 열고 PR 올려" 같은 요청에 자동으로 적용됩니다.

## 구조

```
SKILL.md                        스킬 본문
references/workflow.md          사용자 지정 GitHub 작업 규칙 원문
references/human-tone.md        이슈·PR 글의 사람 톤 규칙
agents/openai.yaml              스킬 표시 이름과 기본 프롬프트
```

## 규칙 출처

`references/workflow.md`는 사용자의 `AGENTS.md`에 적힌 GitHub 작업 흐름 규칙을 그대로 옮긴 것입니다. 이슈 우선, 브랜치 + PR, 댓글 필수, 이슈 즉시 종료, 사람 톤 한국어가 핵심입니다.
