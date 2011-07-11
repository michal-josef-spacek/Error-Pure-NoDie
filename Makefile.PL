# Pragmas.
use strict;
use warnings;

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'AUTHOR' => 'Michal Špaček <skim@cpan.org>',
	'BUILD_REQUIRES' => {
		'File::Object' => 0.01,
		'Test::More' => 0,
		'Test::Output' => 0,
		'Test::Pod' => 0,
		'Test::Pod::Coverage' => 0,
	},
	'CONFIGURE_REQUIRES' => {
		'ExtUtils::MakeMaker' => 0,
	},
	'LICENSE' => 'bsd',
	'NAME' => 'Error::Pure::NoDie',
	'PREREQ_PM' => {
		'Error::Pure::Utils' => 0.01,
		'Exporter' => 0,
		'List::MoreUtils' => 0,
		'Readonly' => 0,
	},
	'VERSION' => 0.01,
	'test' => {
		'TESTS' => 't/Error::Pure::NoDie/*.t',
	},
);
