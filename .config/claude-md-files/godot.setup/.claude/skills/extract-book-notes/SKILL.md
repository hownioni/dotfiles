# Extract book notes

Extracts opinionated, project-specific notes from a book PDF using a Haiku agent and saves
the result to `docs/book-notes/`.

**Arguments:** $ARGUMENTS

---

Parse the arguments above. You are looking for two things:

1. A PDF file path (the first argument, or a path ending in `.pdf`)
2. A book title and author (the remaining text, treated as a single string)

**If both are present**, run the extraction script immediately:

```bash
python scripts/extract_book_notes.py --pdf "<pdf_path>" --title "<book_title>"
```

**If either is missing**, ask the user for what's needed before running:

- Missing PDF: "What is the path to the book PDF?"
- Missing title: "What is the book's title and author?"

---

After the script finishes:

1. Tell the user the output file path.
2. Show them the first 20 lines of the generated file so they can spot-check quality.
3. Remind them to reference it during relevant coding sessions with `@docs/book-notes/<filename>.md`.

If the script fails because `anthropic` is not installed, create a venv with `uv venv`, run `uv pip install anthropic`, then retry.
