# Copilot translation (Matt → GitHub Copilot)

**As of:** checked on 19 November 2026 (sources: https://docs.github.com/en/copilot/how-tos/use-copilot-agents/cloud-agent/create-skills and https://docs.github.com/en/copilot/concepts/prompting-and-context/context-management). When a feature no longer seems right, say so and suggest checking it there.

| In Matt's world (Claude Code) | In GitHub Copilot |
|---|---|
| Watching context (smart/dumb zone) | Context indicator in the chat box of VS Code and Visual Studio; `/context` in Copilot CLI. New session per task. |
| Compaction | Automatic when the window fills up; manual with `/compact`. Mid-task: handoff. |
| Handoff | The agent writes a handoff note; start a new session with it. |
| AGENTS.md | `AGENTS.md` or `.github/copilot-instructions.md`; per folder or file type `.github/instructions/*.instructions.md` (with `applyTo`); nested AGENTS.md per folder. |
| Skills | `.github/skills/<name>/SKILL.md` (also `.claude/skills`, `.agents/skills`); personal in `~/.copilot/skills`. Works in VS Code agent mode, Copilot CLI, the cloud agent and code review; `/skills` in VS Code. Matt's skills are markdown and therefore usable. |
| Repeated prompts | Prompt files in `.github/prompts/*.prompt.md`, as a slash command. |
| Grilling and planning | Plan agent (`/plan`) asks clarifying questions first and makes a plan; or a grill skill. |
| Subagents | Agent and Plan mode start subagents themselves; custom roles via `.github/agents/*.agent.md`. |
| Building tickets AFK | Assign an issue to the Copilot cloud agent (formerly "coding agent"), which opens a PR in the background. From level 3. |
| Review | Copilot code review on the PR (also uses instructions and skills), plus human review. |
