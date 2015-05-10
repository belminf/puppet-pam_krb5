#puppet-pam_krb5

Configuring kerberos configuration. Based off the modifications `authconfig-tui` sets.

Requirements
---
- augeasproviders_pam (`puppet module install herculesteam/augeasproviders_pam`)
- puppetlabs-stdlib (`puppet module install puppetlabs-stdlib`)
- [Augeas requirements](http://docs.puppetlabs.com/guides/augeas.html#pre-requisites)
- Puppet 3.6 or later

Tested
---
- RHEL7
- RHEL6
