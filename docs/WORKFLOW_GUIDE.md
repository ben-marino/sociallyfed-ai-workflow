# SociallyFed AI Development Workflow Guide

## Table of Contents

- [Workflow Context: Building SociallyFed](#workflow-context-building-sociallyfed)
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Daily Workflow](#daily-workflow)
- [Script Reference](#script-reference)
- [Context Management](#context-management)
- [AI Roles and Responsibilities](#ai-roles-and-responsibilities)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Time Management](#time-management)
- [Success Metrics](#success-metrics)

## Workflow Context: Building SociallyFed

This workflow was specifically designed to build SociallyFed - an AI-assisted personal development application. The meta-irony is fitting: using AI to build an AI-powered personal development tool.

### Why This Workflow Exists

- **SociallyFed has complex requirements**: AI integration, privacy features, mobile + backend architecture
- **Solo developer needs team-level productivity**: Achieving the output of a 3-4 person team
- **Context persistence across sessions**: Development often spans multiple days
- **High quality standards**: 80%+ test coverage, production-ready code, comprehensive documentation

### Key Workflow Principles Aligned with SociallyFed Values

- **Systematic Approach**: Like SociallyFed uses feedback loops for personal growth, this workflow uses structured AI collaboration
- **Pattern Recognition**: Senior Claude identifies development patterns, just as SociallyFed helps users identify behavioral patterns
- **Privacy**: Local development with Google Drive sync mirrors SociallyFed's local LLM approach
- **Continuous Improvement**: Daily briefs and retrospectives mirror SociallyFed's daily journaling

See [SOCIALLYFED_OVERVIEW.md](./SOCIALLYFED_OVERVIEW.md) for details on the application being built.

## Overview

This workflow orchestrates three AI assistants to achieve unprecedented development velocity while maintaining high code quality. The system uses:

1. **Claude Desktop (Senior AI)** - High-level planning and architecture
2. **Claude Code (Implementation AI)** - Code writing and testing
3. **Ollama (Local LLM)** - Production feature and testing

### Workflow Architecture

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Planning   │     │Implementation│     │   Testing    │
│              │     │              │     │              │
│Claude Desktop│────▶│ Claude Code  │────▶│Local Ollama  │
│  (Windows)   │     │  (Ubuntu)    │     │  (Server)    │
└──────────────┘     └──────────────┘     └──────────────┘
       │                    │                     │
       │                    │                     │
       └────────────────────┴─────────────────────┘
                            │
                     Google Drive Sync
                    (Context Persistence)
```

### Key Benefits

- **Zero context switching overhead**: Everything is preserved between sessions
- **Parallel AI capabilities**: Multiple AIs working on different aspects
- **Quality enforcement**: Automated testing and documentation
- **Rapid iteration**: Plan → implement → test within hours

## Prerequisites

### Hardware Requirements

1. **Two machines** (physical or virtual):
   - Windows machine with Claude Desktop installed
   - Ubuntu machine with development environment

2. **Specifications**:
   - Minimum 8GB RAM per machine
   - 20GB free disk space
   - Stable internet connection

### Software Requirements

#### Windows Machine
- Claude Desktop (latest version)
- Google Drive desktop client
- Text editor (Notepad++ or VS Code)

#### Ubuntu Machine
- Claude Code installed and configured
- VS Code with Claude Code extension
- Git configured with credentials
- Development tools:
  ```bash
  # .NET Development
  sudo apt-get update
  sudo apt-get install -y dotnet-sdk-8.0
  
  # Python (for Ollama integration)
  sudo apt-get install -y python3 python3-pip
  
  # Docker (optional but recommended)
  sudo apt-get install -y docker.io
  
  # Basic utilities
  sudo apt-get install -y curl wget jq
  ```

#### Shared Requirements
- Google Drive account with sync enabled on both machines
- Shared folder structure:
  ```
  Google Drive/
  └── SociallyFed/
      └── Context/
          ├── daily-briefs/
          ├── implementation-reports/
          └── development-context/
  ```

### Ollama Setup

Install Ollama for local LLM:
```bash
# Install Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# Pull required models
ollama pull llama2
ollama pull mistral

# Start Ollama service
ollama serve
```

## Daily Workflow

### Morning Setup (10 minutes)

#### 1. Start Development Session (Ubuntu)

```bash
cd ~/your-project-directory
./scripts/start-dev-session.sh
```

This script:
- Creates a timestamped daily brief
- Captures current project state
- Lists pending tasks
- Syncs to Google Drive

#### 2. Planning with Senior Claude (Windows)

1. Open Claude Desktop
2. Load the daily brief from Google Drive
3. Start with this prompt:
   ```
   Review this daily brief and create a detailed development plan for today's SociallyFed features. Focus on [specific area like "pattern discovery" or "journal encryption"].
   ```

4. Senior Claude will provide:
   - Architectural decisions
   - Implementation strategy
   - Test requirements
   - Integration points

5. Save the plan as `DEVELOPMENT_PLAN_[DATE].md` in the Context folder

### Development Phase (4-6 hours)

#### 3. Provide Context to Claude Code (Ubuntu)

```bash
./scripts/provide-context.sh
```

This:
- Reads latest files from Google Drive
- Concatenates relevant context
- Prepares for Claude Code

#### 4. Implementation with Claude Code

In VS Code with Claude Code:

```
Read DEVELOPMENT_CONTEXT.md and implement the features specified in today's plan. Ensure 80% test coverage and follow our established patterns.
```

Claude Code will:
- Implement features with tests
- Follow project conventions
- Create necessary documentation
- Ensure code quality

#### 5. Update Implementation Progress

After each major feature or every 2 hours:

```bash
./scripts/update-implementation.sh
```

Provide a summary like:
```
Implemented journal entry encryption:
- Added EncryptionService with AES-256-GCM
- Created unit tests (87% coverage)
- Updated API endpoints
- Added migration for encrypted fields
```

### Testing Phase (1-2 hours)

#### 6. Integration Testing with Ollama

Test AI features with local LLM:

```python
# Example test script
import requests

# Test pyramid categorization
response = requests.post('http://localhost:11434/api/generate', 
    json={
        'model': 'llama2',
        'prompt': 'Categorize this social media behavior...'
    }
)
```

### End of Day (15 minutes)

#### 7. End Development Session

```bash
./scripts/end-dev-session.sh
```

This:
- Creates session summary
- Updates task status
- Prepares next day's context
- Syncs everything to Google Drive

#### 8. Review and Plan (Optional)

Return to Claude Desktop to:
- Review implementation reports
- Plan tomorrow's priorities
- Note any architectural insights

## Script Reference

### start-dev-session.sh

**Purpose**: Initialize daily development context

**Usage**:
```bash
./scripts/start-dev-session.sh
```

**What it does**:
1. Creates `daily-brief-YYYY-MM-DD.md` with:
   - Current git status
   - Recent commits
   - TODO list status
   - Open issues
2. Syncs to Google Drive
3. Opens brief in editor

**Example Output**:
```markdown
# Daily Development Brief - 2024-10-28

## Current Status
- Branch: feature/journal-encryption
- Uncommitted changes: 3 files
- Last commit: "Add encryption service interface"

## Recent Progress
- Implemented user authentication
- Added journal entry API endpoints
- Set up testing framework

## Today's Focus
- Complete encryption implementation
- Add pattern discovery service
- Write integration tests

## Pending Tasks
- [ ] Encrypt journal entries at rest
- [ ] Add pyramid analysis endpoint
- [ ] Implement rate limiting
```

### provide-context.sh

**Purpose**: Aggregate context for Claude Code

**Usage**:
```bash
./scripts/provide-context.sh [optional-specific-files]
```

**What it does**:
1. Reads from Google Drive Context folder
2. Concatenates:
   - Latest daily brief
   - Development plan
   - Recent implementation reports
   - Project-specific context
3. Creates `DEVELOPMENT_CONTEXT.md`
4. Opens in VS Code

**Customization**:
```bash
# Include specific files
./scripts/provide-context.sh src/encryption/* tests/encryption/*

# Use with patterns
./scripts/provide-context.sh "*.cs" "*.test.js"
```

### update-implementation.sh

**Purpose**: Document implementation progress

**Usage**:
```bash
./scripts/update-implementation.sh
```

**Interactive Process**:
1. Opens editor for report entry
2. Prompts for:
   - Features implemented
   - Tests written
   - Challenges faced
   - Next steps
3. Saves timestamped report
4. Updates cumulative log
5. Syncs to Google Drive

**Report Template**:
```markdown
# Implementation Report - [Timestamp]

## Completed
- Feature: Journal entry encryption
  - Files: EncryptionService.cs, IJournalEncryption.cs
  - Tests: EncryptionServiceTests.cs (12 tests, all passing)
  - Coverage: 87%

## Challenges
- Handled edge case where user forgets passphrase
- Added secure key derivation with PBKDF2

## Next Steps
- Integrate encryption with journal API
- Add migration for existing entries
- Performance test with 1000 entries
```

### push-implementation.sh

**Purpose**: Automate git commits with context

**Usage**:
```bash
./scripts/push-implementation.sh "commit message"
```

**Features**:
- Adds all changes
- Includes implementation context in commit
- References relevant issue numbers
- Pushes to remote

**Commit Format**:
```
feat: Add journal entry encryption

- Implemented AES-256-GCM encryption
- Added secure key derivation
- Created comprehensive test suite
- Updated API to handle encrypted data

Context: Daily brief 2024-10-28
Refs: #45, #67
```

### end-dev-session.sh

**Purpose**: Wrap up daily development

**Usage**:
```bash
./scripts/end-dev-session.sh
```

**Actions**:
1. Generates session summary:
   - Features completed
   - Tests written
   - Coverage metrics
   - Time spent
2. Updates task tracking
3. Creates tomorrow's setup
4. Final sync to Google Drive
5. Optional: Creates PR if feature complete

## Context Management

### Directory Structure

```
Google Drive/
└── SociallyFed/
    └── Context/
        ├── daily-briefs/
        │   ├── daily-brief-2024-10-28.md
        │   ├── daily-brief-2024-10-27.md
        │   └── ...
        ├── implementation-reports/
        │   ├── report-2024-10-28-1430.md
        │   ├── report-2024-10-28-1645.md
        │   └── cumulative-log.md
        ├── development-context/
        │   ├── DEVELOPMENT_CONTEXT.md (current)
        │   ├── architecture-decisions.md
        │   └── project-conventions.md
        └── plans/
            ├── DEVELOPMENT_PLAN_2024-10-28.md
            └── weekly-goals.md
```

### Context Files Explained

#### Daily Briefs
- **Purpose**: Snapshot of project state each morning
- **Lifespan**: Referenced for 1 week
- **Key Sections**: Status, progress, focus, blockers

#### Implementation Reports
- **Purpose**: Document what was built
- **Lifespan**: Permanent record
- **Key Sections**: Completed work, challenges, metrics

#### Development Context
- **Purpose**: Current working context for Claude Code
- **Lifespan**: Updated throughout the day
- **Key Sections**: Active plans, recent decisions, conventions

#### Plans
- **Purpose**: Architectural decisions and strategies
- **Lifespan**: Long-term reference
- **Key Sections**: Goals, approach, specifications

### Context Best Practices

1. **Keep Context Fresh**
   - Update after major milestones
   - Remove outdated information
   - Highlight current priorities

2. **Be Specific**
   - Include file paths
   - Note exact test coverage
   - Document decisions made

3. **Link Everything**
   - Reference issue numbers
   - Link to documentation
   - Connect related features

## AI Roles and Responsibilities

### Claude Desktop (Senior AI)

**Role**: Solutions Architect & Technical Lead

**Responsibilities**:
- System architecture design
- Feature specifications
- Integration strategies
- Code review guidance
- Performance optimization plans
- Security architecture

**Example Prompts**:
```
"Design the pattern discovery system for SociallyFed that can identify correlations between user behaviors and emotional states."

"Create a specification for the local LLM integration ensuring complete privacy while enabling real-time analysis."

"Review this implementation report and suggest architectural improvements for scalability."
```

### Claude Code (Implementation AI)

**Role**: Senior Developer

**Responsibilities**:
- Feature implementation
- Test writing (80%+ coverage)
- Bug fixes
- Documentation
- Refactoring
- Performance optimization

**Example Prompts**:
```
"Implement the PatternDiscoveryService following the specification in DEVELOPMENT_PLAN_2024-10-28.md"

"Write comprehensive tests for the JournalEncryption feature ensuring edge cases are covered"

"Refactor the PyramidAnalysis module to improve performance for large datasets"
```

### Ollama (Local LLM)

**Role**: QA Engineer & Production Feature

**Dual Purpose**:
1. **Development**: Test AI features during development
2. **Production**: Serve as the privacy-preserving AI engine

**Testing Examples**:
```python
# Test pyramid categorization accuracy
def test_pyramid_categorization():
    test_cases = [
        ("Spent 3 hours doom scrolling Twitter", 5),  # Served content
        ("Wrote blog post about Stoicism", 2),        # Content creation
        ("Read philosophy book for an hour", 1)        # Deep focus
    ]
    
    for text, expected_level in test_cases:
        result = ollama_categorize(text)
        assert result['level'] == expected_level
```

## Best Practices

### 1. Maintain Context Continuity

**Do**:
- Start each session by reading previous context
- Update context immediately after changes
- Keep a running log of decisions

**Don't**:
- Skip context updates "just this once"
- Assume you'll remember tomorrow
- Delete old context too quickly

### 2. Clear Communication Between AIs

**Do**:
- Write specifications Claude Code can implement
- Include examples in architectural plans
- Document assumptions clearly

**Don't**:
- Use vague requirements
- Skip test specifications
- Assume implementation details

### 3. Leverage Each AI's Strengths

**Senior Claude**:
- Complex problem solving
- System design
- Trade-off analysis

**Claude Code**:
- Rapid implementation
- Test coverage
- Code consistency

**Ollama**:
- Privacy-preserving processing
- Real-time analysis
- Local deployment

### 4. Version Control Integration

**Commit Often**:
```bash
# After each feature
./scripts/push-implementation.sh "feat: Add pattern discovery"

# After bug fixes
./scripts/push-implementation.sh "fix: Resolve encryption memory leak"

# After tests
./scripts/push-implementation.sh "test: Add integration tests for pyramid API"
```

**Branch Strategy**:
- `main`: Production-ready code
- `develop`: Integration branch
- `feature/*`: Individual features
- `fix/*`: Bug fixes

### 5. Documentation as You Go

**In Code**:
```csharp
/// <summary>
/// Analyzes journal entry to detect emotional patterns using local LLM.
/// Ensures privacy by processing all data locally without external API calls.
/// </summary>
/// <param name="entry">The journal entry to analyze</param>
/// <returns>Pattern detection results with confidence scores</returns>
public async Task<PatternAnalysis> AnalyzeEntry(JournalEntry entry)
{
    // Implementation context: See DEVELOPMENT_PLAN_2024-10-28.md
    // ...
}
```

**In Reports**:
- Link to relevant specifications
- Note architectural decisions
- Document why, not just what

## Troubleshooting

### Common Issues and Solutions

#### 1. Context Sync Problems

**Symptom**: Changes not appearing in Google Drive

**Solutions**:
```bash
# Force sync
killall "Google Drive"
open -a "Google Drive"

# Manual backup
cp -r ~/Google\ Drive/SociallyFed/Context ~/backup/context-$(date +%Y%m%d)

# Check sync status
ls -la ~/Google\ Drive/SociallyFed/Context/daily-briefs/
```

#### 2. Claude Code Missing Context

**Symptom**: Claude Code doesn't understand requirements

**Solutions**:
1. Run `provide-context.sh` again
2. Check DEVELOPMENT_CONTEXT.md includes latest plans
3. Explicitly reference files:
   ```
   Read DEVELOPMENT_PLAN_2024-10-28.md section on "Pattern Discovery" and implement accordingly
   ```

#### 3. Script Permissions

**Symptom**: Permission denied errors

**Solution**:
```bash
chmod +x scripts/*.sh
# or
sudo chmod 755 scripts/*.sh
```

#### 4. Ollama Connection Issues

**Symptom**: Can't connect to local LLM

**Solutions**:
```bash
# Check if running
curl http://localhost:11434/api/tags

# Restart service
systemctl restart ollama

# Check logs
journalctl -u ollama -f
```

#### 5. Large Context Files

**Symptom**: Context file too large for AI

**Solutions**:
1. Split into focused contexts:
   ```bash
   ./scripts/provide-context.sh --feature encryption
   ./scripts/provide-context.sh --feature patterns
   ```

2. Archive old reports:
   ```bash
   mkdir -p archive/2024-10
   mv implementation-reports/report-2024-10-*.md archive/2024-10/
   ```

### Debug Mode

Enable verbose output in scripts:
```bash
export WORKFLOW_DEBUG=1
./scripts/start-dev-session.sh
```

## Time Management

### Recommended Daily Schedule

```
8:00 AM  - 8:15 AM   : Morning setup & context review
8:15 AM  - 9:00 AM   : Planning with Senior Claude
9:00 AM  - 12:00 PM  : Implementation sprint 1
12:00 PM - 1:00 PM   : Lunch break
1:00 PM  - 1:15 PM   : Context update
1:15 PM  - 3:30 PM   : Implementation sprint 2
3:30 PM  - 4:00 PM   : Testing with Ollama
4:00 PM  - 4:30 PM   : Documentation & cleanup
4:30 PM  - 5:00 PM   : End of day wrap-up
```

### Time Boxing Strategies

**Feature Implementation**:
- Small features: 2-3 hours
- Medium features: 4-6 hours (1 day)
- Large features: Split across 2-3 days

**Testing**:
- Unit tests: Write alongside code
- Integration tests: 30-60 minutes per feature
- End-to-end tests: Dedicated sessions

**Documentation**:
- Code comments: As you write
- API docs: 15 minutes per endpoint
- User guides: Dedicated sessions

### Productivity Tips

1. **Batch Similar Tasks**
   - Group all API endpoints together
   - Write all tests in one session
   - Update all documentation at once

2. **Avoid Context Switching**
   - Complete features before starting new ones
   - Resist checking emails during implementation
   - Use Pomodoro technique (25 min focus, 5 min break)

3. **Leverage AI Strengths**
   - Let Senior Claude handle complex design decisions
   - Use Claude Code for repetitive implementations
   - Automate testing with Ollama

## Success Metrics

### Code Quality Metrics

Track these in your implementation reports:

```markdown
## Today's Metrics
- Test Coverage: 85% (target: 80%)
- Build Time: 45 seconds
- Linting Errors: 0
- Code Complexity: Average 3.2 (target: <4)
- Documentation Coverage: 92%
```

### Productivity Metrics

Weekly assessment:

```markdown
## Week of October 28, 2024

### Features Delivered
1. Journal Entry Encryption ✓
2. Pattern Discovery Engine ✓
3. Pyramid Analysis API ✓
4. Mobile Sync Protocol ✓

### Time Metrics
- Planning: 5 hours (12%)
- Implementation: 28 hours (70%)
- Testing: 5 hours (12%)
- Documentation: 2 hours (5%)

### Efficiency Gains
- Features per week: 4 (baseline: 1.5)
- Bugs introduced: 2 (baseline: 8)
- Time to production: 1 week (baseline: 3 weeks)
```

### AI Collaboration Metrics

```markdown
## AI Utilization

### Senior Claude
- Architectural decisions: 12
- Specifications created: 4
- Problems solved: 8
- Time saved: ~10 hours

### Claude Code
- Lines of code: 3,847
- Tests written: 156
- Coverage achieved: 85%
- Time saved: ~25 hours

### Ollama
- Test scenarios: 47
- Patterns analyzed: 1,250
- Accuracy: 94%
- Processing time: <2s average
```

### Overall Success Indicators

1. **Velocity**: 3x improvement over traditional development
2. **Quality**: Maintained 80%+ test coverage
3. **Documentation**: Always up-to-date
4. **Bugs**: 75% reduction in production issues
5. **Satisfaction**: Less stress, more creative work

## Advanced Techniques

### 1. Multi-Feature Parallelization

When features are independent:

```bash
# Morning: Plan both features with Senior Claude
Feature A: Pattern Discovery
Feature B: Email Notifications

# Split implementation
Terminal 1: ./scripts/provide-context.sh --feature patterns
Terminal 2: ./scripts/provide-context.sh --feature email

# Work on both with Claude Code in different VS Code windows
```

### 2. Automated Testing Loops

```bash
# Create test watcher
while true; do
    clear
    dotnet test --no-build
    sleep 5
done
```

### 3. Context Templates

Create reusable templates:

```bash
# scripts/templates/feature-start.md
# Feature: {{FEATURE_NAME}}

## Specification
[Link to plan]

## Implementation Checklist
- [ ] Core logic
- [ ] Unit tests (80%+)
- [ ] Integration tests
- [ ] API documentation
- [ ] Error handling
- [ ] Performance tests

## Files to Create/Modify
- src/Services/{{FEATURE}}Service.cs
- tests/Services/{{FEATURE}}ServiceTests.cs
- src/Controllers/{{FEATURE}}Controller.cs
```

### 4. AI Memory Techniques

Help AIs remember project conventions:

```markdown
# PROJECT_CONVENTIONS.md

## Always Remember
1. Use dependency injection for all services
2. Follow Repository pattern for data access
3. Use MediatR for command/query separation
4. All times in UTC
5. Encrypt sensitive data at rest
6. Log all external API calls
7. Use structured logging with Serilog
```

## Conclusion

This workflow represents a paradigm shift in software development. By orchestrating multiple AIs with clear roles and persistent context, we achieve:

- **Team-level output** as a solo developer
- **Consistent quality** through automated testing
- **Rapid iteration** without sacrificing stability
- **Comprehensive documentation** without overhead

The meta-nature of using AI to build an AI-powered application (SociallyFed) demonstrates the potential of AI-augmented development. This isn't about replacing developers - it's about amplifying human creativity and removing repetitive tasks.

As you use this workflow to build your own projects, remember:
- Context is king - maintain it religiously
- Each AI has strengths - use them wisely
- Quality over speed - but this workflow gives you both
- Document everything - your future self will thank you

Happy building! 🚀

---

*"The best way to predict the future is to build it" - Alan Kay*

*This workflow helps you build that future, one well-architected feature at a time.*