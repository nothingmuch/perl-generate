#!/usr/bin/perl

package Perl::Generate::AST::Node::Stmts;
use Moose;
use Moose::Util::TypeConstraints;

use Perl::Generate::AST::Node::Stmt;

with qw/
	Perl::Generate::AST::Node
/;

coerce "Perl::Generate::AST::Node::Stmts"
	=> from "ArrayRef",
	=> via { Perl::Generate::AST::Node::Stmts->new( substatements => $_ ) },
	=> from "Perl::Generate::AST::Node",
	=> via { Perl::Generate::AST::Node::Stmts->new( substatements => [ $_ ] ) };

use Carp qw/croak/;

has substatements => (
	isa => "ArrayRef",
	is  => "rw",
	required   => 1,
	auto_deref => 1,
);

my $stmt_c = Moose::Util::TypeConstraints::find_type_constraint("Perl::Generate::AST::Node::Stmt")->coercion;
sub new {
	my ( $class, %params ) = @_;

	my $statements = delete $params{substatements} || [];

	ref($statements) && ref($statements) eq "ARRAY"
		or croak "The substatements must be an array";

	$statements = [ map { my $x = $stmt_c->coerce($_) } @$statements ];

	$params{substatements} = $statements;

	$class->SUPER::new( %params );
}

sub ppi {
	my $self = shift;
	return map { $_->ppi } $self->substatements;
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate::AST::Node::Stmts - 

=head1 SYNOPSIS

	use Perl::Generate::AST::Node::Stmts;

=head1 DESCRIPTION

=cut


