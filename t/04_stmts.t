#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::Stmts";

use Perl::Generate::AST::Node::Var::Scalar;

can_ok("Perl::Generate::AST::Node::Stmts", "ppi");
can_ok("Perl::Generate::AST::Node::Stmts", "substatements");

my $empty = Perl::Generate::AST::Node::Stmts->new(); 

is( $empty->stringify, "", "empty statements generate correct code" );

my $one_sub = Perl::Generate::AST::Node::Stmts->new(
	substatements => [
		Perl::Generate::AST::Node::Stmt::Generic->new(
			expr => Perl::Generate::AST::Node::Var::Scalar->new( name => 'x' ),
		),
	],
);

is( $one_sub->stringify, '$x;', "one sub statement stringified" );

my $coerce = Perl::Generate::AST::Node::Stmts->new(
	substatements => [
		Perl::Generate::AST::Node::Var::Scalar->new( name => 'y' ),
	],
);

is( $coerce->stringify, '$y;', "statement wrappers autovivified" );

my $many = Perl::Generate::AST::Node::Stmts->new(
	substatements => [
		Perl::Generate::AST::Node::Var::Scalar->new( name => 'x' ),
		Perl::Generate::AST::Node::Var::Scalar->new( name => 'y' ),
	],
);

is( $many->stringify, '$x;$y;', "multiple statements" );

