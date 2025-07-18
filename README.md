# Usage

```sh
git clone --depth 1 -b main https://github.com/MohamedKari/acm-paper-template $PROJECT_NAME
cd $PROJECT_NAME 
rm README.md
rm -rf .git
git init
```

$ TAPS

- Do not include empty tex files
- Everything after \endinput is ignored, not only within the file 
- \autoref{<non-existent_label>} fails: Careful when adding sections one by one with forward references
