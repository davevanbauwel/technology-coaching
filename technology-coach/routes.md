# Routes

One route per team situation. The concept comes first; Matt's skill names follow in brackets as reference.

**As of:** checked against Matt's ask-matt-router (github.com/mattpocock/skills) on 20 November 2026. When a skill name no longer seems right, say so and suggest checking it.

**Main route:** grill → (prototype) → spec → tracer-bullet tickets → build with TDD → review → retro. Grill, spec and tickets in one uninterrupted context; after that, each ticket in a fresh session.

**Route format:**
```
**[Situation]** · rung [n]
- Idea: [Matt's principle]. (Matt: [skills])
- Concrete: [what the team does this week]
- Script line: "[...]"
```

### Building

**Refinement produces vague stories; the agent builds the wrong thing** · rung 2
- Idea: grill before you build; the spec is the agreed destination; slice into tracer bullets. (Matt: grill-with-docs → to-spec → to-tickets → implement)
- Concrete: take one story, let the agent question the team until "done" is sharp, write a one-page spec in the repo, slice into 2 to 4 slices as issues, new chat per slice.
- Script line: "Before we prompt, we grill this story until we know when it's done."

**The agent derails halfway through a big task** · rung 1–2
- Idea: the smart zone is limited; plan in one context, execute per self-contained ticket. (Matt: to-spec → to-tickets → implement)
- Concrete: stop the task, turn it into tickets that each stand on their own, start a new session per ticket with only that ticket as context.
- Script line: "Let's give the agent one ticket at a time, on a clean table."

**A design question won't get settled on paper** · rung 2
- Idea: answer one question with throwaway code; the decision carries forward, the code is source. (Matt: prototype, handoff)
- Concrete: separate branch or folder, the agent builds a minimal version (UI, data model), decide, record the decision in the issue.
- Script line: "We're building this in an hour to choose, not to keep."

**Stubborn or intermittent bug** · rung 2–3
- Idea: first a tight feedback loop that goes red on the bug; fix with a regression test; then: what would have prevented this? (Matt: diagnosing-bugs → retro)
- Concrete: one command that goes red on *this* bug, then fix, keep the test, retro: which check or seam was missing?
- Script line: "Can we get the bug reliably red first?"

### Backlog and refinement

**Incoming bugs and requests pile up** · rung 2–3
- Idea: triage makes raw input agent-ready; tickets from your own spec already are. (Matt: triage → implement)
- Concrete: fixed labels (needs-info, ready-for-agent, needs-human), clarify each issue until it can be executed on its own.
- Script line: "Which issue could an agent pick up alone tomorrow, and what's missing from the rest?"

### Ceremonies

**The retro is only about people; the agent keeps making the same mistakes** · rung 2–3
- Idea: the retro improves the agent's environment. Mechanical mistakes become checks, judgement mistakes become standards or instructions. (Matt: retro)
- Concrete: add to the team retro the question "What should the agent know better next time?" One action per retro: AGENTS.md, a lint rule or a test.
- Script line: "Every mistake that happens twice becomes a rule or a check."

**Review is the bottleneck** · rung 3
- Idea: brakes first. Machines catch the mechanical; humans review against spec and standards. (Matt: code-review, pr, retro)
- Concrete: one slice per PR, types/tests/lint required in CI, review in two questions (does it follow the standards? does it do what the spec says?), PR description with proof that it works.
- Script line: "What do we catch by hand today that a check could catch?"

### Team knowledge

**New colleagues, or the agent confuses terms** · rung 1–3
- Idea: one domain language for human and agent: glossary, ADRs, a short AGENTS.md that points onward. (Matt: domain-modeling, grill-with-docs, writing-for-agents)
- Concrete: glossary with the 10 terms that go wrong most, one recent hard decision as an ADR, a pointer from AGENTS.md.
- Script line: "What a new colleague needs to know, the agent needs to know too."

**Experienced colleagues without AI experience (e.g. close to retirement)** · rung 0
- Idea: their domain knowledge is exactly what the method needs; AI amplifies their expertise. (Matt: domain-modeling, code-review)
- Concrete: start with their own code and a small, visible win; make them the source of the domain language and reviewer of what the agent produces.
- Script line: "You know what's right. The agent types, you decide."

**Knowledge lives in one head (e.g. a colleague who's leaving)** · rung 0–3
- Idea: when the blocker is in someone's head, ask targeted questions on the gap; the answers feed the domain language. (Matt: to-questionnaire, domain-modeling)
- Concrete: the agent builds a questionnaire aimed at what's missing; fold the answers into glossary and ADRs; that colleague reviews what the agent builds.
- Script line: "Your knowledge is exactly what the agent lacks. Let's capture it."

**Legacy nobody dares touch** · rung 3
- Idea: explore with the agent, look for chances to make modules deeper, lay seams so you can test. (Matt: improve-codebase-architecture, codebase-design)
- Concrete: the agent maps one module, pick one deepening opportunity, lay a seam with a test, carry the improvement into the main route.
- Script line: "We start with one place where we can test."

### Agentic workflow

**Long sessions; the agent gets dumber along the way** · rung 1–2
- Idea: decide at a phase boundary: continue, clear, handoff, subagent or compact (the default). (Matt: phase boundaries, handoff)
- Concrete: after planning, after building, after testing: do I still need this context? Side track → subagent. Other folder or colleague → handoff note.
- Script line: "We're done planning. Do we take this context along, or start fresh?"

**What may the agent do alone (AFK)?** · rung 3–4
- Idea: AFK only for self-contained tickets with good brakes; the human decides on spec, design and what's missing; steps only a human can do become a script. (Matt: implement-spec, wizard)
- Concrete: list which tickets have tests, CI and a clear spec; only those go to the cloud agent. Write manual steps (secrets, dashboards) out as a script.
- Script line: "Which brakes need to be in place before we let the agent work alone?"

**A lot of reading is needed before a decision** · all rungs
- Idea: delegate the reading to a background agent with citations; the result feeds the grill. (Matt: research)
- Concrete: one research question, a markdown file with sources in the repo, discuss it in the next grill.
- Script line: "Let the agent figure this out while we keep working."

### Big, unclear initiatives

**Migration, greenfield or a feature too big for one session** · rung 2–4
- Idea: wayfinder: a map of decisions, one resolved per session. That yields decisions; spec and tickets follow afterwards. (Matt: wayfinder → to-spec → to-tickets)
- Concrete: list the open decisions as issues with dependencies, decide one per session, bundle everything into a spec afterwards.
- Script line: "We don't need to build today. We need to know which decision comes first."

## Glossary

Only Matt's own meanings; use common terms (context window, subagent, skill, deep module) as they are generally known.

- **Smart zone / dumb zone**: sharp reasoning with a lean context, sagging as it fills up.
- **Compaction vs handoff**: compaction summarises within the session; a handoff note starts a new one. Mid-task: handoff.
- **Phase boundary**: the moment after planning, building or testing to decide about context.
- **Grilling**: questioning a vague idea until the requirements are sharp.
- **Spec**: the agreed destination: what we build, when it's done.
- **Tracer bullet**: thin vertical slice that works end-to-end through all layers.
- **Wayfinder**: map of decisions for work too big for one session.
- **Domain language**: shared glossary and ADRs, for human and agent.
- **Feedback loop**: anything that quickly tells the agent something is wrong (types, tests, lint). Good = tight and can go red.
- **Brakes / accelerators**: brakes raise quality, accelerators raise pace. Brakes first.
- **AFK / HITL**: agent works alone, or with a human in the loop.
- **Retro**: after work with the agent: what should the agent's environment do better?
