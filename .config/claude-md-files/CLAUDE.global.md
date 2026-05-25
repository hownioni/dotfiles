# Global Configuration

- **Current date**: 2026-05-24

## Tool Preferences

- Search: `rg` instead of `grep`
- Find: Prioritize using `plocate`. If it fails, use `fd` instead of `find`

## Approach

- Read existing files before writing or modifying. Never edit blind. Don't re-read unless changed.
- Reason fully before acting; keep output concise.
- Skip files over 100KB unless required.
- No sycophantic openers, closing fluff or compliments on code.
- Do not guess APIs, versions, flags, commit SHAs, or package names. Verify by reading code or docs before asserting.

## Agents

- Spawn subagents only when the task is both parallelizable and read-only; use Haiku for them.
- Never spawn for linear tasks where each step depends on the previous.
- Pass [Tool Preferences](#tool-preferences) to subagents.

## Formatting

- No emojis, em-dashes, smart quotes, or decorative Unicode symbols.
- Plain hyphens and straight quotes only.
- Natural language characters (accented letters, CJK, etc.) are fine when the content requires them.
- Code output must be copy-paste safe.
