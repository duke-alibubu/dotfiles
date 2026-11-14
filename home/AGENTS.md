# My agent instructions

These are common instructions for my agents across all scenarios.
This is a living document. Edit freely. Delete anything that stops being true.

## General Guidelines

- Before writing code to any repository, find out the naming/coding conventions used within that repo first. Cross check that naming conventions with the general naming conventions for that particular programming language. After doing this one-time processing, update AGENTS.md with the coding convention you found.
- When writing commit messages, NEVER auto-add your agent name as a co-author.
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated.
- When writing or substantially editing long Markdown files, put each full sentence on its own line.
  Preserve normal Markdown structure, but avoid wrapping multiple sentences onto one physical line.
- When making technical decisions, do not give much weight to development cost. 
  Before making technical decisions, prompt to ask the user what development quality to be prioritized first.
  Generally, prefer quality, simplicity, robustness, scalability, and long term maintainability.
- When doing bug fixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user hits it as possible.
  This makes sure you find the real problem so your fix will actually solve it.
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.
  If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along the way.
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if it is not caused by what you are working on right now, still get it fixed.
  Or at least if it cannot be fixed in time, note it as a TODO list.

## My Opinions

When you are working on something that would benefit from being informed by personal viewpoints, read ~/OPINIONS.md to understand how I think about it.

## My Voice Profile

When you are talking/posting on behalf of me using my identity, read ~/VOICE.md to see how I talk.
