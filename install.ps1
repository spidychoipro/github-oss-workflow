# github-oss-workflow + humanize-korean 함께 설치
# OpenCode 추천. Codex, Claude Code도 같이 설치 가능.
#
# 사용법:
#   powershell -ExecutionPolicy Bypass -File .\install.ps1
#   powershell -ExecutionPolicy Bypass -File .\install.ps1 -Editor codex
param(
    [ValidateSet('all', 'opencode', 'codex', 'claude')]
    [string]$Editor = 'all'
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$src = Join-Path $repoRoot 'skills'
$homeDir = $env:USERPROFILE
$backupRoot = Join-Path $env:TEMP 'opencode-skill-backups'
New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null

$paths = @{
    opencode = Join-Path $homeDir '.config\opencode\skills'
    codex    = Join-Path $homeDir '.codex\skills'
    claude   = Join-Path $homeDir '.claude\skills'
}

if ($Editor -eq 'all') {
    $targets = @('opencode', 'codex', 'claude')
} else {
    $targets = @($Editor)
}

foreach ($target in $targets) {
    $dir = $paths[$target]
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    Write-Host "[$target] $dir"

    foreach ($skill in @('github-oss-workflow', 'humanize-korean')) {
        $srcDir = Join-Path $src $skill
        $dstDir = Join-Path $dir $skill

        if (-not (Test-Path $srcDir)) {
            throw "없는 스킬 디렉터리: $srcDir"
        }

        if (Test-Path $dstDir) {
            $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
            $backup = Join-Path $backupRoot "$skill-$target-$stamp"
            Move-Item -Path $dstDir -Destination $backup
            Write-Host "  백업: $backup"
        }

        Copy-Item -Path $srcDir -Destination $dstDir -Recurse -Force
        Write-Host "  설치: $dstDir"
    }
}

Write-Host '끝. 에디터를 다시 시작하면 두 스킬이 같이 보입니다.'
