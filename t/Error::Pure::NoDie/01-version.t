# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Pure::NoDie;
use Test::More 'tests' => 1;

# Test.
is($Error::Pure::NoDie::VERSION, 0.01, 'Version.');
