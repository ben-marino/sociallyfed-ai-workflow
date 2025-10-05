# Daily Development Brief Template

Use this template to structure daily briefs for consistent context across development sessions.

---

# Daily Development Brief - [DATE]

Generated at: [TIME]

## Overview

Brief summary of current sprint/phase and overall project status.

## Current Branch & Status

- Branch: `[branch-name]`
- Status: [Up to date / Behind origin / Ahead of origin]
- Last commit: "[commit message]"

## Git Status

```
[Output of git status --short]
```

## Recent Commits (Last 5)

```
[Output of git log --oneline -5]
```

## Yesterday's Progress

### Completed
- [ ] Feature/Task 1
- [ ] Feature/Task 2
- [ ] Bug fix #XXX

### Partially Complete
- [ ] Feature/Task (X% complete)

### Blocked
- [ ] Task - Reason for blockage

## Today's Priorities

1. **High Priority**
   - [ ] Critical feature or bug
   - [ ] Blocking issue resolution

2. **Medium Priority**
   - [ ] Feature development
   - [ ] Code review

3. **Low Priority**
   - [ ] Documentation updates
   - [ ] Refactoring

## Blocking Issues

- **Issue 1**: Description and impact
  - Attempted solutions: 
  - Next steps:

- **Issue 2**: Description and impact
  - Dependencies:
  - Proposed resolution:

## Code Health Metrics

- Test Coverage: X%
- Build Status: ✅ Passing / ❌ Failing
- Linting Issues: X
- Technical Debt Items: X

## TODO Items in Code

```
[Grep results for TODO/FIXME/HACK comments]
```

## Environment Check

### Required Tools
- ✅ git: [version]
- ✅ dotnet: [version]
- ✅ node: [version]

### Optional Tools
- ✅ docker: [version]
- ⚠️ [tool]: Not found

## Context for Senior Claude

### Questions for Architecture/Planning
1. [Specific architectural decision needed]
2. [Design pattern clarification]
3. [Performance optimization approach]

### Areas Needing Specification
1. [Feature that needs detailed spec]
2. [Integration point that needs design]

## Notes & Reminders

- Remember to maintain 80%+ test coverage
- Focus on privacy-first implementation
- Update implementation reports after major features
- Check performance metrics after optimization work
- Review security implications of new features

## Relevant Links

- [Link to current sprint board]
- [Link to architecture docs]
- [Link to API documentation]

---

*Template for daily development briefs - customize as needed for your project*