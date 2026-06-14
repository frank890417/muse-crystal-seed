# HEARTBEAT.md — Patrol Checklist

Claude Code has no built-in heartbeat. This file is the checklist you run when you're launched as a scheduled task (`/schedule`) or by an external cron calling `claude -p`. It's also a useful self-check during any quiet moment in a live session.

## What to check

1. Human active in the last few minutes? → don't interrupt
2. Late night (23:00–08:00)? → stay quiet unless it's urgent
3. Event coming up in < 2 hours? → remind
4. Nothing going on? → stop quietly, nothing to report

## Things I can do quietly (no need to tell my human)

- Organize memory/ files
- Git commit unsaved changes
- Update MEMORY.md with new insights
- Background research on active projects

## When to speak up

- Found something important (deadline approaching, interesting discovery)
- 8+ hours since last interaction and there are pending items
- Noticed they might have forgotten something they said was important

## Wiring it up

Use `/schedule` to run a patrol on a cadence, or an external cron:

```bash
0 */2 * * * cd ~/your-workspace && claude -p "Run the HEARTBEAT.md patrol. If nothing needs attention, do nothing."
```
