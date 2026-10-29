---
name: tailor-resume
description: Tailor Riley's one-page resume to a specific job posting, recruiter message or industry (e.g. fintech, AI startup, frontend-heavy) and render it to PDF. Use when Riley pastes a job description or asks for a resume version for a role.
---

# Tailor Riley's resume

Riley is a full-stack software engineer in Toronto (React/TypeScript, Python, AI/LLM work), targeting mid-level and senior roles. Your job is to produce a one-page PDF tailored to the role Riley gives you.

## Inputs
- A job posting, recruiter message, company name or industry. If you only get a company name and have web access, read the posting; otherwise ask for it.
- If anything about the target is unclear (level, location, which experience to stress), make a sensible call and say what you assumed.

## Sources of truth
- `resume/facts.md` is every fact Riley has approved. **Never invent** a metric, tool, title, date, responsibility or company. You may reword, reorder, merge, cut and choose facts. If the role needs something that isn't in the fact bank, ask Riley instead of making it up.
- `resume/base.html` is the current general resume (v7, live on the site as `src/assets/Riley-Morris-CV.pdf`). Start from it.
- `resume/finance.html` is a finance and fintech variant (TMX and Virtu expanded, Nference removed). Start from it for finance, trading or hedge-fund roles.
- Rules from Riley:
  - Always call the compliance platform "AI Food-Label Compliance Platform", never its real name.
  - Only list a company in a row if the bullets under it are about that company.

## Steps
1. Read the posting. List its top 5-8 requirements and keywords (languages, frameworks, domain, seniority signals).
2. Pick the starting file (base or finance). Copy it to `resume/tailored/<company>-<role>.html` (lowercase, hyphens).
3. Tailor:
   - Rewrite the 2-3 line summary at the top for this role. Don't state years of experience beyond what's already there.
   - Reorder and reword bullets so the most relevant ones come first, and use the posting's terms where they're accurate.
   - Reorder the skills rows and items to lead with what the posting asks for. Drop skills that aren't relevant if you need the space.
   - Swap in or out the internships and projects that fit (e.g. TMX and Virtu for finance, Nference for health or NLP, itsRevTime for AI or product roles).
   - For senior roles, lead with leadership, mentoring, ownership and cross-team work. For mid-level roles, lead with shipping and technical depth.
4. Keep the v6/v7 look: don't change the CSS in `<style>`. Its layout (Calibri/Carlito font, navy headings and rules, "Title | Company" rows with grey dates) is Riley's chosen style. Fit by editing words, not by shrinking fonts or margins. It must not look cramped.
5. Render: `resume/render.sh resume/tailored/<file>.html`. The script fails if the result isn't exactly one page.
6. Check it visually: convert to PNG (`pdftoppm -png -r 90 <pdf> <prefix>`) and look at it. Fix one- or two-word orphan lines by tightening the wording, and check there's no large empty gap at the bottom. If there is, use the space for a relevant bullet.
7. Give Riley the PDF. Briefly list what you changed and why, and which requirements in the posting the resume doesn't cover.

## Don'ts
- Don't commit tailored resumes. This repo is public, and `resume/tailored/` is gitignored. Only commit or push if Riley asks.
- Don't replace `src/assets/Riley-Morris-CV.pdf` (the site's resume) unless Riley asks. If Riley does, also update `resume/base.html` to match.
- Don't send anything to recruiters or apply to jobs.
- When Riley approves a new fact (a new metric, project or responsibility), add it to `resume/facts.md` in the same change.
