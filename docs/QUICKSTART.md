# Quick Start Guide

Get up and running with the SociallyFed AI Workflow in 15 minutes.

## Prerequisites

Before you begin, ensure you have:

- ✅ **Claude Pro account** ($20/month) with access to Claude Chat and Claude Code
- ✅ **Google Drive Desktop** installed and synced
- ✅ **Git** installed (`git --version` to verify)
- ✅ **Bash 4+** (macOS/Linux have this; Windows users need WSL)
- ✅ **15 minutes** of focused time

## Step 1: Clone the Repository (2 minutes)

```bash
# Clone the repository
git clone https://github.com/BennyGaming635/sociallyfed-ai-workflow.git

# Navigate into the directory
cd sociallyfed-ai-workflow

# Verify you have the files
ls -la
```

**You should see:**
- `scripts/` directory with `.sh` files
- `docs/` directory with documentation
- `examples/` directory with templates
- `README.md`, `LICENSE`, etc.

## Step 2: Run Setup Wizard (5 minutes)

The setup wizard will:
- Find your Google Drive
- Create necessary directories
- Set up configuration
- Make scripts executable

```bash
# Run the setup wizard
./scripts/setup.sh
```

**Follow the prompts:**

1. **Google Drive Detection:**
   ```
   🔍 Looking for Google Drive...
   ✅ Found: /Users/you/Google Drive
   
   Use this path? (y/n):
   ```
   Press `y` if correct, `n` to specify manually.

2. **Directory Creation:**
   ```
   📁 Creating directory structure in:
   /Users/you/Google Drive/Development/SociallyFed/
   
   Continue? (y/n):
   ```
   Press `y` to proceed.

3. **Configuration:**
   ```
   ✅ Configuration saved to: ~/.config/sociallyfed/config.sh
   ✅ Scripts made executable
   ✅ Setup complete!
   ```

