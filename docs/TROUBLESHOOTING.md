# Troubleshooting Guide

Common issues and their solutions for the SociallyFed AI Workflow.

## Table of Contents

- [Setup Issues](#setup-issues)
- [Runtime Issues](#runtime-issues)
- [Integration Issues](#integration-issues)
- [Performance Issues](#performance-issues)
- [Common Error Messages](#common-error-messages)
- [Debug Mode](#debug-mode)
- [Getting More Help](#getting-more-help)

---

## Setup Issues

### Google Drive Not Found

**Problem:** Setup script can't find Google Drive

**Error Message:**
```
❌ Directory not found: /path/to/Google Drive
```

**Solutions:**

1. **Verify Google Drive is installed**
   ```bash
   # Check common locations
   ls -la ~/"Google Drive"
   ls -la ~/GoogleDrive
   ls -la /mnt/GoogleDrive
   ```

2. **Check if Google Drive is syncing**
   - Open Google Drive Desktop app
   - Ensure sync is active
   - Check for sync errors

3. **Manually specify path**
   ```bash
   mkdir -p ~/.config/sociallyfed
   nano ~/.config/sociallyfed/config.sh
   ```
   
   Add:
   ```bash
   GOOGLE_DRIVE_PATH="/your/actual/path/to/Google Drive"
   ```

4. **Use alternative cloud storage**
   ```bash
   # For Dropbox
   GOOGLE_DRIVE_PATH="$HOME/Dropbox"
   
   # For OneDrive
   GOOGLE_DRIVE_PATH="$HOME/OneDrive"
   ```

### Scripts Not Executable

**Problem:** `Permission denied` when running scripts

**Error Message:**
```
bash: ./scripts/start-dev-session.sh: Permission denied
```

**Solution:**
```bash
# Make all scripts executable
chmod +x scripts/*.sh

# Verify permissions
ls -la scripts/
```

### Configuration File Not Found

**Problem:** Scripts can't find the configuration

**Error Message:**
```
Error: Config file not found at ~/.config/sociallyfed/config.sh
```

**Solution:**
```bash
# Run setup wizard again
./scripts/setup.sh

# Or create manually
mkdir -p ~/.config/sociallyfed
echo 'GOOGLE_DRIVE_PATH="$HOME/Google Drive"' > ~/.config/sociallyfed/config.sh
```

---

## Runtime Issues

### Context Not Loading in Claude Code

**Problem:** Claude Code doesn't see the project context

**Symptoms:**
- Claude gives generic responses
- Doesn't reference project specifics
- Asks for information already in context

**Solutions:**

1. **Verify files exist**
   ```bash
   # Check context files
   ls -la "$HOME/Google Drive/Development/SociallyFed/Context/"
   
   # View context file
   cat "$HOME/Google Drive/Development/SociallyFed/Context/project-context.md"
   ```

2. **Re-run context provision**
   ```bash
   ./scripts/provide-context.sh
   ```

3. **Check file sync status**
   - Ensure Google Drive has synced
   - Look for cloud icon on files (should be ✓ not ☁️)
   - Force sync if needed

4. **Manually provide context**
   - Open context files in Claude Code
   - Copy-paste relevant sections
   - Reference files explicitly in your prompt

### Daily Brief Not Generating

**Problem:** start-dev-session.sh doesn't create brief

**Error Message:**
```
Error: Could not create daily brief
```

**Solutions:**

1. **Check Google Drive connection**
   ```bash
   # Verify path exists
   source ~/.config/sociallyfed/config.sh
   ls -la "$GOOGLE_DRIVE_PATH/Development/SociallyFed/Reports/"
   ```

2. **Check script permissions**
   ```bash
   ls -la scripts/start-dev-session.sh
   # Should show -rwxr-xr-x
   ```

3. **Run with verbose output**
   ```bash
   bash -x ./scripts/start-dev-session.sh
   ```

4. **Check disk space**
   ```bash
   df -h "$GOOGLE_DRIVE_PATH"
   ```

---

## Integration Issues

### Git Conflicts When Pushing

**Problem:** Merge conflicts when running push-implementation.sh

**Error Message:**
```
error: Your local changes would be overwritten by the merge
```

**Solutions:**

1. **Always pull before pushing**
   ```bash
   git pull origin main
   git status
   ```

2. **Use the update script first**
   ```bash
   ./scripts/update-implementation.sh
   ```

3. **Manually resolve conflicts**
   ```bash
   # Open conflicted files
   git status
   # Edit files to resolve conflicts
   # Then:
   git add .
   git commit -m "Resolve merge conflicts"
   ```

---

## Performance Issues

### Slow File Access

**Problem:** Google Drive files are loading slowly

**Solutions:**

1. **Check sync status**
   - Right-click files
   - Choose "Available offline"
   - Ensure fully downloaded

2. **Adjust Google Drive settings**
   - Open Google Drive preferences
   - Enable "Stream files" or "Mirror files"
   - Allocate more cache space

3. **Use local copies for active work**
   ```bash
   # Copy to local temp directory
   cp -r "$GOOGLE_DRIVE_PATH/Development/SociallyFed/Context" /tmp/context
   
   # Work locally, copy back when done
   ```

---

## Common Error Messages

### "No such file or directory"

**Full Error:**
```
./scripts/start-dev-session.sh: line 23: /path/to/file: No such file or directory
```

**Fix:**
```bash
# Check if path exists
ls -la /path/to/file

# Recreate if needed
./scripts/setup.sh
```

### "Command not found: claude"

**Full Error:**
```
bash: claude: command not found
```

**Fix:**
This workflow uses file-based communication, not CLI commands. You:
1. Generate files with scripts
2. Open files in Claude Chat/Code manually
3. No command-line Claude access needed

### "Permission denied (publickey)"

**Full Error:**
```
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
```

**Fix:**
```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Add public key to GitHub
cat ~/.ssh/id_ed25519.pub
# Copy and paste into GitHub Settings > SSH Keys
```

---

## Debug Mode

### Running Scripts in Debug Mode

**See every command as it executes:**
```bash
bash -x ./scripts/start-dev-session.sh
```

**Save debug output:**
```bash
bash -x ./scripts/start-dev-session.sh 2>&1 | tee debug.log
```

### Check Configuration

```bash
# View current config
cat ~/.config/sociallyfed/config.sh

# Verify paths
source ~/.config/sociallyfed/config.sh
echo "Google Drive: $GOOGLE_DRIVE_PATH"
ls -la "$GOOGLE_DRIVE_PATH"
```

---

## Getting More Help

### Before Asking for Help

1. ✅ Check this troubleshooting guide
2. ✅ Read the [FAQ](../FAQ.md)
3. ✅ Review relevant documentation
4. ✅ Try the solutions above
5. ✅ Search existing [GitHub issues](https://github.com/BennyGaming635/sociallyfed-ai-workflow/issues)

### Creating a Good Issue Report

Include:

```markdown
## Environment
- OS: [e.g., Ubuntu 22.04, macOS 14.0]
- Bash version: [output of `bash --version`]
- Google Drive: [Desktop app version]

## Problem Description
Clear description of what's wrong

## Steps to Reproduce
1. Step one
2. Step two
3. ...

## Expected Behaviour
What should happen

## Actual Behaviour
What actually happens

## Error Messages
```
Paste full error messages here
```

## What I've Tried
- Solution 1: didn't work because...
- Solution 2: didn't work because...

## Additional Context
- Screenshots if helpful
- Relevant config files
- Debug output
```

---

**Last Updated:** 2025-10-05  
We're here to help! 🤝
