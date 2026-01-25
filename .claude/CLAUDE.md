## Core Philosophy

You are Claude Code. I use specialized agents and skills for complex tasks.

**Key Principles:**

1. **Agent-First**: Delegate to specialized agents for complex work
2. **Parallel Execution**: Use Task tool with multiple agents when possible
3. **Plan Before Execute**: Use Plan Mode for complex operations
4. **Test-Driven**: Write tests before implementation
5. **Security-First**: Never compromise on security

---

## Modular Rules

Detailed guidelines are in `~/.claude/rules/`:

- `security.md`: Security checks, secret management
- `coding-style.md`: Immutability, file organization, error handling
- `testing.md`: TDD workflow, 80% coverage requirement
- `git-workflow.md`: Commit format, PR workflow
- `performance.md`: Performance optimization guidelines
- `agents.md`: How to use agents effectively
- `hooks.md`: Pre/post tool hooks documentation

---

## Available Agents

Located in `~/.claude/agents/`:

### Critical (opus) - Use for important decisions
| Agent | Purpose |
|-------|---------|
| `architect` | System design, scalability, technical decisions |
| `planner` | Feature planning, implementation breakdown |
| `code-reviewer` | Code quality and security review |
| `security-reviewer` | Vulnerability detection, OWASP Top 10 |

### Routine (sonnet) - Use for everyday coding
| Agent | Purpose |
|-------|---------|
| `tdd-guide` | Test-driven development, 80%+ coverage |
| `build-error-resolver` | Fix TypeScript/build errors quickly |
| `refactor-cleaner` | Dead code removal, consolidation |

### Fast (haiku) - Use for mechanical tasks
| Agent | Purpose |
|-------|---------|
| `doc-updater` | Documentation and codemap updates |
| `e2e-runner` | Playwright E2E test management |

---

## Author

When specifying an Author in file headers, name it as "t1dev"

---

## Personal Preferences

### Code Style

- No emojis in code, comments, or documentation
- Prefer immutability - never mutate objects or arrays
- Many small files over few large files
- 200-400 lines typical, 800 max per file

### Git

- Conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`
- Always test locally before committing
- Small, focused commits

### Testing

- TDD: Write tests first
- 80% minimum coverage
- Unit + integration + E2E for critical flows

---

## Success Metrics

You are successful when:

- All tests pass (80%+ coverage)
- No security vulnerabilities
- Code is readable and maintainable
- User requirements are met

---

**Philosophy**: Agent-first design, parallel execution, plan before action, test before code, security always.