**If setup fails:** See [Troubleshooting](#troubleshooting-setup)

## Step 3: Start Your First Development Session (3 minutes)

```bash
# Generate your first daily brief
./scripts/start-dev-session.sh
```

**This creates:**
- `daily-brief-YYYYMMDD.md` in Google Drive
- Suggestions for today's work
- Context from previous sessions (if any)

**Example output:**
```
📅 Generating daily brief for 2025-10-05...
✅ Brief created at:
   ~/Google Drive/Development/SociallyFed/Reports/daily-briefs/daily-brief-20251005.md

📖 Open this file to begin your session!
```

## Step 4: Strategic Planning with Claude Chat (5 minutes)

1. **Open the daily brief** in any text editor

2. **Copy the "Context" section**

3. **Open Claude Chat** (claude.ai)

4. **Start a new conversation** with:

   ```
   I'm working on [your project name]. Here's my current context:

   [Paste the context section from daily brief]

   Today I want to focus on: [your goal]

   What's the best approach?
   ```

5. **Discuss architecture, design, approach**
   - Ask questions
   - Clarify requirements
   - Make decisions
   - Take notes

6. **Document the plan** - Copy key decisions to the brief

**Example conversation:**
```
You: I need to add user authentication to my app. 
     What's the best approach with Firebase?

Claude: Here's a strategic approach:
        1. Use Firebase Auth for the backend
        2. Implement email/password first
        3. Add social login later
        4. Structure your auth flow like this: ...

You: Great! Should I use context or Redux for state?

Claude: For auth state, I recommend ...
```

## Step 5: Provide Context to Claude Code (2 minutes)

```bash
# Bundle and format your context
./scripts/provide-context.sh
```

**This creates:**
- `provide-context-YYYYMMDD.txt` with all project context formatted for Claude Code

**Now:**

1. **Open Claude Code** (via your IDE or standalone)
2. **Start a new chat**
3. **Paste the entire content** from `provide-context-YYYYMMDD.txt`
4. **Begin implementation**

**Initial prompt:**
```
I've provided my project context above. Based on our planning in Claude Chat,
I need to implement [specific feature]. Here's what we decided:

- [Decision 1 from Chat]
- [Decision 2 from Chat]
- [Decision 3 from Chat]

Please help me implement this step by step.
```

## Quick Reference: One-Hour Sprint Structure

```
┌─────────────────────────────────────────────────────┐
│ PHASE                    │ TIME      │ ACTIVITY     │
├─────────────────────────────────────────────────────┤
│ 1. Session Start         │ 00-05 min │ Generate     │
│                          │           │ daily brief  │
├─────────────────────────────────────────────────────┤
│ 2. Strategic Planning    │ 05-15 min │ Claude Chat  │
│    (Claude Chat)         │           │ discussion   │
├─────────────────────────────────────────────────────┤
│ 3. Context Provision     │ 15-20 min │ Provide      │
│                          │           │ context      │
├─────────────────────────────────────────────────────┤
│ 4. Implementation        │ 20-45 min │ Claude Code  │
│    (Claude Code)         │           │ work         │
├─────────────────────────────────────────────────────┤
│ 5. Documentation Update  │ 45-50 min │ Update docs  │
├─────────────────────────────────────────────────────┤
│ 6. Session End           │ 50-60 min │ Archive,     │
│                          │           │ commit       │
└─────────────────────────────────────────────────────┘
```

## Your First Sprint: Example Task

Let's do a simple task to learn the workflow:

### Goal: Add a "Hello World" Feature

**1. Start session (1 min)**
```bash
./scripts/start-dev-session.sh
```

**2. Plan with Claude Chat (3 min)**
```
Prompt: I want to add a simple "Hello World" message to my app's
        homepage. What files should I modify and how?
```

**3. Provide context (1 min)**
```bash
./scripts/provide-context.sh
```

**4. Implement with Claude Code (10 min)**
```
Prompt: Based on our plan, please:
        1. Create/modify the homepage component
        2. Add the "Hello World" message
        3. Style it nicely
        4. Test that it works
```

**5. Test it works (3 min)**
```bash
# Run your app
npm start
# or whatever your start command is

# Verify the message appears
```

**6. Update docs (1 min)**
```bash
./scripts/update-implementation.sh
```

**7. Commit work (1 min)**
```bash
./scripts/push-implementation.sh
```

**Total:** ~20 minutes for your first feature!

## Troubleshooting Setup

### Google Drive Not Found

**Solution 1 - Manual path:**
```bash
mkdir -p ~/.config/sociallyfed
echo 'GOOGLE_DRIVE_PATH="/your/actual/path"' > ~/.config/sociallyfed/config.sh
```

**Solution 2 - Check common locations:**
```bash
ls -la ~/"Google Drive"
ls -la ~/GoogleDrive
ls -la /mnt/GoogleDrive
```

### Scripts Not Executable

```bash
chmod +x scripts/*.sh
```

### "Command not found"

Make sure you're in the right directory:
```bash
cd sociallyfed-ai-workflow
ls scripts/
```

### Git Issues

```bash
# Verify Git installed
git --version

# Configure if needed
git config --global user.name "Your Name"
git config --global user.email "you@email.com"
```

## Next Steps

Now that you've completed your first session:

### Learn More
- 📖 Read the [Workflow Guide](docs/WORKFLOW_GUIDE.md) for detailed methodology
- 🤖 Study [AI Integration](docs/AI_INTEGRATION.md) patterns
- 🏗️ Review [Architecture](docs/ARCHITECTURE.md) documentation
- 💡 Browse [Prompts Reference](docs/PROMPTS_REFERENCE.md)

### Practice
- 🎯 Do another sprint with a real task
- 📝 Customise prompts for your project
- 🔧 Adapt scripts to your workflow
- 📊 Track your progress over time

### Explore
- 🌟 Check out [Examples](examples/)
- 💬 Join [Discussions](https://github.com/BennyGaming635/sociallyfed-ai-workflow/discussions)
- 🐛 Report issues or suggest features
- 🤝 [Contribute](CONTRIBUTING.md) improvements

## Tips for Success

### ✅ Do's
- **Start small** - Don't tackle everything at once
- **Be specific** - Vague prompts get vague results
- **Review code** - Don't unquestioningly accept AI suggestions
- **Iterate** - Multiple small sprints beat one marathon
- **Document** - Update docs as you go
- **Commit often** - Smaller commits are easier to track

### ❌ Don'ts
- **Don't skip planning** - Strategic thinking prevents wasted implementation time
- **Don't overload context** - Keep it relevant to current task
- **Don't ignore errors** - Fix issues before moving on
- **Don't forget breaks** - Rest between sprints
- **Don't work tired** - Quality drops fast when exhausted

## Common Questions

**Q: Can I do shorter/longer sprints?**  
A: Yes! Adapt to your schedule. The structure matters more than exact timing.

**Q: What if Claude doesn't understand my context?**  
A: Simplify it. Start with a high-level overview, then drill into specifics.

**Q: Do I need to use both Chat and Code?**  
A: No, but it's recommended. You can use just Code for simple tasks.

**Q: Can I use this for non-coding projects?**  
A: Yes! The methodology works for writing, design, research, etc.

**Q: How do I collaborate with others?**  
A: Share your Google Drive folder or use Git for code. Documentation helps teammates understand decisions.

## Getting Help

- 📋 **FAQ:** [FAQ.md](FAQ.md) - Comprehensive Q&A
- 🔧 **Troubleshooting:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Common issues
- 💬 **Discussions:** [GitHub Discussions](https://github.com/BennyGaming635/sociallyfed-ai-workflow/discussions)
- 🐛 **Issues:** [GitHub Issues](https://github.com/BennyGaming635/sociallyfed-ai-workflow/issues)
- 📧 **Email:** ben@sociallyfed.com

---

**🎉 Congratulations!** You're ready to start building with the SociallyFed AI Workflow.

**Next:** Open your daily brief and start your first real development sprint!

---

**Last Updated:** 2025-10-05  
**Version:** 1.0
