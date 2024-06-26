  #!/bin/bash
    
    # Copyright 2017 Pete Birley
    #
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    # http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.
    
    set -ex
    
    # Manage domain
    SERVICE_OS_DOMAIN_ID=$(openstack domain create --or-show --enable -f value -c id \
        --description="Service Domain for RegionOne/heat" \
        "heat")
    
    # Display domain
    openstack domain show "${SERVICE_OS_DOMAIN_ID}"
    
    # Manage user
    SERVICE_OS_USERID=$(openstack user create --or-show --enable -f value -c id \
        --domain="${SERVICE_OS_DOMAIN_ID}" \
        --description "Service User for RegionOne/heat" \
        --password=password \
        "heat-domain")
    
    # Manage user password (we do this to ensure the password is updated if required)
    openstack user set --password=password "${SERVICE_OS_USERID}"
    
    # Display user
    openstack user show "${SERVICE_OS_USERID}"
    
    # Manage role
    SERVICE_OS_ROLE_ID=$(openstack role show -f value -c id \
        "admin" || openstack role create -f value -c id \
        "admin" )
    
    # Manage user role assignment
    openstack role add \
              --domain="${SERVICE_OS_DOMAIN_ID}" \
              --user="${SERVICE_OS_USERID}" \
              --user-domain="${SERVICE_OS_DOMAIN_ID}" \
              "admin"
    
    # Display user role assignment
    openstack role assignment list \
              --role="${SERVICE_OS_ROLE_ID}" \
              --user-domain="${SERVICE_OS_DOMAIN_ID}" \
              --user="${SERVICE_OS_USERID}"