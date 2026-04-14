# Discovery Discipline

## 1. Discover before implementing

Before planning any implementation or refactor, use search tools to establish full 
context across the codebase. Never assume a single file contains the whole picture.

## 2. Check your symbols before you wreck your symbols

When a new type, function, or module name is encountered mid-task that could
have multiple call sites or implementations, search for all references before
reading individual files.

## 3. Enumerate before you edit

When renaming, moving, or deleting anything, enumerate all references first.

Incomplete discovery during refactors causes broken imports and contract violations
that are expensive to untangle.

## 4. Search is your friend

Search is cheaper than incorrect edits. Default to broad discovery first, then
narrow to specific files.
