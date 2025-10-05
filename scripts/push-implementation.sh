#!/bin/bash

# push-implementation.sh - Commit changes with contextual information
# This script creates meaningful commits linked to implementation context

set -euo pipefail

# Configuration
CONTEXT_DIR="${CONTEXT_DIR:-$HOME/Google Drive/SociallyFed/Context}"
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo -e "${RED}❌ Error: Not in a git repository${NC}"
    exit 1
fi

# Check for commit message
if [ $# -eq 0 ]; then
    echo -e "${RED}❌ Error: Please provide a commit message${NC}"
    echo "Usage: $0 \"commit message\" [type]"
    echo ""
    echo "Types: feat, fix, docs, style, refactor, test, chore"
    echo ""
    echo "Example: $0 \"Add journal entry encryption\" feat"
    exit 1
fi

COMMIT_MESSAGE="$1"
COMMIT_TYPE="${2:-feat}"

# Validate commit type
VALID_TYPES=("feat" "fix" "docs" "style" "refactor" "test" "chore" "perf" "build" "ci")
if [[ ! " ${VALID_TYPES[@]} " =~ " ${COMMIT_TYPE} " ]]; then
    echo -e "${YELLOW}⚠️  Warning: Invalid commit type '$COMMIT_TYPE'. Using 'feat' instead.${NC}"
    COMMIT_TYPE="feat"
fi

echo -e "${BLUE}🚀 Preparing to commit changes...${NC}"

# Function to get latest implementation report
get_latest_report() {
    local report_dir="$CONTEXT_DIR/implementation-reports"
    if [ -d "$report_dir" ]; then
        find "$report_dir" -name "report-*.md" -type f -printf '%T@ %p\n' 2>/dev/null | 
        sort -rn | head -1 | cut -d' ' -f2- || echo ""
    fi
}

# Function to extract context from report
extract_context() {
    local report="$1"
    if [ -f "$report" ]; then
        # Extract completed tasks summary
        awk '/^## Completed Tasks/,/^## Challenges/' "$report" 2>/dev/null | 
        grep -E "^- |^\*" | head -5 || echo ""
    fi
}

# Function to find issue numbers in message
find_issue_refs() {
    echo "$COMMIT_MESSAGE" | grep -oE '#[0-9]+' | tr '\n' ', ' | sed 's/,$//'
}

# Show current status
echo -e "${BLUE}📊 Current git status:${NC}"
git status --short

# Count changes
CHANGED_FILES=$(git diff --cached --name-only | wc -l)
if [ "$CHANGED_FILES" -eq 0 ]; then
    echo -e "${YELLOW}⚠️  No files staged. Staging all changes...${NC}"
    git add -A
    CHANGED_FILES=$(git diff --cached --name-only | wc -l)
fi

echo -e "${BLUE}📝 Files to be committed: $CHANGED_FILES${NC}"

# Get context information
DATE=$(date +%Y-%m-%d)
LATEST_REPORT=$(get_latest_report)
CONTEXT_SUMMARY=$(extract_context "$LATEST_REPORT")
ISSUE_REFS=$(find_issue_refs)

# Build extended commit message
EXTENDED_MESSAGE="${COMMIT_TYPE}: ${COMMIT_MESSAGE}"

# Add context if available
if [ -n "$CONTEXT_SUMMARY" ]; then
    EXTENDED_MESSAGE+="\n\nImplementation details:\n$CONTEXT_SUMMARY"
fi

# Add metadata
EXTENDED_MESSAGE+="\n\nContext: Daily brief ${DATE}"

if [ -n "$LATEST_REPORT" ]; then
    EXTENDED_MESSAGE+="\nReport: $(basename "$LATEST_REPORT")"
fi

if [ -n "$ISSUE_REFS" ]; then
    EXTENDED_MESSAGE+="\nRefs: $ISSUE_REFS"
fi

# Show what will be committed
echo ""
echo -e "${BLUE}📋 Commit preview:${NC}"
echo "---"
echo -e "$EXTENDED_MESSAGE"
echo "---"
echo ""

# Ask for confirmation
echo -e "${YELLOW}Proceed with commit? (y/n)${NC}"
read -r -n 1 CONFIRM
echo ""

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo -e "${RED}❌ Commit cancelled${NC}"
    exit 0
fi

# Create the commit
echo -e "${BLUE}💾 Creating commit...${NC}"
git commit -m "$(echo -e "$EXTENDED_MESSAGE")"

# Show commit info
echo ""
echo -e "${GREEN}✅ Commit created successfully!${NC}"
COMMIT_HASH=$(git rev-parse --short HEAD)
echo -e "${BLUE}📍 Commit: $COMMIT_HASH${NC}"

# Ask about pushing
echo ""
echo -e "${YELLOW}Push to remote? (y/n)${NC}"
read -r -n 1 PUSH_CONFIRM
echo ""

if [[ "$PUSH_CONFIRM" =~ ^[Yy]$ ]]; then
    BRANCH=$(git branch --show-current)
    echo -e "${BLUE}⬆️  Pushing to origin/$BRANCH...${NC}"
    
    if git push origin "$BRANCH"; then
        echo -e "${GREEN}✅ Pushed successfully!${NC}"
        
        # Check if we should create a PR
        if command -v gh &> /dev/null; then
            echo ""
            echo -e "${YELLOW}Create a pull request? (y/n)${NC}"
            read -r -n 1 PR_CONFIRM
            echo ""
            
            if [[ "$PR_CONFIRM" =~ ^[Yy]$ ]]; then
                echo -e "${BLUE}🔄 Creating pull request...${NC}"
                PR_TITLE="${COMMIT_TYPE}: ${COMMIT_MESSAGE}"
                PR_BODY="## Summary\n\n${COMMIT_MESSAGE}\n\n## Changes\n\n${CONTEXT_SUMMARY}\n\n## Testing\n\n- [ ] Unit tests pass\n- [ ] Integration tests pass\n- [ ] Manual testing completed\n\n---\n*Created with push-implementation.sh*"
                
                gh pr create --title "$PR_TITLE" --body "$(echo -e "$PR_BODY")" || 
                echo -e "${YELLOW}⚠️  Could not create PR. You may need to set it up manually.${NC}"
            fi
        fi
    else
        echo -e "${RED}❌ Push failed. You may need to pull first or resolve conflicts.${NC}"
    fi
else
    echo -e "${BLUE}ℹ️  Commit created locally. Push when ready with:${NC}"
    echo "  git push origin $(git branch --show-current)"
fi

# Update metrics
echo ""
echo -e "${BLUE}📊 Commit Statistics:${NC}"
git show --stat

echo ""
echo -e "${GREEN}🎉 Done! Keep building amazing things!${NC}"