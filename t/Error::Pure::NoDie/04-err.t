# Pragmas.
use strict;
use warnings;

# Modules.
use English qw(-no_match_vars);
use Error::Pure::NoDie qw(err);
use Test::More 'tests' => 5;
use Test::Output;

# Test.
eval {
	err 'Error.';
};
is($EVAL_ERROR, "Error.\n", 'Simple message in eval.');

# Test.
eval {
	err 'Error.', 1, 2;
};
is($EVAL_ERROR, "Error.\n", '3 messages in eval.');

# Test.
eval {
	err 'Error.';
};
my $tmp = $EVAL_ERROR;
eval {
	err $tmp;
};
is($EVAL_ERROR, "Error.\n", 'Recursive eval.');

# Test.
stdout_is(
	sub {
		err 'Error';
		return;
	},
	"Error\n",
	'Print error instead die.',
);

# Test.
stdout_is(
	sub {
		err 'Error', 1, 2;
		return;
	},
	"Error12\n",
	'Print error instead die. Version with more messages.',
);
