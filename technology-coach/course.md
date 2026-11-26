# The course in one place

Matt Pocock's *Software Factories for Real Engineers* (7 chapters), preceded by the fundamentals of the *AI Coding Crash Course*. In our own words, from the AE course notes *AI Software Factory* (see Sources in `SKILL.md`). Per chapter: why · what · how · decision rules · Matt's take. Matt's take is what makes an answer "what Matt would do": use it, especially where it goes against common advice.

**As of:** skill names checked against github.com/mattpocock/skills on 23 November 2026. Course-only (not in the public repo): `mutation-testing`, `software-factory`, `setup-ts-deep-modules`.

## 0 · Fundamentals (Crash Course, levels 0–1)

- An LLM predicts text and remembers nothing between sessions. Its intelligence is jagged: brilliant at one thing, silly at the next.
- **Smart zone / dumb zone**: sharp with a lean context, worse as the context fills. One task per session.
- **Phase boundary**: after planning, building or testing, decide: continue, clear, hand off, subagent, or compact. Mid-task: hand off (`handoff`), don't compact; compacting loses answers.
- **AGENTS.md**: the file the agent reads at the start of every session. Short; points onward (progressive disclosure).

## 1 · Domain language · ladder step 1

- **Why**: agents invent their own names. One concept gets different names in UI, emails and code, and agents rebuild code that already exists.
- **What**: one shared vocabulary in a small `GLOSSARY.md`, plus a few ADRs in `docs/adr/`. `grill-with-docs` builds both: the agent interviews you and writes terms down as you decide (`domain-modeling` sharpens terms; `grilling` is the interview primitive).
- **How**: start `grill-with-docs` with the context and what's out of scope → answer; it tests terms against edge cases → reject the terms you don't like → rename code, UI and emails *before* the spec.
- **Glossary entry shape**: term · one-line meaning · statuses · *Avoid:* the words it replaces.
- **Matt's take**
  - Never hand the glossary to an agent. Unreviewed, it fills with the agent's words and team and agent drift apart. Glossary work is among the most valuable things a person does for a codebase.
  - Your taste decides: the agent proposes, you choose; throw out vague or ugly terms.
  - Short and grown slowly: add only what current work needs; rushed entries need pruning later.
  - Let the code break ties: torn between two words, count them in the code and pick the one that keeps the rename small.

## 2 · Wayfinder · ladder step 2

- **Why**: a big plan doesn't fit in one session; the agent gets worse as the context fills, and compacting loses answers.
- **What**: `wayfinder` keeps the plan in the issue tracker: one map issue with small decision tickets under it. Each ticket gets a fresh session and the right depth.
- **How**: `wayfinder <prompt>` charts the map → per ready ticket: clear the session, `wayfinder #N` → each decision closes a ticket and updates the map → last open questions, then `to-spec` → `to-tickets` → `implement` / `implement-spec`.
- **Four ticket types**: grilling (talk it through), research (a subagent reads docs; `research`), prototype (variants on a throwaway branch; `prototype`), task (manual work, e.g. a sign-up).
- **How much planning?**
  - Diff tiny → one-shot it; align after you see the diff.
  - Otherwise → `grill-with-docs` on plan and words.
  - Bigger than you thought → `wayfinder`. Not bigger → keep grilling, then `to-spec` → `to-tickets`.
- **Matt's take**
  - Starting in Wayfinder is a failure: if the work turns out simple you're left with a big map that's hard to undo. Switch only near the dumb zone or when more unknowns appear than expected.
  - One-shot more than you think: for tiny UI or QA changes a bad small diff costs almost nothing.
  - Decide at the right fidelity: some questions (a vendor choice) only a prototype answers; when a prototype raises a UX question, go back to talking.
  - Prototyping is where to spend tokens: several variants, your own likes and dislikes. Keep that code off main.

## 3 · Review · ladder steps 3–4

- **Why**: agents write more code than people can review; without a system, reviewers repeat the same comments on poor code.
- **What**: three brakes, cheapest first:
  1. **Automated checks**: lint, types, tests, custom rules. CPU, free, deterministic.
  2. **Automated review**: `code-review` in a fresh session, against coding standards *and* the spec. Costs tokens.
  3. **Human review**: only on code that passed 1 and 2, ranked by risk. Scarce.

  `retro` feeds all three: comments become checks or standards.
- **PR body** (`pr`): **Summary** (a picture: diagram, diff sketch, file tree) · **Evidence** (before and after; "before" proves the agent found the real problem; screenshots first, then test output) · **Merge danger** (**door**: two-way = easy to revert, one-way = hard to undo, like a migration; **blast radius**: one word for what breaks).
- **How much human review?**
  - One-way door and large blast radius → a person reads it line by line.
  - Two-way door and small blast radius → may not need a human, only with solid checks and agent review.
  - Anything else → normal review.
