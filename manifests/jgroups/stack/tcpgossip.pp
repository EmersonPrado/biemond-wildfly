#
# Configures a tcpgossip stack.
#
# @param initial_hosts Comma delimited list of hosts to be contacted for initial membership.
# @param num_initial_members Number of initial members.
# @param timeout Max time for socket creation. Default is 3000 msec.
#
define wildfly::jgroups::stack::tcpgossip (
  String  $initial_hosts,
  Integer $num_initial_members,
  Integer $timeout = 3000,
  Optional[String] $profile = undef,
) {
  $properties = {
    'properties' => {
      'initial_hosts'       => $initial_hosts,
      'timeout'             => $timeout,
      'num_initial_members' => $num_initial_members,
    },
  }

  wildfly::jgroups::stack::tcp { 'TCPGOSSIP':
    profile    => $profile,
    properties => $properties,
  }
}
