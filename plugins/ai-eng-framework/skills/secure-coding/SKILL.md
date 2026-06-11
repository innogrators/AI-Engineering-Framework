---
name: secure-coding
description: Use when implementing or reviewing anything security-relevant — authentication, authorization, file uploads, jobs touching external systems, output generation (e.g. HTML/PDF/email/print), secrets, datastore access, HTTP headers/CORS — or when the user asks for a security review or threat model.
---
# secure-coding

OWASP/ASVS-aligned controls. Apply to security-relevant changes; report findings with severity (a Blocker = NO-GO). Reference the project's security requirements in `CLAUDE.md`. Output language: **English**.

**Threat model (STRIDE, brief):** map trust boundaries (client->API, API->datastore, worker->external systems, upload->storage) and the main control per boundary.

**Mandatory controls:**
1. **AuthN:** hash passwords with a strong KDF (Argon2id/bcrypt cost>=12); never store/log plaintext. Prefer httpOnly+Secure+SameSite cookies (+ CSRF); if bearer tokens in web storage, compensate with strict CSP + short TTL. Rate-limit/lockout on login.
2. **AuthZ:** deny-by-default; every endpoint guarded server-side; object-level authorization (can THIS user act on THIS resource?). Client-side hiding is not security.
3. **Input validation:** validate all input (DTOs, uploads, imported files) at the boundary; reject unknown fields.
4. **Injection at sinks:** parameterized queries only (no string concatenation); escape user data in HTML/PDF templates; sanitize data passed to external sinks (e.g. shell/CLI, print/label commands); validate email recipients, no CRLF in headers.
5. **Uploads:** check MIME (sniffing) + size; re-encode images to strip metadata; store with generated names outside the web root; no client-controlled paths.
6. **Integrity/audit:** keep audit logs append-only (e.g. restrict UPDATE/DELETE at the DB-role level); log security events.
7. **Transport/headers:** TLS + HSTS; security headers; CORS restricted to known origins; no wildcard with credentials.
8. **Secrets:** only via env/secret store; never in git; least privilege for service accounts; no debug stacktraces to clients.
9. **Dependencies:** lockfile committed; dependency audit in CI with no High/Critical at release (or documented exception); pin base images.
10. **Logging/privacy:** no secrets/PII in logs; data minimization; retention/anonymization where applicable.

**Output:** prioritized findings (risk + fix + requirement ID). One open Blocker = NO-GO.
