# Prompt Reference Guide

## Table of Contents

- [Overview](#overview)
- [Planning Prompts (Senior Claude)](#planning-prompts-senior-claude)
- [Implementation Prompts (Claude Code)](#implementation-prompts-claude-code)
- [Testing Prompts (Ollama)](#testing-prompts-ollama)
- [Real SociallyFed Examples](#real-sociallyfed-examples)
- [Prompt Engineering Best Practices](#prompt-engineering-best-practices)
- [Troubleshooting Common Issues](#troubleshooting-common-issues)
- [Advanced Techniques](#advanced-techniques)

## Overview

This guide contains real prompts used in developing SociallyFed, demonstrating how to effectively communicate with each AI in the multi-AI orchestration workflow. These prompts have been refined through actual use and represent patterns that consistently produce high-quality results.

## Planning Prompts (Senior Claude)

### Feature Specification Prompts

#### Basic Feature Request

```markdown
I need to design the SociallyFed pattern discovery system that analyzes user journal entries to find behavioral and emotional patterns.

Requirements:
- Identify correlations between activities and emotional states
- Detect recurring patterns over time (daily, weekly, monthly)
- Surface insights that users might not notice themselves
- Maintain complete privacy (all processing local)
- Present findings as testable hypotheses

Please provide:
1. Technical architecture
2. Data models
3. Algorithm approach
4. API specifications
5. Implementation guidance for Claude Code
```

#### Complex System Design

```markdown
Design the encryption system for SociallyFed journal entries with these requirements:

Security Requirements:
- Client-side encryption before any network transmission
- Zero-knowledge architecture (server cannot decrypt)
- Support for key recovery without compromising security
- Compliance with GDPR and CCPA

Technical Constraints:
- Must work offline
- Sub-100ms encryption/decryption time
- Support entries up to 50,000 characters
- Compatible with both mobile and web platforms

Deliverables:
1. Encryption algorithm selection and justification
2. Key management strategy
3. Data flow diagrams
4. Implementation specification with code examples
5. Migration plan for existing unencrypted data
6. Test scenarios covering edge cases
```

### Architecture Review Prompts

```markdown
Review this implementation report for the SociallyFed pyramid analysis feature:

[Implementation Report Content]

Please analyze:
1. Architectural soundness
2. Performance implications
3. Security considerations
4. Scalability concerns
5. Technical debt introduced
6. Suggested improvements

Focus particularly on:
- The integration with Ollama for local processing
- Response time optimization
- Caching strategy effectiveness
```

### Problem-Solving Prompts

```markdown
We're experiencing performance issues with the pattern discovery algorithm when users have >500 journal entries. Current implementation uses O(n²) correlation checking.

Current approach:
- Load all entries into memory
- Compare each entry with every other entry
- Calculate correlation coefficients
- Store significant patterns

Constraints:
- Must complete analysis in <10 seconds
- Mobile devices with limited memory
- Maintain statistical accuracy
- Support incremental updates

Design an optimized solution that addresses these performance issues while maintaining accuracy.
```

## Implementation Prompts (Claude Code)

### Feature Implementation

#### Standard Feature

```markdown
Read DEVELOPMENT_CONTEXT.md and implement the journal entry encryption feature based on the specification provided.

Key requirements:
- Use AES-256-GCM for encryption
- Implement key derivation with PBKDF2 (100,000 iterations)
- Create comprehensive test suite with 85%+ coverage
- Handle edge cases: empty entries, Unicode content, maximum length
- Add appropriate logging without exposing sensitive data

Start by implementing the encryption service interface, then create the concrete implementation with full test coverage.
```

#### API Endpoint Creation

```markdown
Implement the SociallyFed pyramid analysis API endpoints based on the specification in the context.

Create these endpoints:
1. POST /api/pyramid/analyze - Analyze single content item
2. GET /api/pyramid/user-metrics - Get user's pyramid distribution
3. GET /api/pyramid/insights - Get personalized recommendations
4. POST /api/pyramid/batch - Batch analyze multiple items

Requirements:
- Use vertical slice architecture pattern
- Include input validation with FluentValidation
- Implement rate limiting (10 requests/minute for analyze)
- Add OpenAPI documentation
- Create integration tests for each endpoint
- Handle Ollama service unavailability gracefully

Follow the existing patterns in the codebase for consistency.
```

### Bug Fixing

```markdown
Fix the memory leak in the PatternDiscoveryService reported in issue #234.

Bug description:
- Memory usage grows continuously during pattern analysis
- Occurs when processing users with >1000 entries
- Memory is not released after analysis completes

Previous investigation notes:
- Leak appears to be in the correlation calculation
- Possibly related to LINQ query materialization

Requirements:
- Fix the memory leak
- Add memory profiling tests to prevent regression
- Maintain the same public API
- Document the root cause and solution
- Ensure no performance degradation

Include before/after memory usage metrics in your tests.
```

### Refactoring

```markdown
Refactor the JournalService to improve testability and separation of concerns.

Current issues:
- Service has multiple responsibilities (CRUD, encryption, validation)
- Difficult to unit test due to tight coupling
- Database access mixed with business logic

Refactoring goals:
- Extract encryption into separate service
- Implement repository pattern for data access
- Use MediatR for command/query separation
- Maintain backward compatibility
- Achieve 90%+ test coverage

Ensure all existing tests continue to pass and add new tests for extracted components.
```

### Test Implementation

```markdown
Write comprehensive tests for the SociallyFed pattern discovery algorithm.

Test categories needed:
1. Unit tests for correlation calculations
2. Integration tests with real journal data
3. Edge cases (single entry, no patterns, all entries identical)
4. Performance tests (measure time for 100, 500, 1000 entries)
5. Statistical accuracy tests (known patterns should be detected)

Specific scenarios:
- User journals every Monday about work stress
- Sleep quality correlates with social media usage
- Exercise frequency impacts mood ratings
- No patterns exist (random data)

Use the test data factory pattern for generating realistic journal entries.
```

## Testing Prompts (Ollama)

### Prompt Templates for Local LLM

#### Sentiment Analysis

```python
SENTIMENT_ANALYSIS_PROMPT = """Analyze the emotional content of this journal entry.

Return a JSON object with this exact structure:
{
    "primary_emotion": "joy|sadness|anger|fear|surprise|disgust",
    "secondary_emotions": ["list", "of", "other", "emotions"],
    "intensity": 0.0-1.0,
    "valence": -1.0 to 1.0 (negative to positive),
    "confidence": 0.0-1.0
}

Important: Return ONLY the JSON object, no additional text.

Journal entry: {entry_text}
"""
```

#### Pyramid Categorization

```python
PYRAMID_CATEGORIZATION_PROMPT = """Categorize this activity into the SociallyFed Pyramid:

Level 1 - Served Content: Algorithmic feeds, passive consumption (minimize)
Level 2 - Connection Building: Building relationships, community engagement
Level 3 - Integrated Activities: Real-life integrated social media use
Level 4 - Sought Content: Actively searched, intentional content (maximize)

Consider:
- User's intent (purposeful vs passive)
- Engagement level (active vs passive)
- Value creation (contributing vs consuming)
- Attention quality (focused vs scattered)

Activity: "{activity_description}"

Respond with ONLY a number 1-4.
"""
```

#### Pattern Detection

```python
PATTERN_DETECTION_PROMPT = """Analyze these journal entries for behavioral patterns.

Look for:
- Repeated themes or topics
- Temporal patterns (time of day, day of week)
- Cause-effect relationships
- Emotional triggers
- Activity correlations

Entries:
{entries_json}

Return a JSON array of detected patterns:
[
  {
    "pattern_type": "temporal|causal|thematic|emotional",
    "description": "brief description of pattern",
    "confidence": 0.0-1.0,
    "occurrences": number,
    "examples": ["entry_id1", "entry_id2"]
  }
]

Return ONLY the JSON array.
"""
```

### Testing Integration Prompts

```python
# Test prompt effectiveness
def test_pyramid_categorization_accuracy():
    test_cases = [
        ("Spent 2 hours mindlessly scrolling Instagram", 1),
        ("Joined a local community group on Facebook", 2),
        ("Used social media to coordinate a real-world event", 3),
        ("Searched for specific educational content on YouTube", 4),
    ]
    
    prompt_template = PYRAMID_CATEGORIZATION_PROMPT
    
    for activity, expected in test_cases:
        prompt = prompt_template.format(activity_description=activity)
        result = ollama.generate(prompt)
        # Validate result matches expected
```

## Real SociallyFed Examples

### Example 1: Journal Entry Encryption Feature

**Planning Prompt (Senior Claude)**:

```markdown
Design a journal entry encryption system for SociallyFed that ensures complete privacy while maintaining usability.

Context:
- Users are privacy-conscious individuals using journaling for personal growth
- Entries contain sensitive emotional and behavioral data
- Must work on mobile devices with limited resources
- Users might forget passwords but need data recovery options

Requirements:
1. End-to-end encryption (server never sees plaintext)
2. Biometric unlock on mobile devices
3. Secure key recovery without compromising zero-knowledge
4. Support for entry sharing with therapists (future feature)
5. Maintain search functionality on encrypted data

Please provide a complete technical specification including cryptographic approach, key management, and implementation guidance.
```

**Implementation Prompt (Claude Code)**:

```markdown
Implement the journal encryption service based on the provided specification.

Key components from spec:
- AES-256-GCM for entry encryption
- PBKDF2 for key derivation from passphrase
- Secure enclave for biometric-protected key storage
- Encrypted search index using homomorphic properties

Create:
1. IEncryptionService interface
2. AesGcmEncryptionService implementation
3. BiometricKeyManager for mobile platforms
4. Comprehensive test suite including:
   - Encryption/decryption round trips
   - Key derivation consistency
   - Performance benchmarks
   - Edge cases (empty, Unicode, max length)

Follow SOLID principles and ensure thread safety.
```

**Result**: Feature implemented in 8 hours vs 20-hour traditional estimate

### Example 2: Pattern Discovery Algorithm

**Planning Prompt (Senior Claude)**:

```markdown
Create a pattern discovery system for SociallyFed that identifies correlations between user behaviors and emotional states.

User story:
"As a user, I want to understand what behaviors affect my mood so I can make informed lifestyle changes."

Examples of patterns to detect:
- "Poor sleep on days with >2 hours social media"
- "Anxiety increases after consuming political news"
- "Mood improves on days with morning exercise"
- "Sunday evening anxiety before work week"

Technical requirements:
- Process 90 days of data in <5 seconds
- Identify both positive and negative correlations
- Statistical significance (p < 0.05)
- Present as testable hypotheses, not facts
- Local processing only (privacy)

Design the algorithm, data structures, and user presentation approach.
```

**Implementation Prompt (Claude Code)**:

```markdown
Read the pattern discovery specification and implement the correlation engine.

Implementation requirements:
- Use Pearson correlation for continuous variables
- Chi-square test for categorical associations
- Time-series analysis for temporal patterns
- Sliding window approach for efficiency

Key classes to implement:
1. PatternDiscoveryEngine
2. CorrelationCalculator  
3. TemporalPatternAnalyzer
4. PatternHypothesisGenerator
5. StatisticalSignificanceTester

Include:
- Memory-efficient processing for mobile devices
- Progress callbacks for UI updates
- Cancellation support
- Comprehensive logging (without exposing user data)

Write tests for statistical accuracy using known datasets.
```

### Example 3: Local LLM Integration

**Planning Prompt (Senior Claude)**:

```markdown
Design the integration between SociallyFed and local Ollama LLM for privacy-preserving AI features.

Core features requiring LLM:
1. Pyramid level categorization of activities
2. Sentiment analysis of journal entries
3. Theme extraction from text
4. Pattern description generation

Constraints:
- Zero network calls for AI processing
- <2 second response time per analysis
- Graceful degradation if LLM unavailable
- Consistent results across devices

Architecture requirements:
- Abstraction layer for future model changes
- Prompt template management
- Response parsing and validation
- Error handling and fallbacks
- Performance monitoring

Provide implementation specification with example code.
```

**Testing Prompts (Ollama)**:

```python
# Actual prompts used in production
CATEGORIZATION_TEST = """Rate this activity 1-4 on the SociallyFed Pyramid:
1=Served Content, 2=Connection Building, 3=Integrated Activities, 4=Sought Content

"Spent an hour reading philosophy and taking notes"

Answer with only the number."""

SENTIMENT_TEST = """Analyze emotions in: "Today was rough. Work was overwhelming and I couldn't focus. Ended up scrolling social media for hours which made me feel worse."

Return JSON:
{"primary": "emotion", "intensity": 0.0-1.0, "valence": -1.0 to 1.0}"""
```

## Prompt Engineering Best Practices

### 1. Structure and Clarity

**Good Example**:
```markdown
Create a notification service for SociallyFed with these requirements:

Functional Requirements:
1. Push notifications for pattern discoveries
2. Daily journal reminders (customizable time)
3. Weekly progress summaries
4. Achievement celebrations

Technical Requirements:
- Support iOS and Android
- Respect quiet hours
- Batch similar notifications
- Track engagement metrics

Deliverables:
1. Service interface definition
2. Implementation with platform abstraction
3. Test suite with mocking
4. Integration guide
```

**Poor Example**:
```markdown
I need notifications for the app. Should work on phones and not be annoying. Make it good.
```

### 2. Context Provision

**Effective Context**:
```markdown
Context: SociallyFed uses local Ollama for AI processing to maintain privacy. Current response time is 3s average, target is <2s.

Task: Optimize the prompt processing pipeline.

Current implementation:
[Include relevant code]

Bottlenecks identified:
- Prompt template rendering: 0.5s
- HTTP call to Ollama: 2.2s
- Response parsing: 0.3s

Optimize while maintaining accuracy.
```

### 3. Specificity in Requirements

**Specific Requirements**:
```markdown
Implement rate limiting for the pyramid analysis API:
- 10 requests per minute per user
- 100 requests per hour per user
- Return 429 with Retry-After header
- Use Redis for distributed counting
- Bypass for premium users (future)
- Include metrics for monitoring
```

**Vague Requirements**:
```markdown
Add some rate limiting to prevent abuse.
```

### 4. Output Format Specification

**Clear Output Format**:
```markdown
Generate test data for journal entries with this structure:

{
  "id": "uuid",
  "userId": "uuid",
  "content": "Entry text 100-500 words",
  "createdAt": "ISO 8601 timestamp",
  "emotions": ["joy", "gratitude"],
  "pyramidLevel": 1-5,
  "tags": ["work", "reflection"]
}

Create 50 entries representing 30 days of journaling for a user experiencing gradual improvement in mental health.
```

## Troubleshooting Common Issues

### Issue: AI Not Understanding Requirements

**Problem**: Claude Code implements something different than specified

**Solution**: Use the sandwich approach:
```markdown
CONTEXT: [Provide background]
TASK: [Clear, specific request]
REQUIREMENTS: [Bulleted list]
EXAMPLE: [Show expected outcome]
CONSTRAINTS: [Any limitations]
```

### Issue: Over-Engineering

**Problem**: AI creates unnecessarily complex solutions

**Solution**: Add simplicity constraints:
```markdown
Implement user authentication.

IMPORTANT: 
- Use built-in ASP.NET Core Identity
- No custom crypto implementation
- Standard JWT tokens
- Minimal abstraction layers
- Follow YAGNI principle
```

### Issue: Missing Edge Cases

**Problem**: Implementation doesn't handle edge cases

**Solution**: Explicitly list edge cases:
```markdown
Implement the search function.

Edge cases to handle:
- Empty search query
- Special characters (!@#$%)
- SQL injection attempts
- Unicode (emoji, non-Latin scripts)
- Very long queries (>1000 chars)
- Null or undefined inputs
- Concurrent searches by same user
```

### Issue: Inconsistent Code Style

**Problem**: Generated code doesn't match project style

**Solution**: Provide style examples:
```markdown
Follow our coding conventions:

// Service pattern
public interface IServiceName
{
    Task<Result> MethodAsync(Parameter param);
}

// Implementation pattern  
public class ServiceName : IServiceName
{
    private readonly IDependency _dependency;
    
    public ServiceName(IDependency dependency)
    {
        _dependency = dependency ?? throw new ArgumentNullException(nameof(dependency));
    }
}

// Test pattern
[Fact]
public async Task MethodName_Condition_ExpectedResult()
{
    // Arrange
    // Act
    // Assert
}
```

## Advanced Techniques

### 1. Iterative Refinement

Start broad, then narrow:

```markdown
# Iteration 1
Design a caching strategy for SociallyFed.

# Iteration 2 (after initial response)
Refine the caching strategy to focus on pyramid analysis results. Consider mobile device storage limitations and sync requirements.

# Iteration 3 (after refinement)
Implement the Redis caching layer for pyramid analysis with these specific requirements: [detailed specs]
```

### 2. Comparative Analysis

```markdown
Compare these two approaches for pattern discovery:

Approach A: Real-time analysis on each journal entry
- Pros: Always up-to-date, no batch processing
- Cons: Higher CPU usage, potential for duplicate work

Approach B: Nightly batch analysis
- Pros: Efficient, can use more complex algorithms
- Cons: Delayed insights, scheduling complexity

Recommend the best approach for SociallyFed's use case considering mobile battery life and user engagement patterns.
```

### 3. Scenario-Based Prompts

```markdown
Walk through this user scenario and identify required implementations:

Scenario: 
1. User opens app after 3 days offline
2. Has written 10 journal entries locally
3. Connects to internet
4. App needs to sync entries
5. Run analysis on new entries
6. Merge with existing patterns
7. Show updated insights

What services, error handling, and UI feedback are needed?
```

### 4. Constraint-Driven Design

```markdown
Design the mobile sync system with these constraints:
- Maximum 5MB transfer per sync
- Must work on 3G connections
- Battery usage <2% per sync
- Support interrupted transfers
- Conflict resolution for edited entries
- End-to-end encryption maintained

Provide architecture addressing each constraint.
```

### 5. Test-Driven Prompt Development

```markdown
Here are the tests that must pass:

```csharp
[Fact]
public async Task Encryption_WithEmptyContent_ThrowsArgumentException()
[Fact]  
public async Task Encryption_RoundTrip_PreservesContent()
[Fact]
public async Task Encryption_DifferentKeys_CannotDecrypt()
[Fact]
public async Task Encryption_Performance_Under100ms()
```

Implement the EncryptionService to make these tests pass.
```

## Prompt Library

### Planning Phase Templates

```markdown
# Feature Specification Template
Feature: [Name]

User Story: As a [user type], I want [goal] so that [benefit].

Functional Requirements:
- [Requirement 1]
- [Requirement 2]

Technical Requirements:
- [Technical requirement 1]
- [Technical requirement 2]

Constraints:
- [Constraint 1]
- [Constraint 2]

Success Criteria:
- [Measurable outcome 1]
- [Measurable outcome 2]

Please provide:
1. Technical architecture
2. Data models
3. API design
4. Implementation plan
5. Test scenarios
```

### Implementation Phase Templates

```markdown
# Implementation Request Template
Implement [feature name] based on the specification in [document].

Key Points:
- [Important aspect 1]
- [Important aspect 2]

Technical Requirements:
- [Specific tech requirement]
- Test coverage: [X]%
- Performance: [specific metric]

Follow existing patterns:
- [Pattern 1]
- [Pattern 2]

Start with [suggested starting point].
```

### Review Phase Templates

```markdown
# Code Review Request Template
Review the implementation of [feature]:

Files changed:
- [File 1]
- [File 2]

Focus areas:
1. [Specific concern 1]
2. [Specific concern 2]

Check for:
- Security vulnerabilities
- Performance issues
- Code maintainability
- Test coverage
- Documentation completeness
```

## Measuring Prompt Effectiveness

Track these metrics:

1. **First-Time Success Rate**: Did the AI understand and complete the task correctly on first attempt?
2. **Revision Rounds**: How many clarifications were needed?
3. **Output Quality**: Does the code meet standards without modification?
4. **Time to Completion**: How long from prompt to acceptable output?
5. **Edge Case Coverage**: Were edge cases handled without prompting?

## Conclusion

Effective prompting is a skill that improves with practice. The examples in this guide come from real SociallyFed development and have been refined through use. Key takeaways:

1. **Be Specific**: Vague prompts produce vague results
2. **Provide Context**: Help the AI understand the bigger picture
3. **Show Examples**: Demonstrate expected patterns and styles
4. **Iterate**: Refine prompts based on results
5. **Document Success**: Keep prompts that work well for reuse

As you develop your own projects using this workflow, build your own prompt library. What works best can vary by project, team, and AI model version.

---

*"The quality of the answers you get depends on the quality of the questions you ask." - Tony Robbins*

*In AI-assisted development, the quality of your code depends on the quality of your prompts.*