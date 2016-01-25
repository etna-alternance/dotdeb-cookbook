default['dotdeb_repo']['priority'] = 700
default['php_version'] = "5.6"
default['dotdeb_repo']['repositories'] = {
    'jessie' => {
        '7.0' => ['dotdeb'],
        '5.6' => []
    },
    'wheezy' => {
        '5.6' => ['dotdeb', 'dotdeb-php56'],
        '5.5' => ['dotdeb', 'dotdeb-php55']
    },
    'squeeze' => {
        '5.4' => ['dotdeb', 'dotdeb-php54']
    }
}
