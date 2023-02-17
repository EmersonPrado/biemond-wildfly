#
# Configures jgroups TCP-based stacks.
#
# @param properties TCP properties hash.
#
define wildfly::jgroups::stack::tcp (
  Hash             $properties,
  Optional[String] $profile = undef,
) {
  $stack = downcase($title)

  wildfly::jgroups::stack { $stack:
    profile   => $profile,
    protocols => [
      $title,
      'MERGE3',
      { 'FD_SOCK' => { 'socket-binding' => 'jgroups-tcp-fd' } },
      'FD',
      'VERIFY_SUSPECT',
      'pbcast.NAKACK2',
      'UNICAST3',
      'pbcast.STABLE',
      'pbcast.GMS',
      'UFC',
      'MFC',
      'FRAG2',
      'RSVP',
    ],
    transport => {
      'TCP' => {
        'socket-binding' => 'jgroups-tcp',
      },
    },
  }
  -> wildfly::resource { "/subsystem=jgroups/stack=${stack}/protocol=${title}":
    profile => $profile,
    content => $properties,
  }
  -> wildfly::resource { '/subsystem=jgroups':
    profile => $profile,
    content => {
      'default-stack' => $stack,
    },
  }
}
