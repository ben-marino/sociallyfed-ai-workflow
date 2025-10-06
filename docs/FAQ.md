# Frequently Asked Questions (FAQ)

Quick answers to common questions about the SociallyFed AI Workflow.

## Table of Contents

- [General Questions](#general-questions)
- [Getting Started](#getting-started)
- [Workflow Questions](#workflow-questions)
- [AI Integration](#ai-integration)
- [Technical Questions](#technical-questions)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

---

## General Questions

### What is the SociallyFed AI Workflow?

A systematic approach to building complex applications using AI assistance through structured one-hour development sprints. It combines strategic planning (Claude Chat) with implementation (Claude Code) while maintaining context across sessions via Google Drive.

### Who is this for?

- Solo developers building complex applications
- Teams exploring AI-assisted development methodologies
- Anyone wanting to integrate AI into their development process systematically
- Developers looking for proven AI collaboration patterns

### What makes this different from just using AI to code?

**Key differences:**

1. **Structured methodology** - Not ad-hoc AI questions, but systematic sprints
2. **Multi-AI orchestration** - Strategic thinking separated from implementation
3. **Context persistence** - Information maintained across sessions via Google Drive
4. **One-hour focus** - Prevents burnout, maintains momentum
5. **Proven patterns** - Battle-tested on a real application (SociallyFed)

### Do I need to know how to code?

**Yes, ideally.** This workflow is designed for developers who:
- Understand programming concepts
- Can review and modify AI-generated code
- Know how to use Git and command-line tools
- Can debug when things go wrong

AI assists, but doesn't replace developer judgment.

### What's the cost?

**The workflow itself:** Free and open source (MIT License)

**Tools you'll need:**
- Claude Pro ($20/month) - For Chat and Code access
- Google Drive - Free tier works fine
- Git/GitHub - Free

**Total:** ~$20/month for Claude Pro

---

## Getting Started

### What do I need to install?

**Required:**
- Bash 4+ (Linux/macOS have this, Windows needs WSL)
- Git
- Google Drive Desktop app
- Claude Pro account

**Optional:**
- Code editor (VS Code, etc.)
- ShellCheck (for script validation)

### How long does setup take?

**~15 minutes** for first-time setup:
- 5 min: Clone repo and run setup wizard
- 5 min: Configure Google Drive paths
- 5 min: Read quickstart and try first session

### Can I use this with other AI tools?

**Currently designed for Claude**, but the principles work with:
- ChatGPT (with adaptations)
- GitHub Copilot (complementary)
- Local LLMs (future support planned)

The scripts would need modification for other tools.

### What if I don't use Google Drive?

You can adapt to:
- **Dropbox:** Change `GOOGLE_DRIVE_PATH` to Dropbox folder
- **OneDrive:** Same approach
- **Local only:** Store in home directory (lose sync benefits)
- **Git only:** Possible, but loses the multi-machine sync advantage

---

## Workflow Questions

### What's a "one-hour sprint"?

A focused development session with this structure:

```
00:00 - 00:05  Generate daily brief
00:05 - 00:15  Strategic planning (Claude Chat)
00:15 - 00:20  Provide context to Claude Code
00:20 - 00:45  Implementation (Claude Code)
00:45 - 00:50  Update documentation
00:50 - 00:60  Archive session, commit work
```

### Why one hour?

**Benefits of 60-minute sprints:**
- ✅ Maintains focus and energy
- ✅ Prevents burnout
- ✅ Forces prioritisation
- ✅ Fits into busy schedules
- ✅ Creates natural break points
- ✅ Measurable progress

Inspired by Pomodoro but adapted for development.

### Can I do longer sessions?

**Yes, but consider:**
- Breaking into multiple one-hour sprints
- Taking 10-15 min breaks between sprints
- Running `end-dev-session.sh` between sprints
- Starting a fresh brief for each sprint

Quality often decreases after 60-90 minutes.

### What if I can't finish in one hour?

**That's expected!** The workflow handles this:

1. **End current session** - Archive what you did
2. **Next session** - Brief references previous work
3. **Context maintained** - Claude Code picks up where you left off
4. **Progress tracked** - Implementation reports show continuity

Complex features span multiple sprints.

### Do I have to use the exact timing?

**No, it's flexible:**
- Adjust phase lengths to your needs
- Skip strategic planning if the task is straightforward
- Spend more time on implementation
- Adapt to your workflow

The structure is a guideline, not a rule.

---

## AI Integration

### Why use both Claude Chat and Claude Code?

**Different tools for different thinking:**

**Claude Chat (Strategic):**
- Architecture decisions
- Design discussions
- Problem analysis
- Planning next steps
- High-level thinking

**Claude Code (Tactical):**
- Writing actual code
- Implementing plans
- Refactoring
- Bug fixes
- File operations

It's like architect (Chat) + builder (Code).

### How does context persist between tools?

**Via Google Drive:**

1. You create context files
2. Store in Google Drive
3. Reference in Claude Chat
4. Provide to Claude Code
5. Both AIs see the same information

```
You → Daily Brief → Claude Chat (strategy)
              ↓
    Context Files in Google Drive
              ↓
         Claude Code (implementation)
```

### What if Claude "forgets" context?

**Common causes:**
- Long conversation (hit token limit)
- Switched to new chat/project
- Didn't provide a context file

**Solutions:**
- Re-run `provide-context.sh`
- Reference specific parts of context explicitly
- Start a new chat with fresh context provision
- Keep prompts focused

### Can I use this without Claude Pro?

**Technically yes, but limited:**
- Free Claude has usage limits
- No access to Claude Code (requires Pro)
- Would need adaptations

**Recommendation:** This workflow is designed for Pro users.

### How much does AI actually do?

**AI handles:**
- Generating code based on your direction
- Refactoring existing code
- Writing boilerplate
- Finding bugs
- Documentation

**You handle:**
- Deciding what to build
- Architectural decisions (with AI advice)
- Code review and approval
- Testing and verification
- Final judgment calls

Think: AI is a skilled junior developer you're mentoring.

---

## Technical Questions

### What's in the Google Drive structure?

```
Google Drive/
└── Development/
    └── SociallyFed/
        ├── Context/          # Persistent project knowledge
        │   ├── project-context.md
        │   ├── architecture.md
        │   └── ...
        ├── Reports/          # Session archives
        │   ├── daily-briefs/
        │   └── implementation-reports/
        └── Active/           # Current work
            └── current-sprint.md
```

### How do the scripts work?

**Core scripts:**

1. **`setup.sh`**
   - One-time setup wizard
   - Detects Google Drive
   - Creates config file

2. **`start-dev-session.sh`**
   - Generates daily brief
   - Includes yesterday's progress
   - Suggests next steps

3. **`provide-context.sh`**
   - Bundles project context
   - Formats for Claude Code
   - Updates with latest info

4. **`update-implementation.sh`**
   - Updates documentation
   - Creates snapshots
   - Records progress

5. **`push-implementation.sh`**
   - Commits changes to Git
   - Pushes to remote
   - Tags implementation reports

6. **`end-dev-session.sh`**
   - Archives daily brief
   - Saves the implementation report
   - Prepares for next session

### Can I modify the scripts?

**Absolutely!** They're yours to customise:

- Add your own automation
- Integrate different tools
- Change directory structure
- Adapt timing
- Add notifications

Just keep them in Git so you can track changes.

### What about Windows?

**Use WSL (Windows Subsystem for Linux):**

```powershell
# Install WSL
wsl --install

# Then use the workflow in WSL
```

Native Windows batch/PowerShell versions are unavailable, but could be contributed.

### Do I need a GitHub account?

**Recommended but not required:**

- **With GitHub:** Full workflow, remote backup, collaboration
- **Without GitHub:** Local Git only, lose push/pull features

You can use GitLab, Bitbucket, or any Git remote instead.

---

## Troubleshooting

### Scripts aren't executable

**Fix:**
```bash
chmod +x scripts/*.sh
```

### Can't find Google Drive

**Check common locations:**
```bash
ls -la ~/Google\ Drive      # macOS
ls -la ~/GoogleDrive        # Some setups
ls -la /mnt/GoogleDrive     # Linux
```

Or manually set path in `~/.config/sociallyfed/config.sh`

### Context not loading in Claude Code

1. Verify files exist in Google Drive
2. Check Google Drive sync status
3. Re-run `provide-context.sh`
4. Manually paste context if needed

### Git push fails

```bash
# Make sure you've committed
git status

# Pull before pushing
git pull origin main

# Then push
git push origin main
```

### Daily brief is not generating

1. Check `GOOGLE_DRIVE_PATH` in config
2. Verify directory exists
3. Check disk space
4. Run with debug: `bash -x scripts/start-dev-session.sh`

**For more issues:** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

## Contributing

### How can I contribute?

**Many ways:**

1. **Use it and provide feedback** - Tell us what works/doesn't
2. **Report bugs** - Open GitHub issues
3. **Improve documentation** - Fix typos, clarify sections
4. **Add examples** - Share your use cases
5. **Contribute code** - Fix bugs, add features
6. **Share workflows** - Blog posts, videos, talks

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### I found a bug. What should I do?

1. **Check** if it's already reported in GitHub Issues
2. **Verify** it's reproducible
3. **Document** steps to reproduce
4. **Open issue** with clear description
5. **Include** error messages, environment details

See our [bug report template](.github/ISSUE_TEMPLATE/bug_report.md).

### Can I use this for my own projects?

**Yes!** That's the point. MIT License means:

- ✅ Use commercially
- ✅ Modify as needed
- ✅ Private use
- ✅ Distribution

Just keep the license notice.

### Can I write about this?

**Please do!** We'd love to see:

- Blog posts about your experience
- Video tutorials
- Workshop presentations
- Academic papers on AI-assisted development

Just mention the source and share your content with us!

### I have a feature idea

**Great!**

1. **Check** if someone else suggested it (GitHub Discussions)
2. **Open** a discussion to gauge interest
3. **Detail** the use case and benefit
4. **Collaborate** on design if there's interest
5. **Implement** or wait for someone to pick it up

Best features come from real needs.

---

## Still Have Questions?

- 📖 **Read:** [Full documentation](docs/)
- 💬 **Discuss:** [GitHub Discussions](https://github.com/BennyGaming635/sociallyfed-ai-workflow/discussions)
- 🐛 **Report:** [GitHub Issues](https://github.com/BennyGaming635/sociallyfed-ai-workflow/issues)
- 📧 **Email:** ben@sociallyfed.com

---

**Last Updated:** 2025-10-05  
**Version:** 1.0  

*Happy building with AI! 🚀*
