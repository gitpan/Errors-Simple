#!/usr/bin/perl

package Errors::Simple;

$Errors::Simple::VERSION = "0.1";

use strict;
#use warnings;

sub e_new	{
	my $class = shift;
		$class = ref($class) || $class;
	
	return bless {}, $class;
}

#constructor
sub e_init {
	my $self = shift;
	$$self{_errors} = [] unless $$self{_errors};
}

#report an error
sub e_report {
	my $self = shift;
	my $err  = shift;

	$self->e_init();

	push @{$self->{_errors}}, $err;
}

#check to see if there are any errors
sub e_check	{
	my $self = shift;
	$self->e_init();

	return scalar(@{$self->{_errors}})
}

#get the list of errors
sub e_get	{
	my $self = shift;
	$self->e_init();
	return @{$self->{_errors}}
}

#return a string of text showing the reported errors
sub e_text	{
	my $self = shift;
	$self->e_init();

	if($self->e_get())	{
		my $ret = "ERROR:\n\n";

		foreach my $error (@{$$self{_errors}})	{
			$ret .= "\t$error\n"
		}

		$ret .= "-----";

		return $ret;
	}

	return undef;
}

#return a string of text showing the reported errors
sub e_html	{
	my $self = shift;
	$self->e_init();

	if($self->e_get())	{
		my $ret = "<p>ERROR:</p>";

		foreach my $error (@{$$self{_errors}})	{
			$error =~ s/>/&gt;/g;
			$error =~ s/>/&lt;/g;
			$ret .= "<p><pre>$error</pre></p>"
		}

		$ret .= "<p>-----</p>";

		return $ret;
	}

	return undef;
}

#flush
sub e_flush	{
	my $self = shift;
	$self->e_init();
	@{$self->{_errors}} = ();
}

=pod

=head1 NAME

Errors::Simple - Simple and but capable error management

=head1 VERSION

Version 0.1

=head1 DESCRIPTION

This is a simple error management and reporting module with more capabilities
than other "simple" modules I found, but remains lightweight. For more robust
error management, see Errors::Errors(3). Errors::Simple has been very
handy for me when dealing with methods that can go wrong in multiple ways,
particularly with methods that validate multiple pieces of form data.

=head1 SYNOPSIS

Your module:

	package Foo;
	use Errors::Simple;
	use base qw(Errors::Simple);
	
	sub new	{
		return bless {}, shift
	}

	sub something	{
		my $self = shift;

		if($something_works)	{
			return 1
		}
		elsif(!$something_else_works)	{
			$self->e_report("Could not do something else
				because of descriptive reason");
			return undef;
		}
		else	{
			$self->e_report("Could not do something because of
				descriptive reason");
			return undef;
		}
	}

Your calling file:

	$foo = Foo->new();
	if(!$foo->something() && $foo->e_check())	{
		print $foo->e_text();
	}

=head1 METHODS

=head2 e_new()

Create a new Errors::Simple object, in case you want one. No arguments
required

=head2 e_init()

This is a private method that is called behind the scenes, you probably
won't need it. It creates the needed data structure required for storing
errors. This is called in most functions so that no initialization code
is required in your subclass.

=head2 e_report($message)

This adds $message to the error list

=head2 e_check()

Checks to see if any errors have been reported (see e_report()). If errors
are found, the number of errors reported is returned, 0 otherwise

=head2 e_get()

This returns a copy of the error list (array).

=head2 e_text()

Returns a string representing all the errors that have been reported.
If no errors were found, returns an empty string. Also see e_html()

=head2 e_html()

Similar to e_text() except it is HTML-friendly. Returns HTML representation
of errors reported. Empty string if none found

=head2 e_flush()

Removes all reported errors

=head1 AUTHOR

sili@cpan.org -- Feel free to email me with questions, suggestions, etc

=head1 SEE ALSO

perl(1), Errors::Errors(3), Error(3)

=head1 LICENSE

Same as perl itself

=cut


1;
