class LDAP

    ## Connect to SenderosUN LDAP ##
    def self.connect
        ldap = Net::LDAP.new()

        ldap.host = "34.94.104.0" # Host
        ldap.port = 389 # Port
        ldap.auth "cn=admin,dc=senderosun,dc=unal,dc=edu,dc=co", "admin" # dn + password

        if(ldap.bind) # If authenticate to LDAP...
            puts "Authenticated in LDAP Server..."

            return true
        else
            puts "ERROR when connecting to LDAP Server..."

            return false
        end
    end

    def self.validateUser(email, password)
        ldap = Net::LDAP.new()

        ldap.host = "34.94.104.0" # Host
        ldap.port = 389 # Port
        ldap.auth "cn=" + email + ",ou=senderosun,dc=senderosun,dc=unal,dc=edu,dc=co", password # user + password

        if(ldap.bind) # If the user is authenticated...
            return true
        else
            return false
        end
    end

    def self.login(email, password)
        if(connect)
            if(validateUser(email, password))
                return true;
            else
                return false;
            end
        else
            return false;
        end
    end
end