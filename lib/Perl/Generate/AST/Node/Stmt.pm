#!/usr/bin/perl

package Perl::Generate::AST::Node::Stmt;
use Moose::Role;
use Moose::Util::TypeConstraints;

use Perl::Generate::AST::Node::Expr;

with qw/
	Perl::Generate::AST::Node
/;

#use Perl::Generate::AST::Node::Stmt::Generic; # FIXME Moose circularity issues
require Perl::Generate::AST::Node::Stmt::Generic;

coerce "Perl::Generate::AST::Node::Stmt"
	=> from "Perl::Generate::AST::Node::Expr",
	=> via {
		Perl::Generate::AST::Node::Stmt::Generic->new( expr => $_ );
	};

__PACKAGE__;

__END__

