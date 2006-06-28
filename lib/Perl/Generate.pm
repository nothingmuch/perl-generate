#!/usr/bin/perl

package Perl::Generate;

use strict;
use warnings;

use Perl::Generate::AST::Node::Subcall;
use Perl::Generate::AST::Node::Var::Scalar;
use Perl::Generate::AST::Node::Assignment;

use Sub::Exporter -setup => {
	exports => [qw/call var assign/],
	groups  => {
		default => [':all']
	}
};

sub call ($;$) {
	my ( $subname, $args_expr ) = @_;

	return Perl::Generate::AST::Node::Subcall->new(
		subname => $subname,
		args    => $args_expr, # undef is OK
	);
}

sub var ($) {
	my $name = reverse shift;
	my $sigil = chop $name;
	$name = reverse $name;

	my %classes = (
		'$' => "Scalar",
		'@' => "Array",
		'%' => "Hash",
		'*' => "Glob",
		'&' => "Sub",
	);

	return "Perl::Generate::AST::Node::Var::$classes{$sigil}"->new(
		name => $name,
	);
}

sub assign ($$) {
	my ( $lvalue, $rvalue ) = @_;

	return Perl::Generate::AST::Node::Assignment->new(
		lvalue => $lvalue,
		rvalue => $rvalue,
	);
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate - Generate Perl 5 ASTs (and actual code) easily, a.k.a Perl-as-LISP.

=head1 SYNOPSIS

	use Perl::Generate;

	# $foo = doit($bar);
	eval assign( var('$foo'), call('doit', var('$bar') )->stringify;

=head1 DESCRIPTION

This module's purpose it to help you programmatically generate Perl code.

=cut


