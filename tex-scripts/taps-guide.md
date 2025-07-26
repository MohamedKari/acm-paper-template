- ensure html passes
- do not \input empty files
- no def of affiliation
- no linebreak before \textcircled
- don't use \endinput (everything after \endinput is ignored, not only within the file)
- \autoref{<non-existent_label>} fails --> Careful when adding sections one by one to test TAPS (comment out references to non-existent sections / figures / etc as well)
- Avoid comment environment, especially with indentation (whitespace before \begin{comment})

# Uncertain
- \setitemsize can fail. Rather use \begin{itemize}[leftmargin=9pt] at every itemize (also needs enumitem package)

# Works
- Renaming autorefs (e.g., \def\sectionautorefname{Section} ) works, but renaming to uppercase still written in lowercase in HTML

# Other
- Put labels of figures after the caption and NOT after Description. The latter works in PDF, but the HTML only references the number without "Figure" and without hyperlink when using autoref. Similarly, only use one label per figure in the TAPS version so that HTML references work.
