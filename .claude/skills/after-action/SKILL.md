---
name: after-action
version: 1.0.0
description: |
  Task wrap-up and self-evolution. Review what happened, extract lessons,
  archive logs, back up with git. The closing ritual for every work session.
  Triggers: "wrap up", "archive", "AAR", "after action", "收官"
tags: [meta, evolution, memory, archive]
---

# 🔄 After Action — Task Wrap-Up & Learning

> Done but not archived = not done. Every action feeds the next one.
>
> **Core attitude: always find N→N+1.**
> Wrapping up isn't just "recording what happened" — it's "finding what can be better next time."
> Perfection isn't the goal. Continuous evolution is. Today's system is always tomorrow's starting point.

---

## Triggers

Any of these activate this skill:
- "wrap up" / "archive" / "AAR" / "after action"
- "收官" / "歸檔" / "整合經驗"
- End of a long work session
- After completing a complex multi-step task

---

## 🎯 Execution Flow

### Step 1: Inventory — What happened?

List everything:
- Tasks completed
- Decisions made
- Files created or modified
- Problems encountered and solved

### Step 2: Extract — What did we learn?

From each completed task, pull out:
- **Problems** → solutions → how to prevent next time
- **New best practices** discovered
- **Performance data** (time spent, what worked, what didn't)

Write to daily log: `memory/YYYY-MM-DD.md`

### Step 3: Archive — Write it down

**1. Daily log** — `memory/YYYY-MM-DD.md`
- Complete record of the day
- Format: time, event, decision, output, lesson

**2. Long-term memory** (for significant events) — `MEMORY.md`
- New cognitive breakthroughs
- Important decisions with context
- Systemic changes (before/after)

### Step 4: Reflect — What really happened?

Not mechanical archiving — actually think about it.

**Four required questions:**
1. **What went right** — Most valuable output today? Why?
2. **What to watch** — Any bad patterns forming? Time/energy spent wisely?
3. **The real issue** — What's the actual underlying thing going on?
4. **N→N+1** — Based on everything today, what's the most natural next step? Not "what should I do" but "if I follow today's momentum, where does it lead?"

**Tone:** Direct, honest, but caring. This isn't a performance review — it's a debrief between partners.

### Step 5: Evolve — Grow from experience

1. **Lessons** → write to relevant skill files or SOUL.md
2. **Soul-level updates** — If a lesson is systemic, recurring, or violates core principles → must be recorded in SOUL.md
3. **Micro-improvements** — Spot automatable repetitive tasks → build script/alias
4. **N→N+1 list** — For each skill/system/process, write one specific "can be better next time" point

### Step 6: Backup — Git commit + push

```bash
cd /path/to/workspace
git add -A
git commit -m "🔄 after-action: $(date +%Y-%m-%d\ %H:%M) — wrap up"
git push
```

---

## 📋 Verification Checklist (Gate Check)

> **Rule: Before announcing "wrap-up complete", every item must be checked. Missing any = not complete.**

```
□ Step 1: Inventory — all tasks listed?
□ Step 2: Extract — lessons written?
□ Step 3: Archive — daily log complete?
□ Step 4: Reflect — four questions answered? (not one-liners)
□ Step 5: Evolve — lessons distributed? Soul updated if needed?
□ Step 6: Git — committed and pushed?
```

### Pre-Report Self-Check

Before saying "wrap-up done", ask yourself:
1. Are all boxes checked above?
2. Is there anything I "thought I did" but actually just thought about?
3. If my human asks "what did you do in Step X?", can I give a specific answer?

**If any answer is no → go back and finish. Don't announce completion.**

---

## ⚡ One-Trigger Mode

When your human says "wrap up" or "archive", don't ask questions. Run all steps.

Report format:
```
🔄 Wrap-up complete

📊 Today's activity:
  - [summary of what was done]

💭 Reflection:
  [What went right / What to watch / The real issue — direct and honest]

🧬 Evolution:
  - X lessons extracted
  - [any soul-level updates]

🔒 Git:
  - ✅ committed: [hash]
```

---

## 🧠 When to auto-trigger?

| Timing | Condition |
|--------|-----------|
| Before sleep | 22:00-23:00 and significant work was done |
| After big project | Complex multi-step task just finished |
| Human leaving | Detected "that's it for now", "gotta go", "talk later" |
| Context getting full | Pre-compaction flush |

---

## ⚠️ Notes

- **Don't build new features during wrap-up** — this is organizing, not developing
- **Lessons must be specific** — "had a problem" isn't enough. What problem? What solution? How to prevent?
- **Git message uses 🔄** — distinguishes wrap-up commits from feature commits

---

*"Did it but didn't record it = didn't do it. Recorded but didn't push = didn't record."*
