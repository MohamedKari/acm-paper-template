if [ -z "$SOURCE_DIR" ]
then
      exit 1
fi

# REMOVE UNAUTHORIZED PACKAGES
grep -vE "^\\\RequirePackage\\{snapshot\\}" $SOURCE_DIR/$PROJECTNAME.tex > $SOURCE_DIR/$PROJECTNAME-processed.tex
mv $SOURCE_DIR/$PROJECTNAME-processed.tex $SOURCE_DIR/$PROJECTNAME.tex

# REMOVE PACKAGE EXPORTS
# make sure SOURCE_DIR is not empty, otherwise the next command is fatal
if [ -z "$SOURCE_DIR" ]
then
      exit 1
fi
rm -rf $SOURCE_DIR/usr