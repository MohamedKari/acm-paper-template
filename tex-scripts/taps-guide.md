- Do not \input empty files
- No linebreak before \textcircled
- Don't use \endinput (everything after \endinput is ignored, not only within the file)
- No def of affiliation
- \autoref{<non-existent_label>} fails (tip: search for "?" in the PDF before upload to check whether there are unresolved references)
- Avoid comment environment, especially with indentation (whitespace before \begin{comment})
- General tip: you can also compile a HTML yourself first and resolve issues (however, this does not cover everything that can go wrong in TAPS)

# Uncertain
- \setitemsize can fail. It does not seem to fail all the time though, so the error message might be a side effect of something else. To be sure, rather use \begin{itemize}[leftmargin=9pt] at every itemize (also needs enumitem package).

# Works
- Renaming autorefs (e.g., \def\sectionautorefname{Section} ) works, but renaming to uppercase will still be written in lowercase in HTML

# Other
- Put labels of figures after the \caption{} and NOT after \Description{}. The latter works in PDF, but the HTML version only references the number without "Figure" and without hyperlink when using autoref. Similarly, only use one label per figure in the TAPS version so that HTML references work.
