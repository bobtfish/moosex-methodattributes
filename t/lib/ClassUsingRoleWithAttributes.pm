package Other::Role;
use Moose::Role;

package ClassUsingRoleWithAttributes;
use Moose;

use namespace::clean -except => 'meta';

with 'RoleWithAttributes';

__PACKAGE__->meta->make_immutable;

