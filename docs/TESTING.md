# Testing Documentation

Guide to testing the SociallyFed AI Workflow.

## Table of Contents

- [Overview](#overview)
- [Manual Testing](#manual-testing)
- [Script Testing](#script-testing)
- [Workflow Testing](#workflow-testing)
- [Pre-Release Checklist](#pre-release-checklist)

---

## Overview

### What We Test

1. **Scripts** - All bash scripts function correctly
2. **Workflow** - End-to-end development process works
3. **Integration** - Components work together
4. **Documentation** - Instructions are accurate
5. **Examples** - Templates and examples work

### Testing Approach

Currently all testing is manual. Future versions may include automated testing.

---

## Manual Testing

### Pre-Release Checklist

**Before any release, verify:**

#### Setup & Installation
- [ ] Fresh clone works
- [ ] Setup wizard completes
- [ ] Google Drive detected correctly
- [ ] Project structure created
- [ ] Scripts made executable
- [ ] Configuration saved correctly

#### Core Scripts
- [ ] `setup.sh` completes successfully
- [ ] `start-dev-session.sh` creates brief
- [ ] `provide-context.sh` loads context
- [ ] `update-implementation.sh` updates docs
- [ ] `push-implementation.sh` commits and pushes
- [ ] `end-dev-session.sh` archives session

#### Documentation
- [ ] README accurate and complete
- [ ] All links work
- [ ] Examples match current version
- [ ] Setup instructions clear
- [ ] Troubleshooting covers common issues

#### Cross-Platform
- [ ] Works on macOS
- [ ] Works on Linux
- [ ] Works on WSL
- [ ] Path handling correct
- [ ] Line endings appropriate

---

## Script Testing

### Testing Individual Scripts

#### 1. Syntax Validation

```bash
# Check for syntax errors
bash -n scripts/start-dev-session.sh

# All scripts
for script in scripts/*.sh; do
    echo "Checking $script..."
    bash -n "$script" || echo "FAILED: $script"
done
```

#### 2. ShellCheck Validation

```bash
# Install shellcheck
brew install shellcheck  # macOS
sudo apt install shellcheck  # Linux

# Check all scripts
shellcheck scripts/*.sh
```

#### 3. Dry Run Testing

```bash
# Run script with debug output
bash -x ./scripts/start-dev-session.sh
```

### Script Test Cases

#### `setup.sh`

**Test Cases:**

1. **Fresh Installation**
   ```bash
   # Prerequisites: Clean system, no config
   ./scripts/setup.sh
   # Expected: Complete setup, config created
   ```

2. **Existing Configuration**
   ```bash
   # Prerequisites: Already configured
   ./scripts/setup.sh
   # Expected: Detects existing, offers reuse
   ```

3. **Invalid Google Drive Path**
   ```bash
   # Prerequisites: Non-existent path provided
   ./scripts/setup.sh
   # Expected: Error message, retry option
   ```

#### `start-dev-session.sh`

**Test Cases:**

1. **First Run**
   ```bash
   # Prerequisites: Fresh setup
   ./scripts/start-dev-session.sh
   # Expected: Creates directory structure, generates brief
   ```

2. **Subsequent Run**
   ```bash
   # Prerequisites: Previous session exists
   ./scripts/start-dev-session.sh
   # Expected: New brief, references previous session
   ```

3. **Missing Configuration**
   ```bash
   # Prerequisites: No config file
   ./scripts/start-dev-session.sh
   # Expected: Error message, suggests running setup
   ```

---

## Workflow Testing

### End-to-End Testing

**Test the complete one-hour sprint:**

#### Test Procedure

1. **Start Session (0-5 min)**
   ```bash
   ./scripts/start-dev-session.sh
   ```
   - [ ] Brief created
   - [ ] Contains relevant context
   - [ ] Includes today's date
   - [ ] Has suggested prompts

2. **Strategic Planning (5-15 min)**
   - [ ] Open brief in Claude Chat
   - [ ] Discuss architecture
   - [ ] Get useful responses
   - [ ] Make decisions

3. **Provide Context (15-20 min)**
   ```bash
   ./scripts/provide-context.sh
   ```
   - [ ] Context formatted correctly
   - [ ] All relevant files included
   - [ ] Size manageable

4. **Implementation (20-45 min)**
   - [ ] Use Claude Code
   - [ ] Follow plan from Chat
   - [ ] Make code changes
   - [ ] Test changes locally

5. **Update Documentation (45-50 min)**
   ```bash
   ./scripts/update-implementation.sh
   ```
   - [ ] Documentation updated
   - [ ] Changes recorded
   - [ ] Snapshots created

6. **End Session (50-60 min)**
   ```bash
   ./scripts/end-dev-session.sh
   ```
   - [ ] Work archived
   - [ ] Reports updated
   - [ ] Ready for next session

#### Success Criteria

✅ **All scripts executed without errors**  
✅ **Files created in correct locations**  
✅ **Context maintained across session**  
✅ **Work successfully archived**  
✅ **Ready to resume in next session**

---

## Pre-Release Checklist

**Before releasing a new version:**

### Code Quality
- [ ] All scripts pass syntax check
- [ ] All scripts pass shellcheck
- [ ] No hardcoded paths or secrets
- [ ] Error handling implemented
- [ ] Comments are clear and helpful

### Documentation
- [ ] CHANGELOG updated
- [ ] README reflects changes
- [ ] All new features documented
- [ ] Examples updated if needed
- [ ] Links verified

### Testing
- [ ] Fresh install tested
- [ ] Upgrade path tested
- [ ] All scripts tested individually
- [ ] End-to-end workflow tested
- [ ] Cross-platform verified

### Git
- [ ] All changes committed
- [ ] Commit messages clear
- [ ] Version tag created
- [ ] Release notes prepared

---

## Test Results Tracking

### Test Log Template

```markdown
## Test Session: YYYY-MM-DD

**Tester:** [Name]  
**Version:** [Version]  
**Platform:** [OS]

### Tests Performed

#### Setup
- [ ] Fresh install: PASS/FAIL
- [ ] Re-install: PASS/FAIL

#### Scripts
- [ ] setup.sh: PASS/FAIL
- [ ] start-dev-session.sh: PASS/FAIL
- [ ] provide-context.sh: PASS/FAIL
- [ ] update-implementation.sh: PASS/FAIL
- [ ] push-implementation.sh: PASS/FAIL
- [ ] end-dev-session.sh: PASS/FAIL

#### Workflow
- [ ] Full sprint: PASS/FAIL

### Issues Found
1. [Description]
2. [Description]

### Notes
[Any observations]
```

---

## Contributing Tests

### How to Add Tests

1. **Identify what needs testing**
2. **Write test case documentation**
3. **Add to this document**
4. **Submit PR**

---

**Last Updated:** 2025-10-05  
**Version:** 1.0
