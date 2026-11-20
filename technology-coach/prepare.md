# Prepare

The goal: a **game plan** for an upcoming meeting with a team, which Dave reads in two minutes beforehand.

Dave usually starts from a **case**: a team with its architecture, stack, processes and AI knowledge, and the question how to move it forward on AI enablement.

1. **Gather** what is missing:
   - *team*: who, roles, AI experience per person
   - *architecture and stack*: language, architecture, tests, CI, which Copilot features are enabled
   - *processes*: how work flows from idea to production (refinement, review, release)
   - *case*: the goal, what they ask of Dave
   - *format*: presentation, lunch & learn, one-on-one call or workshop; duration, audience size, first meeting or follow-up. Without a format: propose the one that fits the rung.
2. **Diagnose** on the ladder (in `SKILL.md`): pick the rung and name the signals and assumptions.
3. **Lay out the path**: 2 to 4 steps from the current rung toward the next, each tied to a route from `routes.md`. The path is what the team walks after the meeting; the meeting puts them on its first step.
4. **Fill in the game plan** below, block by block, with the source between ⟨⟩. Build the Plan block from the matching format skeleton. Take Copilot tips from `copilot.md`.

```
## Game plan: [team/case], [date], [format]
**Rung:** [n – name] · signals: [...] · assumptions: [...]
**Path:**  ⟨routes.md⟩
1. [step] · route: [...]  ← goal of this meeting
2. [step] · route: [...]
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

**Done when:** every block is filled in, every path step names its route, every Plan part has a script line specific to *this* case, and Dave reads the whole thing in two minutes.

## Format skeletons

### Presentation or lunch & learn

One idea and one demo; the rest of the path goes to a follow-up.

1. **Hook.** Their pain in their words: the signals of their rung.
   Script line: "Who recognises this: [signal]?"
2. **Matt's idea.** The one principle behind path step 1, with one picture or metaphor.
3. **Demo on their stack.** Show path step 1 on code like theirs, in the Copilot features they have.
4. **One thing to try this week.** Path step 1, small enough to start Monday.
   Script line: "If you try one thing this week, make it this."
5. **Q&A and next step.** Fallback lines ready; invite them to a call or workshop for path step 2.

### One-on-one call or workshop: "How do we tackle this?"

The main route as a conversation; works for every case and every stack.

1. **Set the scene.** Rung, who's at the table, today's goal.
   Script line: "Tell me how you'd tackle this today, without AI."
2. **Grill the case, not the code.** Goal, user, when is it done, which terms does the team use? Pin the terms down. Result: a short spec, written together or with the agent.
   Script line: "Let's get this sharp together before we build anything."
3. **Slice into tracer bullets.** The smallest piece that works end-to-end through all layers. Too big for one session: wayfinder.
   Script line: "What's the smallest piece we can actually show working next week?"
4. **Set the brakes.** A test at the right seam, an automated check, review by a colleague.
   Script line: "How would we notice the agent doing something wrong?"
5. **Agreement and retro.** Who does the first slice with the agent, and when? Then a 15-minute retro: what should the agent know better next time?
   Script line: "We do one slice, then look together at what we tell the agent better next time."

## Stack checklist

Every answer is a brake or a gap.

- **Types**: statically typed? The compiler is a free brake.
- **Tests**: are there tests, how long do they take, can the agent run them itself?
- **CI**: what runs automatically on a pull request?
- **Linting**: which rules, and are they enforced?
- **Running locally**: how do you start the application, how long does a build take?
- **Boundaries**: where are the modules? Which code does nobody dare touch?
- **Domain language**: is there a glossary? Are decisions in ADRs?
- **Copilot**: which features and models are enabled?
- **Data**: which data may the agent see? Where are the secrets?

## Fallback lines

Every fallback line starts a method.

- "Good question. Let's get it sharp together first." → grill.
- "You know this stack better than I do. Let's have the agent explore the code and look together at what it finds." → codebase exploration; the team stays the expert.
- "Let's make it smaller. What's the first slice?" → tracer bullet.
- "What would a new colleague need to know to do this well? That's exactly what the agent needs to know too." → AGENTS.md and domain language.
- "I don't know that off the top of my head. I'll find out and get back to you this week." → always allowed; put it on the retro list.
