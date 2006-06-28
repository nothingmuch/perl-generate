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

	my $s = PPI::Statement::Expression->new( PPI::Token::Word->new( $self->subname ) );

	my $args = PPI::Structure::List->new( PPI::Token::Structure->new('(') );

	if ( my $args_expr = $self->args ) {
		$args->__add_element( $args_expr->ppi );
	}

	$args->_set_finish( PPI::Token::Structure->new(')') );

	$s->__add_element( $args );

	$s;
}

__PACKAGE__;

__END__