- **Usage**: `code-review` PR #N in a new session, fix what you find, with the original spec issue. `retro` on the sessions and PR comments behind one PR, or on the last ~25 sessions. Write comments as rules ("let the code explain itself").
- **Matt's take**
  - Hide the standards from the implementer: unlike most people he keeps coding standards *out of* AGENTS.md. The implementer makes it work; a fresh reviewer with the standards makes it good.
  - A review that only comments makes it worse: comments land on the human. The reviewer should fix what it finds and pass up only what it's unsure about. Most teams do too little automated review.
  - Not every PR needs a human (he knows it's controversial): reversible, small blast radius, solid checks and agent review. Finance or medical code is different.
  - Agents write poor PR descriptions; visual summaries changed his mind. He insists on "before" evidence.

## 4 · Codebase design · ladder step 5

- **Why**: agents finish the task but don't improve the design. Code fills up with copied logic and tests that only repeat the code.
- **What**: a fixed design vocabulary (`codebase-design`), a scan (`improve-codebase-architecture`), and boundary rules a tool enforces (e.g. dependency-cruiser; `setup-ts-deep-modules` in the course).
  - **Shallow module**: every caller calls each step in the right order. **Deep module**: one small interface hides the steps; tests go through it.
  - **Seam and adapters**: pass dependencies (database, clock) into the core; tests swap a live adapter for a test adapter.
- **How**: scan the riskiest part → judge each candidate: delete it or make it deeper → grill it, then `to-spec` → `to-tickets` → `implement-spec` → add a boundary rule so it stays that way. Point the scan at a file you already suspect.
- **Matt's take**
  - Don't ban agent-written tests: blame the codebase, not the agent. Hide internals in deep modules and bad tests become impossible to write.
  - Agents are tactical tornadoes: they do only the task in front of them. Treat vibe-coded codebases as legacy code.
  - One vocabulary, no dogma: if the team already has design terms it likes, use those.
  - A check, backed by review: agents can cheat a check by editing its config, so add a coding standard too. Keep the rule narrow to avoid a huge refactor.

## 5 · Feedback loops · ladder step 6

- **Why**: an agent that sees only files and tests is blind; written rules are followed only sometimes.
- **What**: automated checks that fail *with the fix in the message*, plus data sources the agent can look at.
- **Where checks run**

  | Where | Time | What |
  |---|---|---|
  | Each file edit | – | Nothing: too slow and noisy. |
  | Pre-commit | ≈ 3 s | Staged files only, in parallel: format, file size, lint, typecheck, boundaries. |
  | Agent's own check | minutes | Mutation tests on changed lines, browser screenshots. Information, not a gate. |
  | CI | minutes | Everything. The only hard stop, because agents can skip hooks. |

- **Test the tests**: mutation testing shows which wrong code the tests would miss; a surviving mutant is a missing test.
- **Give the agent eyes**: logs, databases, the browser (`agent-browser`), the bug tracker. When agents fix bugs badly, they usually lack data. Stubborn bugs: `diagnosing-bugs` (first a loop that goes red on the bug).
- **From rule to check**: a comment or rule that should apply to every change →
  - stale, duplicate or a process rule → delete it (git keeps the history);
  - the code alone can show the problem → make it a check (lint rule, custom rule, test);
  - otherwise → a coding standard the review agent judges.
- **Error messages teach**: a failing check says what to do ("move business logic to app/modules/, then run the check and commit again"), like an AGENTS.md that loads only when needed. Example: a file-size check that fails above ~5,000 tokens and says how to split.
- **Matt's take**
  - Pick determinism every time: if a rule can be a check, it becomes a check.
  - Slow checks hurt more than you think: pre-commit under ~3 s; no checks on every file edit.
  - Tests stay out of the hook, even at 2 seconds, because the suite will grow.
  - A hook is not a gate: agents can skip it, so CI is the hard stop. He finds pre-push hooks annoying and doesn't use them.

## 6 · Software factory, part 1 · ladder step 7

- **Why**: even with brakes in place, a person still starts and steers every step, which caps output at what one person can watch.
- **What**: each step runs as an agent in its own sandbox, started by an issue label. Add agents as trust in the brakes grows.
- **Flow**: intake (feedback form or monitor files an issue) → **explore** (reproduces bugs, groups issues) → **approve** (no human if easy) → **implement** (opens a draft PR) → **review** (fixes + comments) → git host → human **merge** (door · radius) → **retro** improves the agents. Humans step in only on `needs-a-human` and open questions.
- **Labels**: `agent:explore`, `agent:implement`, `agent:review`, `agent:implement-spec`, `agent:in-progress`, `agent:blocked` (run failed; comment says how to retry), `needs-a-human` (factory stopped for a decision). Only team members can add labels.
- **Plumbing**: any sandbox works (CI job, container, cloud VM, Daytona, E2B; Sandcastle is Matt's optional helper). Each step is a workflow that starts on its label; a fine-grained token lets one workflow start the next.
- **Auto-merge rule**: only two-way door, small blast radius, no data migration.
- **Matt's take**
  - Speed only after the brakes: remove a human from a step only when check and review layers exist; otherwise the factory becomes a slop cannon.
  - Agent confidence never decides a merge.
  - A soft reviewer slows you down: it should fix more and ask less.
  - Push back on retro too: reject bad suggestions (a check before every edit) and reword lines it adds to AGENTS.md.

## 7 · Software factory, part 2 · ladder step 8

- **Why**: part 1 runs only on GitHub and only from labels; many useful jobs run on a schedule or an event.
- **What**: five slots and one vocabulary (a **task** is a kind of work, a **run** one execution, a **runner** the throw-away machine). Draw each loop on a whiteboard first.

  | Slot | Job | Priority |
  |---|---|---|
  | Ticket tracker | Where humans and agents meet | Keep yours |
  | Git host | Branches, PRs, the state a run leaves | Keep yours |
  | Runner | Fresh disposable sandbox per run | First |
  | Orchestrator | Starts runs on events or schedules; dedupes, times out, limits concurrency | First |
  | Observability | Cost and success per run; logs for retros | Later |

- **Loop design on one page**: Trigger · Task · Brake · Output · Human. If you can't fill in the brake, don't build the loop. Example (lint ratchet): daily · fix one failing instance of a lint rule · stop at more than 5 open ratchet PRs · one labelled PR · human reviews and merges; at zero failures the rule becomes strict.
- **Example loops and their brakes**: daily architecture scan (stops at >5 candidate tickets waiting) · lint ratchet (one fix per PR, stops at >5 open PRs) · morning rebase (a script first, agent only on conflicts) · slow-query monitor (pulls once a day, fixes only severe ones).
- **Goal**: a factory you can ignore, which calls you when it needs you.
- **Matt's take**
  - Determinism first: a script before an agent; a scripted rebase handles many PRs without tokens.
  - Pull signals, don't push them: pushed alerts are speed you don't control. Pull on a schedule, group, fix only the severe ones.
  - Every loop needs a stop: start slow ("stop at 5 open tickets"). Distrust big refactors in one runner (dumb zone).
  - Deploys must not kill running work.

## Glossary

Matt's own meanings only; common terms (context window, subagent, skill) as generally known.

- **Smart zone / dumb zone**: sharp reasoning with a lean context, sagging as it fills.
- **Compaction vs handoff**: compaction summarises within the session; a handoff note starts a new one. Mid-task: handoff.
- **Phase boundary**: the moment after planning, building or testing to decide about context.
- **Grilling**: the agent interviews you until you agree on the plan.
- **Spec and tickets**: the whole change (the agreed destination), and its small buildable slices.
- **Tracer bullet**: a thin vertical slice that works end-to-end through all layers.
- **Wayfinder map**: a map issue of decision tickets for work too big for one session.
- **Domain language**: shared GLOSSARY.md and ADRs, for human and agent.
- **Brakes / accelerators**: brakes make bad output hard to produce; accelerators raise pace. Brakes first.
- **Automated check**: a small program that checks every change (lint rule, test, boundary rule). **Coding standard**: a rule a review agent judges.
- **Door**: two-way (easy to revert) or one-way (hard to undo). **Blast radius**: what breaks if it's wrong.
- **Deep / shallow module**: small interface hiding a lot, versus callers orchestrating the steps. **Seam**: where a dependency is passed in so tests can swap it.
- **Mutation testing**: deliberately wrong code to see whether tests catch it; a surviving mutant is a missing test.
- **Tactical tornado**: an agent (or person) that finishes the task and leaves the design worse.
- **HITL / AFK**: a person takes part, or nobody is at the keyboard.
- **Task / run / runner**: a kind of work, one execution of it, the disposable machine it runs on.
- **Ratchet**: a loop that fixes one instance at a time until a rule can become strict.
- **Slop cannon**: a factory without brakes.
- **Retro** (`retro`): after work with the agent, improve the agent's environment: a check, a standard, or a line in AGENTS.md.
