<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml;charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Cache-Control" content="No-Cache" />
	<meta http-equiv="Pragma" content="No-Cache" />
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<title>Upload</title>
<?
	$MAXLIMIT = 5242880; // 5MByte limit
	if($_FILES['upload']['size'] > $MAXLIMIT) {
		$msg = "Limited size ".($MAXLIMIT/1024/1024)."MByte";
		echo "<script>alert('".$msg."');</script>";
	}
	else {
		$file = $_FILES['upload'];
		$name = preg_replace("/\.(php|phtm|htm|cgi|pl|exe|jsp|asp|inc)/i", "$0-x", $file['name']);
		$name = substr(md5(uniqid($_SERVER['REQUEST_TIME'])),0,8).'_'.str_replace('%', '', urlencode($name));
	
		$ATTACH_DIR = "./attach/mail/";
		$ATTACH_URL = "/attach/mail/";
		$dest_file  = $ATTACH_DIR.$name;
		$url = "http://".$_SERVER['HTTP_HOST'].$ATTACH_URL.$name;
	
		if(!is_dir($ATTACH_DIR)) {
			if(@mkdir($ATTACH_DIR, 0777, true)) {
				if(is_dir($ATTACH_DIR)) {
					@chmod($ATTACH_DIR, 0777);
				}
			}
		}
		 
		if(move_uploaded_file($file['tmp_name'], $dest_file)) {
		 echo "<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction('".$_GET['CKEditorFuncNum']."', '".$url."', 'success')</script>";
		}
		else {
		 echo "<script>alert('failed')</script>";
		}
	}
?>
</head>
<body>
</body>
</html>
