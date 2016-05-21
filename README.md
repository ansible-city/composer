# PHP Composer

Master: [![Build Status](https://travis-ci.org/ansible-city/composer.svg?branch=master)](https://travis-ci.org/ansible-city/composer)  
Develop: [![Build Status](https://travis-ci.org/ansible-city/composer.svg?branch=develop)](https://travis-ci.org/ansible-city/composer)

This role installs and configures [PHP Composer](https://getcomposer.org/).




## ansible.cfg

This role is designed to work with merge "hash_behaviour". Make sure your
ansible.cfg contains these settings

```INI
[defaults]
hash_behaviour = merge
```




## Installation and Dependencies

This role has no dependencies, but you need PHP cli to be available.




## Tags

This role uses two tags: **build** and **configure**

* `build` - Installs composer.
* `configure` - Configures composer.




## Examples

Simply install composer.

```YAML
- name: Install PHP Composer
  hosts: sandbox

  roles:
    - role: ansible-city.composer
      composer:
        user: my_application
        install_dir: /home/my_application/bin
```

Install composer and configure github access

```YAML
- name: Install and Configure PHP Composer
  hosts: sandbox

  roles:
    - role: ansible-city.composer
      composer:
        user: my_application
        install_dir: /home/my_application/bin
        auth:
          github:
            github.com: qwerty654321
          http:
            repo.example.org:
              username: username
              password: secretP4ssword
```
