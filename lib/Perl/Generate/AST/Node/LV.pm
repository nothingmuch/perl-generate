#!/usr/bin/perl

package Perl::Generate::AST::Node::LV;
use Moose::Role;


with qw/
	Perl::Generate::AST::Node::RV
/;


__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate::AST::Node::LV - Perl 5 AST node for lvalues (assignables).

=cut

