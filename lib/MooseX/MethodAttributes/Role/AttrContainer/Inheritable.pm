package MooseX::MethodAttributes::Role::AttrContainer::Inheritable;
# ABSTRACT: Capture code attributes in the automatically initialized metaclass instance

=head1 DESCRIPTION

This role extends C<MooseX::MethodAttributes::Role::AttrContainer> with the
functionality of automatically initializing a metaclass for the caller and
applying the meta roles relevant for capturing method attributes.

=cut

use Moose::Role;
use Moose::Util::MetaRole;
use Moose::Util qw/find_meta does_role/;

use namespace::clean -except => 'meta';

with 'MooseX::MethodAttributes::Role::AttrContainer';

before MODIFY_CODE_ATTRIBUTES => sub {
    my ($class) = @_;
    my $meta = find_meta($class);
    return if $meta && does_role($meta, 'MooseX::MethodAttributes::Role::Meta::Class');
    Moose::Util::MetaRole::apply_metaclass_roles(
        for_class                      => $class,
        metaclass_roles                => ['MooseX::MethodAttributes::Role::Meta::Class'],
        method_metaclass_roles         => ['MooseX::MethodAttributes::Role::Meta::Method'],
        wrapped_method_metaclass_roles => ['MooseX::MethodAttributes::Role::Meta::Method::Wrapped'],
    );
};

1;
