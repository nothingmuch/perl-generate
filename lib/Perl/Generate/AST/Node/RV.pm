#!/usr/bin/perl

package Perl::Generate::AST::Node::RV;
use Moose::Role;

with qw/
	Perl::Generate::AST::Node::Expr
/;


__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate::AST::Node::RV - Perl 5 AST node for rvalues (just values).

=cut

