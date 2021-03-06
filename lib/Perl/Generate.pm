#!/usr/bin/perl

package Perl::Generate;

use strict;
use warnings;

use Perl::Generate::AST::Node::Subcall;
use Perl::Generate::AST::Node::Var::Scalar;
use Perl::Generate::AST::Node::Assignment;
use Perl::Generate::AST::Node::Stmts;
use Perl::Generate::AST::Node::If;
use Perl::Generate::AST::Node::Sub::Anon;
use Perl::Generate::AST::Node::Sub::Named;
use Perl::Generate::AST::Node::Const;


use Sub::Exporter -setup => {
	exports => [qw/call var assign cond stmts asub nsub str num/],
	groups  => {
		default => [':all']
	}
};

sub call ($;$) {
	my ( $code, $args_expr ) = @_;

	return Perl::Generate::AST::Node::Subcall->new(
		code => $code,
		args => $args_expr, # undef is OK
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

sub asub ($;$) {
	my $proto = shift if @_ == 2;
	my $body  = shift;

	return Perl::Generate::AST::Node::Sub::Anon->new(
		proto => $proto,
		body  => $body,
	);
}

sub nsub ($$;$) {
	my $name  = shift;
	my $proto = shift if @_ == 2;
	my $body  = shift;

	return Perl::Generate::AST::Node::Sub::Named->new(
		name  => $name,
		proto => $proto,
		body  => $body,
	);
}

sub num ($) {
	my $val = shift;
	return Perl::Generate::AST::Node::Const::Num->new( value => $val );
}

sub str ($) {
	my $val = shift;
	return Perl::Generate::AST::Node::Const::Str->new( value => $val );
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


