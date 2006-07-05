#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok "Perl::Generate::AST::Node::Block";

use Perl::Generate::AST::Node::Var::Scalar;
use Perl::Generate::AST::Node::Subcall;

can_ok( "Perl::Generate::AST::Node::Block", "ppi" );
can_ok( "Perl::Generate::AST::Node::Block", "body" );

my $empty = Perl::Generate::AST::Node::Block->new();

is( $empty->stringify, '{}', "stringified to empty block" );

my $several_exps = Perl::Generate::AST::Node::Block->new(
	body => [
		Perl::Generate::AST::Node::Var::Scalar->new(name => 'x'),
		Perl::Generate::AST::Node::Var::Scalar->new(name => 'y'),
	],
);

is( $several_exps->stringify, '{$x;$y;}', "multiple statements + coercion" );

my $subcall = Perl::Generate::AST::Node::Block->new( body => Perl::Generate::AST::Node::Subcall->new( code => "foo" ) );

is( $subcall->body->substatements->[0]->expr->stringify, 'foo()', "first substatement's expr" );
is( $subcall->body->substatements->[0]->stringify, 'foo();', "first substatement" );
is( $subcall->body->stringify, 'foo();', "subcall body" );
is( $subcall->stringify, '{foo();}', "subcall");
