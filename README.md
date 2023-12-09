# Buildarr Documentation

To run locally, first create a virtual environment using Poetry.

```bash
poetry install
```

You can then run MkDocs to serve the website, and it will be accessible on `http://localhost:8000`.

```bash
poetry run mkdocs serve
```

The website is automatically built and deployed when pushed to `main` using GitHub Actions.
