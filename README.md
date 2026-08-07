# homebrew-srota

Homebrew tap for Srota — a native macOS terminal for running and orchestrating coding agents.

## Install

```sh
brew tap k161196/srota
brew install --cask srota
```

## What is Srota?

Srota is a macOS terminal/agent tool: a background daemon runs real PTYs for your shell and coding-agent processes (Claude, Codex), and a native SwiftUI app renders them as panes, tabs, and workspaces.

- **Panes, tabs, workspaces** — split, arrange, and save layouts of terminals and agents like a native tmux.
- **Detachable sessions** — the daemon keeps agents running independent of the app; reattach anytime, restart the app without losing a session.
- **Live agent status** — every pane tracks working / idle / blocked / done, so you can tell at a glance which agents need you.
- **Flow view** — repo-scoped GitHub issues and PRs, with the issue matching your current branch surfaced automatically.
- **Cross-agent orchestration (MCP)** — an agent can spawn sibling agent panes, read their output, send them input, and leave notes for others in the workspace.

More: [srota-site](https://k161196.github.io/srota-site/)

## Uninstall

```sh
brew uninstall --cask srota
```

Data lives in `~/.srota`. To remove everything:

```sh
brew uninstall --cask srota --zap
```

## Requirements

- macOS 26 (Tahoe) or later
- Apple Silicon

## Version

Current cask: `0.0.0` (no build published yet — see [releases](https://github.com/k161196/homebrew-srota/releases))
