#!/usr/bin/perl
# Look, it was an evening hack. If I'd known I was going to have
# users, I'd have made sure it works.

$kpse =1; # Turn this on for kpathsea searching.
# PS: I lied about texinputs.
$debug=0;
$VERSION="0.03";

$initialfile = shift || usage();
@files = $initialfile;
@deps = $initialfile;

# This hash contains most of the program's magic.
# On the left, a stringified regexp returning a filename in $1
# On the right, the default extension for that filename.
%magical = (
	'\\\\(?:input|include)[\\s\\{]+(.*?)[\\s\\}]+' => "tex",
	'\\\\usepackage\\{(.*?)\\}' => "sty",
	'\\\\bibliographystyle\\{(.*?)\\}' => "bst",
	'\\\\bibliography\\{(.*?)\\}' => "bib",
	'\\\\includegraphics(?:\\[.*?\\])?\\{(.*?)\\}' => "eps",
	'\\\\documentclass(?:\\[.*?\\])?\\{(.*?)\\}' => "cls",
);

# Keep looping while there are still things to do.
while (@files) {
	$filename = shift @files;
	warn "Couldn't open $filename" unless open F, "<$filename";

	# Go through each line looking for things.
	while (<F>) {
		# Check against each pattern in turn.
		foreach $re (keys %magical) {
			# The /g is very clever. Can you see why?
			while (/$re/g) {
			       $newfile=$1;
			       $newfile.=".".$magical{$re} unless $newfile=~/.*\..*/;
			       $newfile=resolve($newfile);
			       push @deps, $newfile if $newfile;
			       push @files, $newfile if $newfile;
			}
		}
	}
	close F;
}

# Print 'em out.
foreach (@deps) { print $_."\n"; }
		 
sub resolve {
	$what=shift;
	$resolution="";
	# Kpse is done by passing the extension and the name to
	# kpsewhich.
	if ($kpse) {
		$ext=($what=~/.*\.(.*)/)[0];
		$resolution = `kpsewhich $ext $what`;
		chomp($resolution);
		print "kpsewhich $ext $what gave $resolution\n" if $debug;
		warn "! kpse couldn't find $what (in $filename)\n" unless $resolution;
	} else { $resolution = $what }
	return unless $resolution;
	warn "! Couldn't find $resolution (in $filename)\n" unless -e $resolution;
	return $resolution
}

sub usage {
	print <<EOF;
This is TeXdeps, Version $VERSION
Copyright 1999 Simon Cozens. (simon\@brecon.co.uk)

Syntax: texdeps (filename).tex

TeXdeps is a tool to help you determine all the dependencies of a
TeX or LaTeX input file. It optionally uses kpsewhich to find files.

Use it to create Makefiles or easily package up your project:
	tar czf project.tar.gz `texdeps project.tex`

This software is released under the LPPL, although I'd *really*
appreciate it if change requests went through me, so everyone
can benefit from them. Have fun!
EOF
exit;
}
