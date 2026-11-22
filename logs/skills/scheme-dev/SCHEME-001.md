# SCHEME-001

Requested a reusable Scheme development skill based on the uploaded assignment.

- Exact prompt in [scheme-dev.md](../../../prompts/skills/scheme-dev.md).
- Verbatim reply in [SCHEME-001.response.md](SCHEME-001.response.md).
- Saved [SKILL.md](../../../skills/scheme-dev/SKILL.md) with the YAML opening delimiter on the first line. Removed the leading blank line from the skill copy.

## Verification

- `Get-FileHash` matched the saved response to the pasted attachment.
- `$check | python -` parsed the YAML with PyYAML and verified the metadata, Scheme allowlist, S2-only `read` exception, and required sections.
- `git diff --check` exited successfully. Git reported a line-ending conversion warning for the existing README edit.
