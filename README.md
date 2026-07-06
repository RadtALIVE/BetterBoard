# BetterBoard — by Better Co.

A minimalist classroom whiteboard. Import a PDF or Word file and each page becomes its
own whiteboard page, sized to match automatically. Draw with fineliner, marker,
highlighter, or pencil. Save the whole board — every page, every stroke — into a single
`.btr` file.

This repo distributes the Windows installer. The app's source code lives in a separate
private repo and is pulled in automatically when a release is built.

## Install (Windows)

<!-- Replace RadtALIVE/BetterBoard once this is pushed to GitHub -->
[![Download BetterBoard for Windows](https://img.shields.io/badge/Download-BetterBoard%20for%20Windows-2F6F62?style=for-the-badge)](https://github.com/RadtALIVE/BetterBoard/releases/latest/download/BetterBoard-Setup.exe)

Click the button, run the downloaded `BetterBoard-Setup.exe`, and step through the normal
Next → Install → Finish wizard. It adds Start Menu and (optionally) Desktop shortcuts.

## Repo layout

```
installer/setup.iss       Inno Setup script that builds the installer
.github/workflows/        CI: pulls the private source repo, builds, packages, releases
```

There's no app source in this repo on purpose — it lives in a separate private repo and
gets checked out automatically by the workflow at build time.

## How releases get built

Pushing a version tag triggers `.github/workflows/release.yml`, which:
1. checks out this repo (for the installer script)
2. checks out the private source repo into `source/`
3. runs `dotnet publish` on `source/BetterBoardApp/BetterBoard.csproj` — this produces a
   single self-contained `BetterBoard.exe` (see that repo's own README for details on
   why it's just one file)
4. packages that `.exe` with Inno Setup into `BetterBoard-Setup.exe`
5. attaches it to a new GitHub Release

```bash
git tag v1.0.0
git push origin v1.0.0
```

### One-time setup before this works
1. In `.github/workflows/release.yml`, replace `RadtALIVE/BetterBoard-source` with
   your actual private source repo (owner/name).
2. Create a **fine-grained Personal Access Token** with read-only access to that private
   repo only (GitHub → Settings → Developer settings → Personal access tokens).
3. Add it as a secret on **this** repo, named `SOURCE_REPO_PAT`
   (this repo's Settings → Secrets and variables → Actions → New repository secret).
4. In this README, replace `RadtALIVE/BetterBoard` in the download badge link above
   with this repo's own path, so the button always points at its own Releases page.

Once those are set, every tag push builds a fresh installer and publishes it as a
Release automatically — the download button never needs to be touched again.

## Caveat: no code signing
The installer isn't code-signed (that requires a paid certificate), so Windows
SmartScreen will likely show an "Unknown publisher" warning the first time someone runs
it. That's normal for small/independent apps — "More info → Run anyway" gets past it.
Signing can be added later if wider distribution makes it worth the cost.
