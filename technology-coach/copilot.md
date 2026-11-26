# Copilot translation (Matt → GitHub Copilot)

**As of:** checked on 23 November 2026 (sources: https://docs.github.com/en/copilot/how-tos/use-copilot-agents/cloud-agent/create-skills, https://docs.github.com/en/copilot/concepts/prompting-and-context/context-management, https://github.blog/changelog/2025-11-12-copilot-code-review-and-coding-agent-now-support-agent-specific-instructions/). When a feature no longer seems right, say so and suggest checking it there.

The concepts are the same; only the mechanics differ. Matt's skills are markdown and work as Copilot skills.

| In Matt's world (Claude Code) | In GitHub Copilot |
|---|---|
| **Fundamentals** | |
| Watching context (smart/dumb zone) | Context indicator in the chat box of VS Code and Visual Studio; `/context` in Copilot CLI. |
| Fresh session (`/clear`) | New chat session in VS Code; `/clear` in Copilot CLI. One task, one ticket or one decision per session. |
| Compaction vs handoff | Compaction is automatic when the window fills; manual with `/compact`. Mid-task: the agent writes a handoff note; start a new session with it. |
| AGENTS.md | `AGENTS.md` or `.github/copilot-instructions.md`; per folder or file type `.github/instructions/*.instructions.md` (with `applyTo`); nested AGENTS.md per folder. Keep it short. |
| Skills | `.github/skills/<name>/SKILL.md` (also `.claude/skills`, `.agents/skills`); personal in `~/.copilot/skills`. Works in VS Code agent mode, Copilot CLI, the cloud agent and code review; `/skills` in VS Code. |
| Repeated prompts | Prompt files in `.github/prompts/*.prompt.md`, as a slash command. |
| Subagents | Agent and Plan mode start subagents themselves; custom roles via `.github/agents/*.agent.md`. |
| **Language and planning (ladder steps 1–2)** | |
| Grilling (`grill-with-docs`) | The skill itself, or the Plan agent (`/plan`), which asks clarifying questions first. Glossary and ADRs live in the repo either way. |
| Wayfinder map, spec, tickets | Issues with sub-issues on GitHub; one decision ticket per new chat session. |
| **Review (ladder steps 3–4)** | |
| Second agent reviews (`code-review`) | Copilot code review on the PR (reads instructions and skills); `/review` in Copilot CLI; or a custom reviewer agent in a fresh session. Copilot code review comments; to get Matt's "fix, don't just comment", let the cloud agent act on the comments (mention `@copilot` on the PR) or run the reviewer skill locally. |
| Hide the standards from the implementer | Put coding standards in `.github/instructions/<name>.instructions.md` with `excludeAgent: "coding-agent"`: Copilot code review reads them, the cloud agent doesn't. This applies to the GitHub agents; VS Code's local agent may still load the file, so check before relying on it there. |
| PR body (`pr`) | `.github/pull_request_template.md` with Summary · Evidence (before/after) · Merge danger (door, blast radius), plus the `pr` skill. |
| `retro` | The `retro` skill in agent mode or the CLI, on the sessions and PR comments behind one PR. Output lands in checks, review-only instructions or AGENTS.md. |
| **Checks and eyes (ladder steps 5–6)** | |
| Pre-commit hook, boundary rules | Tool-agnostic (Husky + lint-staged, pre-commit, dependency-cruiser). Required status checks on the branch make CI the hard stop. |
| Agent's eyes (logs, DB, browser) | MCP servers in VS Code and for the cloud agent; tools and dependencies for the cloud agent in `.github/workflows/copilot-setup-steps.yml`. |
| **Factory (ladder steps 7–8)** | |
| Agent works alone in a sandbox | Assign an issue to the Copilot cloud agent: it works in its own ephemeral GitHub Actions environment and opens a PR. From level 4, after steps 3, 4 and 6 hold. |
| Label-triggered steps | GitHub Actions on `issues: labeled`, filtered on one label per job. How the workflow hands the issue to Copilot depends on plan and API support: check the docs. |
| Scheduled loops (orchestrator slot) | GitHub Actions `schedule` and event triggers; concurrency groups and timeouts as brakes. |

## Cost and usage (AI credits)

*Checked on 25 November 2026 (sources: https://docs.github.com/en/copilot/how-tos/copilot-cli/use-copilot-cli/set-session-limit, https://docs.github.com/en/copilot/tutorials/optimize-ai-usage, https://docs.github.com/en/copilot/concepts/models/auto-model-selection). Usage-based billing started 1 June 2026; one AI credit is $0.01. Business and Enterprise get a pooled allowance per licence: check the client's own number, don't quote one.*

- **See what it cost:** `/chronicle cost tips` in Copilot CLI looks at recent sessions and suggests savings; `/chronicle standup` summarises recent work.
- **A brake per session:** `--max-ai-credits N` (scripted, with `copilot -p`) or `/limits set max-ai-credits N` (interactive). A soft limit in public preview; works best above 30 credits, since most model calls cost over 20. Offer it as a personal brake, not as a client policy.
- **Auto model selection:** billed at the rate of the model it picks, with a 10% discount on paid plans (Chat, CLI, cloud agent). Since September 2026 it has cost/quality tiers.
- **Usage conversation, Matt-style:** cost follows context. One task per session and a fresh session per decision cut cost more than any model switch.
