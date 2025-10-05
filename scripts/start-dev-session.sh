#!/bin/bash

# start-dev-session.sh - Initialize daily development session for SociallyFed
# This script creates a daily brief capturing current project state

set -euo pipefail

# Configuration
CONTEXT_DIR="${CONTEXT_DIR:-$HOME/Google Drive/SociallyFed/Context}"
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
EDITOR="${EDITOR:-code}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Ensure directories exist
mkdir -p "$CONTEXT_DIR/daily-briefs"
mkdir -p "$CONTEXT_DIR/implementation-reports"
mkdir -p "$CONTEXT_DIR/development-context"

echo -e "${BLUE}🚀 Starting SociallyFed development session...${NC}"

# Navigate to project directory
cd "$PROJECT_DIR" || {
    echo -e "${YELLOW}⚠️  Warning: Could not navigate to project directory${NC}"
    echo "Using current directory: $(pwd)"
}

# Generate timestamp and filename
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)
BRIEF_FILE="$CONTEXT_DIR/daily-briefs/daily-brief-${DATE}.md"

# Function to get git status
get_git_status() {
    if [ -d .git ]; then
        echo "## Git Status"
        echo '```'
        git status --short
        echo '```'
        echo ""
    fi
}

# Function to get recent commits
get_recent_commits() {
    if [ -d .git ]; then
        echo "## Recent Commits (Last 5)"
        echo '```'
        git log --oneline -5 2>/dev/null || echo "No commits yet"
        echo '```'
        echo ""
    fi
}

# Function to get branch info
get_branch_info() {
    if [ -d .git ]; then
        echo "## Current Branch"
        BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
        echo "- Branch: \`$BRANCH\`"
        
        # Check if branch is up to date with remote
        if git remote -v | grep -q origin; then
            git fetch origin "$BRANCH" --quiet 2>/dev/null || true
            LOCAL=$(git rev-parse "$BRANCH" 2>/dev/null || echo "none")
            REMOTE=$(git rev-parse "origin/$BRANCH" 2>/dev/null || echo "none")
            
            if [ "$LOCAL" = "$REMOTE" ]; then
                echo "- Status: ✅ Up to date with remote"
            else
                echo "- Status: ⚠️  Local and remote differ"
            fi
        fi
        echo ""
    fi
}

# Function to check for TODO items
get_todos() {
    echo "## TODO Items in Code"
    echo '```'
    # Search for TODO, FIXME, HACK comments
    if command -v rg &> /dev/null; then
        rg "TODO|FIXME|HACK" --type-add 'code:*.{cs,ts,tsx,py,dart}' -t code -C 1 2>/dev/null | head -20 || echo "No TODO items found"
    else
        grep -r "TODO\|FIXME\|HACK" --include="*.cs" --include="*.ts" --include="*.py" . 2>/dev/null | head -20 || echo "No TODO items found"
    fi
    echo '```'
    echo ""
}

# Function to get yesterday's progress
get_yesterdays_progress() {
    YESTERDAY=$(date -d "yesterday" +%Y-%m-%d 2>/dev/null || date -v-1d +%Y-%m-%d 2>/dev/null || echo "")
    if [ -n "$YESTERDAY" ]; then
        YESTERDAY_REPORT="$CONTEXT_DIR/implementation-reports/cumulative-log.md"
        if [ -f "$YESTERDAY_REPORT" ]; then
            echo "## Yesterday's Progress Summary"
            echo "See cumulative log for details: cumulative-log.md"
            echo ""
        fi
    fi
}

# Function to check environment
check_environment() {
    echo "## Environment Check"
    
    # Check for required tools
    echo "### Required Tools"
    for tool in git code; do
        if command -v $tool &> /dev/null; then
            echo "- ✅ $tool: $(which $tool)"
        else
            echo "- ❌ $tool: Not found"
        fi
    done
    
    # Check for optional tools
    echo ""
    echo "### Optional Tools"
    for tool in dotnet python3 node docker; do
        if command -v $tool &> /dev/null; then
            echo "- ✅ $tool: $($tool --version 2>&1 | head -1)"
        else
            echo "- ⚠️  $tool: Not found"
        fi
    done
    echo ""
}

# Create the daily brief
cat > "$BRIEF_FILE" << EOF
# Daily Development Brief - $DATE

Generated at: $TIME

## Overview

This brief captures the current state of the SociallyFed project to provide context for today's development session.

$(get_branch_info)

$(get_git_status)

$(get_recent_commits)

$(get_yesterdays_progress)

$(get_todos)

$(check_environment)

## Focus Areas for Today

<!-- To be filled by Senior Claude -->
1. [ ] _To be determined based on current state_
2. [ ] _Review implementation reports_
3. [ ] _Plan next features_

## Blocking Issues

<!-- List any blockers here -->
- None identified

## Notes

<!-- Additional context or reminders -->
- Remember to maintain 80%+ test coverage
- Focus on privacy-first implementation
- Update implementation reports frequently

---

*Use this brief with Claude Desktop to plan today's development tasks*
EOF

echo -e "${GREEN}✅ Daily brief created successfully!${NC}"
echo -e "${BLUE}📋 Brief location: $BRIEF_FILE${NC}"

# Open in editor
if [ -n "$EDITOR" ] && command -v "$EDITOR" &> /dev/null; then
    echo -e "${BLUE}📝 Opening brief in $EDITOR...${NC}"
    "$EDITOR" "$BRIEF_FILE" &
fi

# Provide next steps
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Open Claude Desktop on Windows"
echo "2. Load the daily brief from Google Drive"
echo "3. Ask: 'Review this brief and create a development plan for today's SociallyFed features'"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"