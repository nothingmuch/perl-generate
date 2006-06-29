#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::Stmt::Generic";

use Perl::Generate::AST::Node::Var::Scalar;

can_ok("Perl::Generate::AST::Node::Stmt::Generic", "expr");
can_ok("Perl::Generate::AST::Node::Stmt::Generic", "ppi");
can_ok("Perl::Generate::AST::Node::Stmt::Generic", "stringify");

ok( Perl::Generate::AST::Node::Stmt::Generic->does("Perl::Generate::AST::Node::Stmt"), "does Stmt" );
ok( Perl::Generate::AST::Node::Stmt::Generic->does("Perl::Generate::AST::Node"), "does Node" );

my $s = Perl::Generate::AST::Node::Stmt::Generic->new(
	expr => Perl::Generate::AST::Node::Var::Scalar->new( name => "x" ),
);

is( $s->stringify, '$x;', "stringification" );

