#!/usr/bin/perl

package Perl::Generate::AST::Node::Subcall;
use Moose;

with qw/
	Perl::Generate::AST::Node::RV
/;

has subname => (
	isa => "Str",
	is  => "rw",
	required => 1,
);

has args => (
	does => "Perl::Generate::AST::Node::Expr",
	is   => "rw",
	required => 0,
);

sub ppi {
	my $self = shift;


	my $args = PPI::Structure::List->new( PPI::Token::Structure->new('(') );

	if ( my $args_expr = $self->args ) {
		$args->__add_element($_) for $args_expr->ppi;
	}

	$args->_set_finish( PPI::Token::Structure->new(')') );

	return (
		PPI::Token::Word->new($self->subname),
		$args,
	);
}

__PACKAGE__;

__END__
