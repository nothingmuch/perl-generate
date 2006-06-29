#!/usr/bin/perl

package Perl::Generate::AST::Node::Stmt::Generic;
use Moose;
use Moose::Util::TypeConstraints;

use Perl::Generate::AST::Node::Expr;

with qw/
	Perl::Generate::AST::Node::Stmt
/;

has expr => (
	does => "Perl::Generate::AST::Node::Expr",
	is   => "rw",
	required => 1,
);

sub ppi {
	my $self = shift;

	my @ppi = $self->expr->ppi;

	my $s = PPI::Statement->new( shift @ppi );
	$s->__add_element( $_ ) for @ppi;
	$s->__add_element( PPI::Token::Structure->new(';') );

	return $s;
}

__PACKAGE__;

__END__


