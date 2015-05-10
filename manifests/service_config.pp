define pam_krb5::service_config ($service=$title) {

    Pam {
        ensure => present,
    }

    pam { "${service} auth pam_krb5":
        service  => $service,
        type     => 'auth',
        control  => 'include',
        module   => 'krb5',
        position => 'before module pam_deny.so',
    }

    pam { "${service} account pam_unix":
        service   => $service,
        type      => 'account',
        control   => 'required',
        module    => 'pam_unix.so',
        arguments => 'broken_shadow',
        position  => 'before first',
    }

    pam { "${service} account pam_krb5":
        service          => $service,
        type             => 'account',
        control          => '[default=bad success=ok user_unknown=ignore]',
        control_is_param => true,
        module           => 'pam_krb5.so',
        position         => 'before module pam_permit.so',
    }

    pam { "${service} password pam_unix":
        service   => $service,
        type      => 'password',
        control   => 'sufficient',
        module    => 'pam_unix.so',
        arguments => [
            'md5',
            'shadow',
            'nullok',
            'try_first_pass',
            'use_authtok',
        ],
        position  => 'before module pam_deny.so',
    }

    pam { "${service} password pam_krb5":
        service  => $service,
        type     => 'password',
        control  => 'include',
        module   => 'krb5',
        position => 'before module pam_deny.so',
    }

    pam { "${service} session pam_krb5":
        service  => $service,
        type     => 'session',
        control  => 'include',
        module   => 'krb5',
        position => 'after last',
    }
}

