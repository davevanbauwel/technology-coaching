# Routes

One route per team situation, grouped by the layer of the path. The concept comes first; Matt's skills follow in brackets as reference. Concepts, decision rules and Matt's takes live in `course.md`.

**As of:** skill names checked against github.com/mattpocock/skills (router `ask-matt`) on 23 November 2026. When a skill name no longer seems right, say so and suggest checking it.

**Route format:**
```
**[Situation]** · level [n] · step [k]
- Idea: [Matt's principle; name one of the three lines where it fits]. (Matt: [skills])
- Concrete: [what the team does this week]
- Script line: "[...]"
```

### Fundamentals

**Experienced colleagues without AI experience (e.g. close to retirement)** · level 0
- Idea: their domain knowledge is exactly what the method needs; humans do the strategic work. (Matt: domain-modeling, code-review)
- Concrete: start with their own code and a small, visible win; make them the source of the domain language and reviewer of what the agent produces.
- Script line: "You know what's right. The agent types, you decide."

**Long sessions; the agent gets dumber along the way, or derails halfway** · level 1–2
- Idea: the smart zone is limited; decide at each phase boundary; mid-task, hand off rather than compact. (Matt: handoff)
- Concrete: one task per session; after planning, building and testing, ask "do I still need this context?". A task that derails: stop, write a handoff note, and size it with the planning tree in `course.md` (ch. 2).
- Script line: "We're done planning. Do we take this context along, or start fresh?"

### Shared language · step 1

**Refinement produces vague stories; the agent builds the wrong thing** · level 2 · step 1
- Idea: grill before you build; the spec is the agreed destination. But one-shot tiny diffs. (Matt: grill-with-docs → to-spec → to-tickets → implement)
- Concrete: take one story; tiny diff → one-shot and align on the diff. Otherwise the agent grills the team until "done" is sharp, terms go into GLOSSARY.md, then a spec in the issue tracker and 2 to 4 tracer-bullet tickets, a fresh session per ticket.
- Script line: "Before we prompt, we grill this story until we know when it's done."

**The agent (or a new colleague) confuses terms; names drift between UI, code and people** · level 1–3 · step 1
- Idea: one domain language for human and agent; the agent proposes, the team chooses and reviews. (Matt: grill-with-docs, domain-modeling)
- Concrete: a GLOSSARY.md with the 10 terms that go wrong most (with *Avoid:* words), one recent hard decision as an ADR, a pointer from AGENTS.md. Tie between two words? Count them in the code.
- Script line: "What a new colleague needs to know, the agent needs to know too, and we decide the words."

