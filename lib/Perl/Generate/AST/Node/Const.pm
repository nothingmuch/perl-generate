#!/usr/bin/perl

package Perl::Generate::AST::Node::Const;
use Moose::Role;
use Moose::Util::TypeConstraints;

with qw/
	Perl::Generate::AST::Node::LV
/;

{
	my %coercions;

	foreach my $const_type ( qw/Num Str/ ) {
		# FIXME Moose circularity issues
		my $class = "Perl::Generate::AST::Node::Const::$const_type";
		eval "require $class"; die $@ if $@;

		foreach my $to ( $class, map { $_->name } $class->meta->calculate_all_roles ) {
			push @{ $coercions{ $to } ||= [] }, from $const_type, via { $class->new( value => $_ ) };
		}
	}

	foreach my $to (keys %coercions) {
		coerce $to, @{ $coercions{$to} }
	}
}

__PACKAGE__;

__END__
