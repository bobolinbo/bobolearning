/**
 * 判断当前环境
 * @return boolean [description]
 */
function get_runtime_environment($to_verify_environment){

    // 是否在微信浏览器下
    if($to_verify_environment === 'MicroMessenger'){

        // 是否在微信环境下

        if( strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false && strpos($_SERVER['HTTP_USER_AGENT'], 'wxwork') === false){
            return true;
        }else {
            return false;
        }

    }
    // 是否在企业微信环境下
    else if($to_verify_environment === 'wxwork'){

        if( strpos($_SERVER['HTTP_USER_AGENT'], 'wxwork') !== false ){
            return true;
        } else {
            return false;
        }

    }

    return false;

}
