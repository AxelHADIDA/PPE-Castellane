<?php
	ob_start();
	session_start();
	if( isset($_SESSION['user'])!="" ){
		header("Location: home.php");
	}
	include_once 'dbconnect.php';
	$error = false;
	if ( isset($_POST['btn-signup']) ) {
		// clean user inputs to prevent sql injections
		$name = trim($_POST['name']);
		$name = strip_tags($name);
		$name = htmlspecialchars($name);

		$email = trim($_POST['email']);
		$email = strip_tags($email);
		$email = htmlspecialchars($email);

		$pass = trim($_POST['pass']);
		$pass = strip_tags($pass);
		$pass = htmlspecialchars($pass);

		$datenaiss = trim($_POST['datenaiss']);
		$datenaiss = strip_tags($datenaiss);
		$datenaiss = htmlspecialchars($datenaiss);

		$adress = trim($_POST['adress']);
		$adress = strip_tags($adress);
		$adress = htmlspecialchars($adress);

		$ville = trim($_POST['ville']);
		$ville = strip_tags($ville);
		$ville = htmlspecialchars($ville);

		$codecp = trim($_POST['codecp']);
		$codecp = strip_tags($codecp);
		$codecp = htmlspecialchars($codecp);

		$tel = trim($_POST['tel']);
		$tel = strip_tags($tel);
		$tel = htmlspecialchars($tel);

		// basic name validation
		if (empty($name)) {
			$error = true;
			$nameError = "Entrez un nom complet.";
		} else if (strlen($name) < 3) {
			$error = true;
			$nameError = "Le nom doit contenir au moins 3 lettres.";
		} else if (!preg_match("/[a-zA-Z]/",$name)) {
			$error = true;
			$nameError = "Le nom doit contenir des lettres et des espaces.";
		}
		//basic email validation
		if ( !filter_var($email,FILTER_VALIDATE_EMAIL) ) {
			$error = true;
			$emailError = "Entrez une adresse email valide.";
		} else {
			// check email exist or not
			$query = "SELECT userEmail FROM users WHERE userEmail='$email'";
			$result = mysql_query($query);
			$count = mysql_num_rows($result);
			if($count!=0){
				$error = true;
				$emailError = "Cet email est déjà utilisé.";
			}
		}
		// password validation
		if (empty($pass)){
			$error = true;
			$passError = "Entrez un mot de passe.";
		} else if(strlen($pass) < 6) {
			$error = true;
			$passError = "Le mot de passe doit contenir au moins 6 lettres.";
		}
		if(empty($adress)){
			$error = true;
			$adresserror = "Veuillez insérer une adresse valide";
		} else if(strlen($adress) < 3){
			$error = true;
			$adresserror = "L'adresse doit contenir au moins 3 lettres";
		}
		if(empty($ville)){
			$error = true;
			$villeerror = "Veuillez insérer une Ville valide";
		} else if(strlen($ville) < 3){
			$error = true;
			$codecperror = "La Ville doit contenir au moins 3 lettres";
		}
		if(empty($codecp)){
			$error = true;
			$codecperror = "Veuillez insérer une Code Postal valide";
		} else if(strlen($codecp) < 3){
			$error = true;
			$codecperror = "Le code postal doit contenir au moins 3 lettres";
		}
		if(empty($tel)){
			$error = true;
			$telerror = "Veuillez insérer un numéro valide";
		} else if(strlen($tel) < 3){
			$error = true;
			$telerror = "Le numéro doit contenir 10 chiffres";
		}
		// password encrypt using SHA256();
		$password = hash('sha256', $pass);
		// if there's no error, continue to signup
		if( !$error ) {
			$query = "INSERT INTO users(userName,userEmail,userPass,datenaiss,adress,ville,codecp,tel) VALUES('$name','$email','$password','$datenaiss','$adress','$ville','$codecp','$tel')";
			$res = mysql_query($query);
			if ($res) {
				$errTyp = "success";
				$errMSG = "Inscrit avec succès, connectez vous ci dessous.";
				unset($name);
				unset($email);
				unset($pass);
				unset($datenaiss);
				unset($adress);
				unset($ville);
				unset($codecp);
				unset($tel);
			} else {
				$errTyp = "danger";
				$errMSG = "Une erreur s'est produite, réesayez plus tard.";
			}
		}
	}
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Mon profil.</title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css" type="text/css"  />
<link rel="stylesheet" href="style.css" type="text/css" />
</head>
<body>
<div class="container">
	<div id="login-form">
    <form method="post" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" autocomplete="off">
    	<div class="col-md-12">
        	<div class="form-group">
            	<h2 class="">Rejoignez-nous</h2>
            </div>
        	<div class="form-group">
            	<hr />
            </div>
            <?php
			if ( isset($errMSG) ) {
				?>
				<div class="form-group">
            	<div class="alert alert-<?php echo ($errTyp=="success") ? "success" : $errTyp; ?>">
				<span class="glyphicon glyphicon-info-sign"></span> <?php echo $errMSG; ?>
                </div>
            	</div>
                <?php
			}
			?>
            <div class="form-group">
            	<div class="input-group">
                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
            	<input type="text" name="name" class="form-control" placeholder="Entrez votre Nom et Prénom" maxlength="50" value="<?php echo $name ?>" />
                </div>
                <span class="text-danger"><?php echo $nameError; ?></span>
            </div>
            <div class="form-group">
            	<div class="input-group">
                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
            	<input type="email" name="email" class="form-control" placeholder="Entrez votre Email" maxlength="40" value="<?php echo $email ?>" />
                </div>
                <span class="text-danger"><?php echo $emailError; ?></span>
            </div>
            <div class="form-group">
            	<div class="input-group">
                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
            	<input type="password" name="pass" class="form-control" placeholder="Entrez votre mot de passe" maxlength="15" />
                </div>
                <span class="text-danger"><?php echo $passError; ?></span>
            </div>
            <div class="form-group">
            	<div class="input-group">
                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
            	<input type="date" name="datenaiss" class="form-control" placeholder="Entrez votre Date de naissance" maxlength="50" value="<?php echo $datenaiss ?>" />
                </div>
                <span class="text-danger"><?php echo $datenaisserror; ?></span>
            </div>
            <div class="form-group">
            	<div class="input-group">
                <span class="input-group-addon"><span class="glyphicon glyphicon-bed"></span></span>
            	<input type="text" name="adress" class="form-control" placeholder="Entrez votre Adresse" maxlength="50" value="<?php echo $adress ?>" />
                </div>
                <span class="text-danger"><?php echo $adresserror; ?></span>
            </div>
            <div class="form-group">
            	<div class="input-group">
                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
            	<input type="text" name="ville" class="form-control" placeholder="Entrez votre Ville" maxlength="30" value="<?php echo $ville ?>" />
                </div>
                <span class="text-danger"><?php echo $villeerror; ?></span>
            </div>
            <div class="form-group">
            	<div class="input-group">
                <span class="input-group-addon"><span class="glyphicon glyphicon-level-up"></span></span>
            	<input type="text" name="codecp" class="form-control" placeholder="Entrez votre Code Postal" maxlength="5" value="<?php echo $codecp ?>" />
                </div>
                <span class="text-danger"><?php echo $codecperror; ?></span>
            </div>
            <div class="form-group">
            	<div class="input-group">
                <span class="input-group-addon"><span class="glyphicon glyphicon-phone"></span></span>
            	<input type="text" name="tel" class="form-control" placeholder="Entrez votre téléphone" maxlength="10" value="<?php echo $tel ?>" />
                </div>
                <span class="text-danger"><?php echo $telerror; ?></span>
            </div>
            <div class="form-group">
            	<hr />
            </div>
            <div class="form-group">
           	  <button id="btn-logreg" type="submit" class="btn btn-block" name="btn-signup">Je m'inscris</button>
            </div>
            <div class="form-group">
            	<hr />
            </div>
            <div class="form-group">
            	<a href="index.php" class="liens">Se connecter, ici.</a>
            	<br><br>
            	<a href="../index.html" class="liens">Retour à l'accueil.</a>
            </div>
        </div>
    </form>
    </div>
</div>
</body>
</html>
<?php ob_end_flush(); ?>
