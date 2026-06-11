---
name: write-spec
description: Turns a raw requirement into a testable feature specification in specs/<feature>.md. Invoke explicitly via /write-spec. Does not implement.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob
---
# write-spec

**Goal:** turn an idea/requirement into an approvable spec in `specs/<feature>.md`, in the style of the project's requirements doc. **Do not implement.** Output language: **English**. Argument: `$ARGUMENTS`.

**Steps:**
1. Read existing context: project `CLAUDE.md` and requirements/architecture docs. Identify affected existing requirement IDs.
2. Clarify open points via the question set. For missing answers, make justified **default assumptions** and mark them.
3. Write the spec per the output format; assign requirement IDs in the project's scheme.
4. Add acceptance criteria as Gherkin for the critical paths.
5. Write `specs/<feature>.md` with `Status: DRAFT` and wait for approval. Approval = a human sets the status line to `Status: APPROVED (date / person)`; downstream skills check this line, never set it yourself.

**Question set:** user problem? actor/role? trigger? expected result? required vs optional fields? error cases & edge cases? touches the project's domain invariants/security/audit? data-model change (migration)? measurable success?

**Output (`specs/<feature>.md`):** Goal; User problem; Functional requirements (IDs, MoSCoW); Non-functional requirements (IDs); Acceptance criteria (Gherkin); Error cases & edge cases; Priorities; Measurable success criteria; Open assumptions; Affected files/components (hypothesis).

**Spec acceptance:** each requirement atomic, unambiguous, testable; each has >=1 acceptance criterion; security/audit relevance marked; no implementation detail except as hypothesis.

**Abort:** requirement too vague despite questions -> state assumptions explicitly and request approval; conflicts with a documented domain invariant -> STOP, ask.
