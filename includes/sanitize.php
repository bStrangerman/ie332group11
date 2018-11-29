<?php
function clean($str) {
    $str = @trim($str);
    if(get_magic_quotes_gpc()) {
        $str = stripslashes($str);
    }
    return htmlspecialchars(mysqli_real_escape_string($GLOBALS['conn'],$str));
}
?>
