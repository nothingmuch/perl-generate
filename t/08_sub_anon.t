#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::Sub::Anon";

use Perl::Generate::AST::Node::Var::Scalar;

can_ok( "Perl::Generate::AST::Node::Sub::Anon", "body" );
can_ok( "Perl::Generate::AST::Node::Sub::Anon", "ppi" );
can_ok( "Perl::Generate::AST::Node::Sub::Anon", "stringify" );

my $sub = Perl::Generate::AST::Node::Sub::Anon->new(
	body => Perl::Generate::AST::Node::Block->new(),
);

is( $sub->stringify, "sub {}", "empty sub" );

my $ret_var = Perl::Generate::AST::Node::Sub::Anon->new(
	body => Perl::Generate::AST::Node::Var::Scalar->new( name => 'moose' ),
);

is( $ret_var->stringify, 'sub {$moose;}', "return a sub" );

my $many = Perl::Generate::AST::Node::Sub::Anon->new(
	body => Perl::Generate::AST::Node::Stmts->new(
		substatements => [
			Perl::Generate::AST::Node::Var::Scalar->new( name => 'foo' ),
			Perl::Generate::AST::Node::Var::Scalar->new( name => 'bar' ),
		],
	),
);

is( $many->stringify, 'sub {$foo;$bar;}', "body as statements" );

my $proto = Perl::Generate::AST::Node::Sub::Anon->new(
	proto => '$$',
);

is( $proto->stringify, 'sub ($$) {}', "sub with proto" );
