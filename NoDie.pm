package Error::Pure::NoDie;

# Pragmas.
use base qw(Exporter);
use strict;
use warnings;

# Modules.
use Error::Pure::Utils qw(err_helper);
use List::MoreUtils qw(none);
use Readonly;

# Version.
our $VERSION = 0.01;

# Constants.
Readonly::Array our @EXPORT_OK => qw(err);
Readonly::Scalar my $EMPTY_STR => q{};
Readonly::Scalar my $EVAL => 'eval {...}';

# Ignore die signal.
$SIG{__DIE__} = 'IGNORE';

# Process error.
sub err {
	my @msg = @_;

	# Get errors structure.
	my @errors = err_helper(@msg);

	# Error messages.
	chomp $errors[-1]->{'msg'}->[0];

	# Print out.
	my $stack_ar = $errors[-1]->{'stack'};
	if ($stack_ar->[-1]->{'class'} eq 'main'
		&& none { $_ eq $EVAL || $_ =~ /^eval '/ms }
		map { $_->{'sub'} } @{$stack_ar}) {

		print join $EMPTY_STR, @{$errors[-1]->{'msg'}}, "\n";

	# Die for eval.
	} else {
		my $e = $errors[-1]->{'msg'}->[0];
		die "$e\n";
	}

	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Error::Pure::NoDie - Error::Pure module for simple print instead die.

=head1 SYNOPSIS

 use Error::Pure::NoDie qw(err);
 err 'This is a fatal error', 'name', 'value';

=head1 SUBROUTINES

=over 8

=item B<err(@messages)>

 Process error with messages @messages.

=back

=head1 EXAMPLE1

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Error::Pure::NoDie qw(err);

 # Error.
 err '1';

 # Output:
 # 1

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Error::Pure::NoDie qw(err);

 # Error.
 err '1';
 err '2';

 # Output:
 # 1
 # 2

=head1 EXAMPLE3

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Error::Pure::NoDie qw(err);

 # Error.
 err '1', '2', '3';

 # Output:
 # 1

=head1 EXAMPLE4

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Dumpvalue;
 use Error::Pure::NoDie qw(err);
 use Error::Pure::Utils qw(err_get);

 # Error in eval.
 eval { err '1', '2', '3'; };

 # Error structure.
 my $err_ar = err_get();

 # Dump.
 my $dump = Dumpvalue->new;
 $dump->dumpValues($err_ar);

 # In $err_ar:
 # [
 #         {
 #                 'msg' => [
 #                         '1',
 #                         '2',
 #                         '3',
 #                 ],
 #                 'stack' => [
 #                         {
 #                                 'args' => '(1)',
 #                                 'class' => 'main',
 #                                 'line' => '9',
 #                                 'prog' => 'script.pl',
 #                                 'sub' => 'err',
 #                         },
 #                         {
 #                                 'args' => '',
 #                                 'class' => 'main',
 #                                 'line' => '9',
 #                                 'prog' => 'script.pl',
 #                                 'sub' => 'eval {...}',
 #                         },
 #                 ],
 #         },
 # ],

=head1 DEPENDENCIES

L<Exporter(3pm)>,
L<List::MoreUtils(3pm)>,
L<Readonly(3pm)>.

=head1 SEE ALSO

L<Error::Pure(3pm)>,
L<Error::Pure::AllError(3pm)>,
L<Error::Pure::Die(3pm)>,
L<Error::Pure::Error(3pm)>,
L<Error::Pure::ErrorList(3pm)>,
L<Error::Pure::Output::Text(3pm)>,
L<Error::Pure::Print(3pm)>.

=head1 AUTHOR

 Michal Špaček L<skim@cpan.org>
 http://skim.cz

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
