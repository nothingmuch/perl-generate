#!/usr/bin/perl

package Perl::Generate;

use strict;
use warnings;

use Perl::Generate::AST::Node::Subcall;
use Perl::Generate::AST::Node::Var::Scalar;
use Perl::Generate::AST::Node::Assignment;
use Perl::Generate::AST::Node::Stmts;
use Perl::Generate::AST::Node::If;

use Sub::Exporter -setup => {
	exports => [qw/call var assign cond stmts/],
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

sub stmts (@) {
	my @stmts = @_;

	return Perl::Generate::AST::Node::Stmts->new(
		substatements => \@stmts,
	);
}

sub cond ($$;$) {
	my ( $cond, $true, $false ) = @_;

	return Perl::Generate::AST::Node::If->new(
		cond => $cond,
		true => $true,
		false => $false,
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


