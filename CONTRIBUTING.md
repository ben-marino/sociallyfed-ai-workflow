# Contributing to SociallyFed AI Workflow

Thank you for your interest in contributing to the SociallyFed AI Workflow! This document provides guidelines for contributing to this repository.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Reporting Issues](#reporting-issues)
- [Suggesting Enhancements](#suggesting-enhancements)
- [Pull Request Process](#pull-request-process)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Documentation](#documentation)
- [Community](#community)

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow:

1. **Be Respectful**: Treat everyone with respect and kindness
2. **Be Inclusive**: Welcome contributors from all backgrounds
3. **Be Professional**: Focus on constructive criticism and solutions
4. **Be Patient**: Remember that everyone was a beginner once

## How to Contribute

### Types of Contributions

1. **Workflow Improvements**: Enhance the AI orchestration workflow
2. **Script Enhancements**: Improve existing scripts or add new ones
3. **Documentation**: Improve clarity, fix typos, add examples
4. **Examples**: Share real-world usage examples
5. **Bug Fixes**: Fix issues in scripts or workflows
6. **Feature Requests**: Suggest new capabilities

## Reporting Issues

### Before Submitting an Issue

1. Check existing issues to avoid duplicates
2. Try to reproduce the issue with the latest version
3. Gather relevant information about your environment

### How to Submit an Issue

Create an issue with:

```markdown
## Description
Clear description of the issue

## Steps to Reproduce
1. Step one
2. Step two
3. ...

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g., Ubuntu 22.04]
- Shell: [e.g., bash 5.1]
- Claude Desktop version: [if relevant]
- Other relevant tools:

## Additional Context
Any other information
```

## Suggesting Enhancements

### Enhancement Proposal Template

```markdown
## Summary
Brief description of the enhancement

## Motivation
Why is this enhancement valuable?

## Detailed Description
Full explanation of the proposed change

## Alternatives Considered
Other approaches you've thought about

## Implementation Ideas
How might this be implemented?

## Impact
- Benefits:
- Potential drawbacks:
```

## Pull Request Process

### Before Submitting a PR

1. **Fork the repository** and create your branch from `main`
2. **Test your changes** thoroughly
3. **Update documentation** if needed
4. **Add tests** if applicable
5. **Ensure scripts pass validation**:
   ```bash
   # Run shellcheck
   shellcheck scripts/*.sh
   
   # Ensure scripts are executable
   chmod +x scripts/*.sh
   ```

### PR Guidelines

1. **Title**: Use clear, descriptive titles
   - Good: "Add error handling to start-dev-session.sh"
   - Bad: "Fix script"

2. **Description**: Include:
   - What changes were made
   - Why they were necessary
   - How they were tested
   - Any breaking changes

3. **Commits**: 
   - Use conventional commits format
   - Keep commits focused and atomic
   - Write clear commit messages

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Enhancement
- [ ] Documentation update
- [ ] Other (specify)

## Testing
- [ ] Scripts tested locally
- [ ] Documentation updated
- [ ] Examples updated (if needed)

## Checklist
- [ ] My code follows the project style
- [ ] I've tested my changes
- [ ] I've updated documentation
- [ ] Scripts pass shellcheck
- [ ] No hardcoded paths or secrets

## Related Issues
Closes #(issue number)

## Screenshots/Output
If applicable
```

## Development Setup

### Prerequisites

1. **Git** configured with your credentials
2. **Bash** shell (4.0+)
3. **Google Drive** desktop client
4. **Text editor** (VS Code recommended)

### Local Development

1. Fork and clone the repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/sociallyfed-ai-workflow.git
   cd sociallyfed-ai-workflow
   ```

2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. Make your changes and test:
   ```bash
   # Test scripts
   ./scripts/your-script.sh
   
   # Validate with shellcheck
   shellcheck scripts/*.sh
   ```

4. Commit your changes:
   ```bash
   git add .
   git commit -m "feat: add your feature"
   ```

5. Push and create PR:
   ```bash
   git push origin feature/your-feature-name
   ```

## Coding Standards

### Shell Script Standards

1. **Shebang**: Always use `#!/bin/bash`
2. **Error handling**: Use `set -euo pipefail`
3. **Variables**: 
   - Use `UPPER_CASE` for constants
   - Use `lower_case` for local variables
   - Always quote variables: `"$VAR"`
4. **Functions**: Use descriptive names with comments
5. **Output**: Use color codes for better UX

### Example Script Structure

```bash
#!/bin/bash

# script-name.sh - Brief description
# Detailed description of what this script does

set -euo pipefail

# Configuration
CONSTANT_VAR="${ENV_VAR:-default_value}"

# Colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Functions
function_name() {
    local var="$1"
    # Function implementation
}

# Main execution
main() {
    echo -e "${GREEN}Starting process...${NC}"
    # Main logic
}

# Run main function
main "$@"
```

### Documentation Standards

1. **Markdown**: Use proper markdown formatting
2. **Code blocks**: Include language identifiers
3. **Links**: Ensure all links work
4. **Examples**: Provide real, working examples
5. **Clarity**: Write for clarity, not cleverness

## Documentation

### Areas Needing Documentation

1. **New scripts**: Add to `scripts/README.md`
2. **New features**: Update relevant guides
3. **Examples**: Add to `examples/` directory
4. **Workflow changes**: Update `WORKFLOW_GUIDE.md`

### Documentation Checklist

- [ ] Is the documentation clear and complete?
- [ ] Are all examples tested and working?
- [ ] Are all links valid?
- [ ] Is the formatting consistent?
- [ ] Would a newcomer understand this?

## Community

### Getting Help

- Open an issue for bugs or questions
- Check existing documentation first
- Be specific about your environment and issue

### Sharing Your Experience

We encourage you to share:
- Success stories using this workflow
- Productivity metrics
- Workflow adaptations for your use case
- Integration with other tools

### Recognition

Contributors will be recognized in:
- The project README
- Release notes
- Special thanks section

## Thank You!

Your contributions help make AI-assisted development better for everyone. Whether it's fixing a typo, improving a script, or sharing your experience, every contribution matters.

---

*Happy coding with AI! 🚀*