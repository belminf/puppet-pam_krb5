class pam_krb5 ($realm) {

    package { 'pam_krb5':
        ensure        => latest,
        allow_virtual => false,
    }

    file { '/etc/krb5.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('pam_krb5/krb5.conf.erb'),
        require => Package['pam_krb5'],
    }


    # Configure pam.d services
    Pam_krb5::Service_config {
        require =>  [
            Package['pam_krb5'],
            File['/etc/krb5.conf'],
        ],
    }
    pam_krb5::service_config { 'system-auth': }
    pam_krb5::service_config { 'password-auth': }

}
