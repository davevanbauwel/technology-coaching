# Prepare

The goal: a **game plan** for an upcoming meeting with a team or an individual, which Dave reads in two minutes beforehand. Dave directs: he picks the direction from three options before the plan is written.

Dave usually starts from a **case**: a team with its architecture, stack, processes and AI knowledge, and the question how to move it forward.

1. **Gather** what is missing:
   - *team*: who, roles, AI experience per person
   - *architecture and stack*: language, architecture, tests, CI
   - *processes*: how work flows from idea to production (refinement, review, release)
   - *case*: the goal, what they ask of Dave
   - *format*: presentation, lunch & learn, call or workshop; duration, audience size, first meeting or follow-up. Without a format: propose the one that fits the level.
2. **Diagnose** the level and the next ladder step (`SKILL.md`, The path): name the signals and assumptions. Every option in step 3 starts from here.
3. **Recommend three options, then stop.** Three different next steps for a team on *this* level, each built on a different route from `routes.md`. Not three versions of one plan, not options from another level. Per option:
   ```
   **[A/B/C]. [title]** · route: [...] · step [k]
   - Why now: [signal from the case]
   - Trade-off: [what it costs or risks]
   ```
   Mark one as recommended, with one line why. Close with: "Which one, or do you have another direction?" Then wait. Write and save nothing before Dave chooses. Skip this step when Dave already names the topic or route.
4. **Lay out the path**: 2 to 4 ladder steps from where the team is, each with its route. Step 1 is the option Dave chose. Never put steps 7–8 before 3, 4 and 6 hold. The path is what the team walks after the meeting; the meeting puts them on its first step.
5. **Fill in the game plan** below, block by block, with the source between ⟨⟩. Build the Plan block from the matching format skeleton. Copilot tips from `copilot.md`.

```
## Game plan: [team/case], [date], [format]
**Level:** [n – name] · signals: [...] · assumptions: [...]
**Matt's line for this team:** [one of the three lines, in a sentence for them]
**Path:**  ⟨ladder + routes.md⟩
1. [step k: ...] · route: [...]  ← goal of this meeting
2. [step k: ...] · route: [...]
**Goal of this meeting:** [one sentence: path step 1, fitting the format]

### Plan  ⟨format skeleton, filled in for this case⟩
1. [part] – [what Dave does] · Script line: "[...]"
...
### Stack questions  ⟨3–5 from the Stack checklist, highest yield for this case; for a presentation: settle them with the contact person beforehand⟩
### Copilot tips  ⟨2–3 from copilot.md, only what matters now⟩
### If you're stuck  ⟨2 fallback lines⟩
### Pitfalls  ⟨max. 3: [pitfall] → [what Dave does then]⟩
### Watch for your retro  ⟨2 things to observe during the meeting⟩
```

**Done when:** the plan builds on the option Dave chose, every block is filled in, every path step names its ladder step and route, every Plan part has a script line specific to *this* case, and Dave reads the whole thing in two minutes.

## Format skeletons

### Presentation or lunch & learn

One idea and one demo; the rest of the path goes to a follow-up.

1. **Hook.** Their pain in their words: the signals of their level.
   Script line: "Who recognises this: [signal]?"
2. **Matt's idea.** The one of the three lines behind path step 1, with one picture (the ladder, the three brakes, the door/blast-radius tree).
3. **Demo on their stack.** Path step 1 on code like theirs, in the Copilot features they have.
4. **One thing to try this week.** Path step 1, small enough to start Monday.
   Script line: "If you try one thing this week, make it this."
5. **Q&A and next step.** Fallback lines ready; invite them to a call or workshop for path step 2.

### Call or workshop: "How do we tackle this?" (levels 1–3)

The first ladder steps as a conversation on one real piece of work; works for every stack.

1. **Set the scene.** Level, who's at the table, today's goal.
   Script line: "Tell me how you'd tackle this today, without AI."
2. **Grill the case, not the code.** Goal, user, when is it done, which words does the team use? The agent proposes terms, the team decides; they go into GLOSSARY.md.
   Script line: "Let's get this sharp together before we build anything."
3. **Size it.** Tiny diff → one-shot. Fits a session → spec and 2 to 4 tracer-bullet tickets. Bigger → a wayfinder map with the first decision ticket.
   Script line: "What's the smallest piece we can actually show working next week?"
4. **Set the brakes.** Which check catches it, who reviews (a fresh review agent with the spec), how much human review (door and blast radius)?
   Script line: "How would we notice the agent doing something wrong?"
5. **Agreement and retro.** Who does the first ticket with the agent, and when? Afterwards 15 minutes of retro: which comment or mistake becomes a check or a standard?
   Script line: "We do one slice, then turn what went wrong into a rule."

### Loop design session (levels 3–4)

One recurring job designed as a factory loop; nothing runs before the brake is named.

1. **Pick the job.** Something that recurs and has a cheap failure (lint ratchet, review of every PR, daily architecture scan, rebase).
   Script line: "Which job do you do every week that you'd rather never think about?"
2. **Brake check.** Which of checks, agent review and CI already hold for this job? A missing brake becomes the first step.
3. **Draw it on one page.** Trigger · Task · Brake · Output · Human.
   Script line: "If we can't name the brake, we don't build the loop."
4. **Determinism first.** What can a script do? The agent only handles the rest.
5. **First run.** Review-only or one PR at a time, no auto-merge; agree when to look at cost and success together.
   Script line: "We start slow on purpose. The factory earns its speed."

## Stack checklist

Every answer is a brake or a gap.

- **Types**: statically typed? The compiler is a free brake.
- **Tests**: are there tests, how long do they take, can the agent run them itself? Would they catch wrong code (mutation testing)?
- **Pre-commit**: is there a hook, how long does it take (target ≈ 3 s), what's in it?
- **CI**: what runs on a pull request, and is it required? CI is the only hard stop.
- **Linting**: which rules, enforced? Custom rules for the team's own mistakes?
- **Boundaries**: where are the modules, and does a tool enforce them? Which code does nobody dare touch?
- **Domain language**: is there a glossary? Are decisions in ADRs?
- **Review**: who reviews, how long does a PR wait, is there an agent review? Which comment comes back most?
- **Agent's eyes**: can the agent read logs, a test database, the browser, the bug tracker?
- **Tracker and automation**: which issue tracker, labels, and who may run workflows (for steps 7–8)?
- **Copilot**: which features and models are enabled (agent mode, cloud agent, code review, CLI)?
- **Data**: which data may the agent see? Where are the secrets?

## Fallback lines

Every fallback line starts a method.

- "Good question. Let's get it sharp together first." → grill.
- "You know this stack better than I do. Let's have the agent explore the code and look together at what it finds." → codebase exploration; the team stays the expert.
- "Let's make it smaller. What's the first slice?" → tracer bullet.
- "What would a new colleague need to know to do this well? That's exactly what the agent needs to know too." → AGENTS.md and domain language.
- "If we write this comment a second time, it becomes a check." → retro, rule to check.
- "Is this a one-way or a two-way door?" → how much human review.
- "I don't know that off the top of my head. I'll find out and get back to you this week." → always allowed; put it on the retro list.