**Knowledge lives in one head (e.g. a colleague who's leaving)** · level 0–3 · step 1
- Idea: when the blocker is in someone's head, ask targeted questions on the gap; the answers feed the domain language. (Matt: to-questionnaire, domain-modeling)
- Concrete: the agent builds a questionnaire aimed at what's missing; fold the answers into glossary and ADRs; that colleague reviews what the agent builds.
- Script line: "Your knowledge is exactly what the agent lacks. Let's capture it."

### Foundations · steps 2–6

**Migration, greenfield or a feature too big for one session** · level 2–4 · step 2
- Idea: a map of decisions, one per fresh session; spec and tickets follow afterwards. Don't start there: switch when a grill grows past the dumb zone. (Matt: wayfinder → to-spec → to-tickets → implement-spec)
- Concrete: one map issue with decision tickets typed as grilling, research, prototype or task; resolve one per session; bundle into a spec at the end.
- Script line: "We don't need to build today. We need to know which decision comes first."

**A design or vendor question won't get settled on paper** · level 2–3 · step 2
- Idea: decide at the right fidelity; prototyping is where to spend tokens. (Matt: prototype)
- Concrete: a prototype ticket: the agent builds 2 or 3 variants on a throwaway branch, the team picks, the decision goes into the ticket or an ADR; the code stays off main.
- Script line: "We build this in an hour to choose, not to keep."

**A lot of reading is needed before a decision** · all levels · step 2
- Idea: a research ticket: a subagent reads primary sources and writes a cited file that feeds the grill. (Matt: research)
- Concrete: one research question, a markdown file with sources in the repo, discussed in the next grill.
- Script line: "Let the agent read this while we keep working."

**Review is the bottleneck** · level 3 · step 3
- Idea: brakes before speed: three brakes, cheapest first. Machines catch the mechanical, a fresh review agent fixes against standards and spec, humans review by risk. (Matt: code-review, pr)
- Concrete: one slice per PR; types, tests and lint required in CI; a review agent in a fresh session with the spec, which fixes rather than comments; a PR body with summary, before/after evidence and merge danger; human depth set by door and blast radius.
- Script line: "Is this a one-way or a two-way door, and what breaks if it's wrong?"

**The same review comments keep coming back; the retro is only about people** · level 2–3 · step 4
- Idea: never the same comment twice. A comment becomes a check if the code alone can show the problem, otherwise a coding standard for the review agent; stale or process rules get deleted. (Matt: retro)
- Concrete: list last month's repeated comments; write each as a rule; sort with the rule-to-check tree (`course.md`, ch. 5). Add "what should the agent's environment do better?" to the team retro: one action per retro.
- Script line: "If we write this comment a second time, it becomes a check."

**The team puts all its rules in AGENTS.md (or copilot-instructions), and it keeps growing** · level 2–3 · step 4
- Idea: hide the standards from the implementer; the implementer makes it work, a fresh reviewer makes it good. AGENTS.md stays short. (Matt: code-review, writing-for-agents)
- Concrete: move coding standards to a file only the review agent reads; turn what can be a check into a check; prune the rest.
- Script line: "The builder doesn't need the rulebook. The reviewer does."

**Legacy nobody dares touch; copied logic; tests that only repeat the code** · level 3 · step 5
- Idea: agents are tactical tornadoes; deep modules make bad tests impossible to write; don't ban agent-written tests, fix the codebase. (Matt: improve-codebase-architecture, codebase-design)
- Concrete: point the scan at the file the team already suspects; pick one candidate to delete or deepen; lay a seam with a test; add a narrow boundary rule plus a coding standard so it stays that way.
- Script line: "We start with one place where we can test."

**Checks are slow, skipped or noisy; the agent breaks the build** · level 2–3 · step 6
- Idea: determinism every time; pre-commit under ~3 s on staged files; CI is the only hard stop; error messages carry the fix. (Matt: retro)
- Concrete: measure the hook; move tests out of it; add format, lint, typecheck and boundaries in parallel; make every error say what to do next; make CI required.
- Script line: "What do we catch by hand today that a check could catch in three seconds?"

**Stubborn or intermittent bug; agent fixes bugs badly** · level 2–3 · step 6
- Idea: first a loop that goes red on the bug; give the agent eyes (logs, database, browser); keep the regression test. (Matt: diagnosing-bugs → retro)
- Concrete: one command that goes red on *this* bug; give the agent read access to the data it needs; fix, keep the test; retro: which check or seam was missing?
- Script line: "Can we get the bug reliably red first, and what can't the agent see?"

**Tests pass, but bugs still slip through** · level 3 · step 6
- Idea: test the tests: a surviving mutant is a missing test. Information, not a gate. (course: mutation-testing)
- Concrete: run mutation testing on the changed lines of one PR; turn each surviving mutant into a test.
- Script line: "Let's check whether our tests would notice if the code were wrong."

### Factory · steps 7–8

**Pressure to "go faster with agents" before the brakes are there** · any level
- Idea: brakes before speed; without check and review layers, a factory is a slop cannon. (Matt: retro, code-review)
- Concrete: list which of steps 3, 4 and 6 hold; the missing one is the next step, not more agents.
- Script line: "Which brakes need to be in place before we let the agent work alone?"

**What may the agent do alone (AFK)?** · level 3–4 · step 7
- Idea: start with review, not implementation; agent confidence never decides a merge; auto-merge only two-way, small blast radius, no data migration. Steps only a human can do become a script. (Matt: code-review, wizard)
- Concrete: one label-triggered step (review first) in a sandbox; `needs-a-human` for decisions; manual steps (secrets, dashboards) as a wizard script.
- Script line: "We let the agent alone on the step where a mistake is cheapest to catch."

**Incoming bugs and requests pile up** · level 3–4 · step 7
- Idea: intake and triage make raw input agent-ready; an explore agent reproduces and groups. (Matt: triage)
- Concrete: fixed labels (needs-info, ready-for-agent, needs-a-human); clarify each issue until it can be executed on its own; later, an explore step on a label.
- Script line: "Which issue could an agent pick up alone tomorrow, and what's missing from the rest?"

**The team wants agents on a schedule or on events (nightly jobs, monitors)** · level 4 · step 8
- Idea: every loop needs a stop; determinism first; pull signals, don't push them. (course: software-factory)
- Concrete: design one loop on one page (Trigger · Task · Brake · Output · Human); script what can be scripted; start with a ratchet or a daily scan with a hard limit on open PRs; add observability later.
- Script line: "If we can't name the brake, we don't build the loop."
