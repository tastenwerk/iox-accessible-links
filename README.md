= iox-accessible-links

base for documents that need to be shared to a list of group, an open list of users or just anybody by providing a link.

== Usage

  class MyContainer
    has_accessible_links
  end

This gives you the following links

  my_container.access = Iox::AccessibleLinks::Rules::PUBLIC_SINGLE_LINK_NO_REGISTRATION

provides one single link ( like /iox/cloud_containers/kIWtoAsdF ) to be shared with any body. No further validation

  my_container.access = Iox::AccessibleLinks::Rules::PUBLIC_UNIQUE_LINKS_NO_REGISTRATION

admin can create email addresses which will be provided with a unique access link (for the same resource). That provides opportunity to track users, how often they are accessing a resource and denying access after a specific amount of logins

  my_container.access = Iox::AccessibleLinks::Rules::PUBLIC_UNIQUE_LINKS_OPEN_REGISTRATION

Same as above but users can register with their email addres, will be provided with a confirmation email and can manage this tiny account on their own (e.g. delete access again). In this case, it is also possible to tell the newly created email account to expire on a specific date after creation

  my_container.access = Iox::AccessibleLinks::Rules::GRANT_LOCAL_USERS

This does not create a public link. Only logged in users will be able to access contents.

  my_container.access = Iox::AccessibleLinks::Rules::DENY_ALL
  my_container.access = Iox::AccessibleLinks::Rules::PRIVATE (alias to above)

This does not allow any user to access the content apart from the owner.




