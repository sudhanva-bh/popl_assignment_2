# PROLOG-001

- Exact prompt in [prolog-dev.md](../../../prompts/skills/prolog-dev.md).
- Verbatim reply in [PROLOG-001.response.md](PROLOG-001.response.md).
- Saved the reply unchanged as [SKILL.md](../../../skills/prolog-dev/SKILL.md).

## Verification

- `Get-FileHash` matched the response log to the supplied attachment.
- `$check | python -` parsed the YAML header and checked the required sections, the library allowlist, prohibited operations, the P2 evaluation restriction, and the prompt decomposition rule. The skill and response log were byte-for-byte identical.
- `& 'C:/Program Files/swipl/bin/swipl.exe' --version` reported SWI-Prolog 9.2.9.
