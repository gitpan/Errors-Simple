#!/usr/bin/perl

use warnings;
use strict;
use Errors::Simple;
package Errors::Simple::Test;
use base qw(Errors::Simple);

sub new	{
	return bless {}, shift;
}

sub something	{
	my $self = shift;
	$self->e_report("this didn't work");
	return undef;
}

1;
