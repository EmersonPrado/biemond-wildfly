#
# Configures jgroups stacks
#
# @param protocols List of protocols to use
# @param transport Transport config hash.
#
define wildfly::jgroups::stack (
  Array[Variant[Hash, String]] $protocols,
  Hash                         $transport,
  Optional[String]             $profile = undef,
) {
  wildfly::resource { "/subsystem=jgroups/stack=${title}":
    profile   => $profile,
    recursive => true,
    content   => {
      'protocol'  => wildfly::objectify($protocols),
      'transport' => $transport,
    },
  }
}
