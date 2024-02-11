<?php
//define("MB", 1048576);
function filterRequest($requestname){
return htmlspecialchars(strip_tags($_POST[$requestname]));

}
function getAllData($table, $where = null, $values = null)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT  * FROM $table WHERE   $where ");
    $stmt->execute($values);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($count > 0){
        echo json_encode(array("status" => "success", "data" => $data));
    } else {
        echo json_encode(array("status" => "failure"));
    }
    return $count;
}

function insertData($table, $data, $json = true)
{
    global $con;
    foreach ($data as $field => $v)
        $ins[] = ':' . $field;
    $ins = implode(',', $ins);
    $fields = implode(',', array_keys($data));
    $sql = "INSERT INTO $table ($fields) VALUES ($ins)";

    $stmt = $con->prepare($sql);
    foreach ($data as $f => $v) {
        $stmt->bindValue(':' . $f, $v);
    }
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json == true) {
    if ($count > 0) {
        echo json_encode(array("status" => "success"));
    } else {
        echo json_encode(array("status" => "failure"));
    }
  }
    return $count;
}


function updateData($table, $data, $where, $json = true)
{

    global $con;
    $cols = array();
    $vals = array();
    foreach ($data as $key => $val) {
        $vals[] = "$val";
        $cols[] = "`$key` =  ? ";
    }
    $sql = "UPDATE $table SET " . implode(', ', $cols) . " WHERE $where";
    $stmt = $con->prepare($sql);
    $stmt->execute($vals);
    $count = $stmt->rowCount();
    if ($json == true) {
    if ($count > 0) {
        echo json_encode(array("status" => "success"));
    } else {
        echo json_encode(array("status" => "failure"));
    }
    }
    return $count;
}

function deleteData($table, $where, $json = true)
{
    global $con;
    $stmt = $con->prepare("DELETE FROM $table WHERE $where");
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}
/*
function imageUpload($imageRequest)
{
  global $msgError;
  $imagename  = rand(1000, 10000) . $_FILES[$imageRequest]['name'];
  $imagetmp   = $_FILES[$imageRequest]['tmp_name'];
  $imagesize  = $_FILES[$imageRequest]['size'];
  $allowExt   = array("jpg", "png", "gif", "mp3", "pdf");
  $strToArray = explode(".", $imagename);
  $ext        = end($strToArray);
  $ext        = strtolower($ext);

  if (!empty($imagename) && !in_array($ext, $allowExt)) {
    $msgError = "EXT";
  }
  if ($imagesize > 2 * MB) {
    $msgError = "size";
  }
  if (empty($msgError)) {
    move_uploaded_file($imagetmp,  "../upload/" . $imagename);
    return $imagename;
  } else {
    return "fail";
  }
}
*/


function deleteFile($dir, $imagename)
{
    if (file_exists($dir . "/" . $imagename)) {
        unlink($dir . "/" . $imagename);
    }
}



function checkAuthenticate()
{
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
        if ($_SERVER['PHP_AUTH_USER'] != "wael" ||  $_SERVER['PHP_AUTH_PW'] != "wael12345") {
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }

 } // End 
 
 function sendEmail($to,$title,$body)
 {  
   // $headers = 'From: tharashehadeh@gmail.com' . "\r\n" . 
               //'MIME-Version: 1.0' . "\r\n" .
               //'Content-Type: text/html; charset=utf-8';

    //$to = "tharashehadeh@gmail.com";
    //$subject = "Reset your password on examplesite.com";
    //$msg = "Hi there, click on this <a href=\"new_password.php?token=" . "\">link</a> to reset your password on our site";
    //$msg = wordwrap($msg,70);
    //$headers = "From: info@examplesite.com";
    /*$to = 'localhost.tharashehadeh@gmail.com';
    $subject = 'LOCALHOST SUBJECT';
    $message = 'send from localhost';
    $headers = 'from :tharashehadeh@gmail.com'.
    'MIME-Version: 1.0' . "\r\n" .
    'Content-Type: text/html; charset=utf-8';
   if(mail($to,$subject ,$message,$headers))
   echo "email sent";
   else 
   echo "email sending failed";*/
   // var_dump($result);
    //mail($to, $subject, $msg, $headers);
    /*
    $header = "From: tharashehadeh@gmail.com" ."\n"."CC:tharashehadeh@gmail.com";
    if(mail($to,$title,$body,$header))
    echo "sucess";
    else 
    echo "fail";*/
   
    $header = "From: masahalawa18@.com" ."\n"."CC:masahalawa18@gmail.com";
    mail($to, $title, $body, $header);
  
     
 }