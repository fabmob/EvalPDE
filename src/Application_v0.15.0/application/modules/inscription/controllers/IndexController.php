<?php
/**
 * Contrôleur de l'inscription
 * @author dangebault
 */
class Inscription_IndexController extends Ademe_Controller_CuController
{
    /**
     * Action de sélection du profil pour l'inscription
     *
     * @Ademe_Annotation_Cu("201-01")
     * @Ademe_Annotation_WindowTitle("Inscription - étape 2/3")
     * @Ademe_Annotation_PageTitle("Inscription")
     */
    public function profilAction()
    {
        //on récupère l'adresse mail et champs rgpd pour la passer à la prochaine action d'inscription
        //L'email est déjà encodé via urlencode()
        $email = $this->_getParam('email');
        $consentement = $this->_getParam('consentement');
        $dateRGPD = $this->_getParam('date_rgpd');

        //on créé le formulaire de sélection du profil pour l'inscription
        $form = new Ademe_Form_Modules_Inscription_SelectProfil();
        $request = $this->getRequest();
        if ($request->isPost()) {
            if ($form->isValid($request->getPost())) {
                $data = $request->getPost();
                $codeProfil = $data['profil'];
                // on redirige l'utilisateur vers l'action d'inscription correspondant à son profil
                $params = array('email' => $email, 'consentement' => $consentement, 'date_rgpd' => $dateRGPD);
                switch ($codeProfil) {
                    case 'PROFIL_REFERENT':
                        $this->getRedirector()->gotoSimple('referent', 'index', 'inscription', $params);
                        break;
                    case 'PROFIL_ANIMATEUR':
                        $this->getRedirector()->gotoSimple('animateur', 'index', 'inscription', $params);
                        break;
                }
            }
        }
        $this->view->form = $form;
    }

    /**
     * Action pour la RGPD
     *
     * @Ademe_Annotation_Cu("201-00")
     * @Ademe_Annotation_WindowTitle("Inscription - étape 1/3")
     * @Ademe_Annotation_PageTitle("Inscription")
     */
    public function indexAction()
    {
        $email = $this->_getParam('email');
        //on créé le formulaire de RGPD pour l'inscription
        $form = new Ademe_Form_Modules_Inscription_RGPD();

        $request = $this->getRequest();
        if ($request->isPost()) {
            if ($form->isValid($request->getPost())) {
                $data = $request->getPost();
                $rgpd = isset($data['rgpd']) ? 1 : 0;
                $dateRGPD = date("Y-m-d H:m:s", time());
                $params = array('email' => $email, 'consentement' => $rgpd, 'date_rgpd' => $dateRGPD);
                $this->getRedirector()->gotoSimple('profil', 'index', 'inscription', $params);
            }
        }
        $this->view->form = $form;
    }


    /**
     * Action d'inscription d'un référent
     *
     * @Ademe_Annotation_Cu("201-02")
     * @Ademe_Annotation_WindowTitle("Inscription - étape 3/3")
     * @Ademe_Annotation_PageTitle("Inscription")
     */
    public function referentAction()
    {
        $email = urldecode($this->_getParam('email'));

        $form = new Ademe_Form_Modules_Inscription_Referent($email, array('id' => 'form-inscriptionreferent'));

        $request = $this->getRequest();
        if ($request->isPost()) {
            if ($form->isValid($request->getPost())) {
                $data = $request->getPost();
                // on récupère les données de l'utilisateur
                $nom = $request->getParam('nom');
                $prenom = $request->getParam('prenom');
                $telephone = $data['telephone'];
                $mail = $request->getParam('mail');
                $fonction = $request->getParam('fonction');
                $consentement = $request->getParam('consentement');
                $dateRGPD = $request->getParam('date_rgpd');
                $user = new Ademe_Model_User();
                $user->setNom($nom);
                $user->setPrenom($prenom);
                $user->setTelephone($telephone);
                $user->setEmail($mail);
                $user->setFonction($fonction);
                $user->setEnabled(false);
                $user->setConsentement($consentement);
                $user->setDateRgpd($dateRGPD);

                // on récupère l'id du profil référent dans la base
                $profilReferentId = Ademe_Model_AuthProfilTable::PROFIL_REFERENT;
                // on effectue la liaison entre le profil et le user
                $userProfil = new Ademe_Model_UserAuthProfil();
                $userProfil->setUser($user);
                $userProfil->setAuthProfilId($profilReferentId);

                // on récupère les données de l'établissement et de la structure
                $nomDemarche = $request->getParam('nom_demarche');
                $raisonSociale = $request->getParam('nom_etablissement');
                $adresseNo = $request->getParam('adresse_no');
                $adresseVoie = $request->getParam('adresse_voie');
                $codePostal = $request->getParam('code_postal');
                $geoVilleId = $request->getParam('commune');
                $siret = $request->getParam('siret');
                $effectif = $request->getParam('effectif');
                $dateEntree = $request->getParam('date_entree');
                $codeNaf = $request->getParam('activite');
                $structureJuridiqueId = $request->getParam('structure_juridique');

                // on convertit la date 'dd/mm/yyyy' en date mysql 'yyyy/mm/dd'
                $tmp = explode("/", $dateEntree);
                $dateIso = $tmp[2]."-".$tmp[1]."-".$tmp[0];

                // on instancie l'établissement
                $etablissement = new Ademe_Model_Etablissement();
                $etablissement->setRaisonSociale($raisonSociale);
                $etablissement->setAdresseNo($adresseNo);
                $etablissement->setAdresseVoie($adresseVoie);
                $etablissement->setCodePostal($codePostal);
                $etablissement->setGeoVilleId($geoVilleId);
                $etablissement->setSiret($siret);
                $etablissement->setEffectif($effectif);
                $etablissement->setDateEntree($dateIso);
                $etablissement->setNomDemarche($nomDemarche);
                // on récupère la sous classe naf correspondant au code naf
                $naf = Ademe_Model_NafSousClasseTable::getNafSousClasse($codeNaf);
                $etablissement->setNafSousClasse($naf);
                $etablissement->setStructureJuridiqueId($structureJuridiqueId);
                $etablissement->setUser($user);
                $etablissement->setEnabled(false);

                // on instancie la structureEntreprise
                $structureEntreprise = new Ademe_Model_StructureEntreprise();
                $siren = substr($siret, 0, 9);
                $structureEntreprise->setNomDemarche($nomDemarche);
                $structureEntreprise->setRaisonSociale($raisonSociale);
                $structureEntreprise->setAdresseNo($adresseNo);
                $structureEntreprise->setAdresseVoie($adresseVoie);
                $structureEntreprise->setCodePostal($codePostal);
                $structureEntreprise->setGeoVilleId($geoVilleId);
                $structureEntreprise->setSiren($siren);
                $structureEntreprise->setEffectif($effectif);
                $structureEntreprise->setNafSousClasse($naf);
                $structureEntreprise->setDateEntree($dateIso);
                $structureEntreprise->setTypeDemarcheId(Ademe_Model_TypeDemarche::PDE);
                $structureEntreprise->setUser($user);
                $structureEntreprise->setEnabled(false);

                // on associe l'établissement à la structure
                $etablissementStructure = new Ademe_Model_EtablissementStructure();
                $etablissementStructure->setEtablissement($etablissement);
                $etablissementStructure->setStructure($structureEntreprise);
                $etablissementStructure->setStatutDemandeId(Ademe_Model_StatutDemandeTable::EN_ATTENTE_VALID_ADMIN);

                $conn = Doctrine_Manager::connection();
                try {
                    $conn->beginTransaction();
                    $user->save($conn);
                    $userProfil->save($conn);
                    $etablissement->save($conn);
                    $structureEntreprise->save($conn);
                    $etablissementStructure->save($conn);
                    // On crée les user_textes pour l'assistant.
                    $user->createUserTextesAssistant($conn);

                    $conn->commit();
                    // on redirige vers le CU201-04
                    $params = array('email' => $mail, 'prenom' => $prenom, 'nom' => $nom, 'raison_sociale' => $raisonSociale);
                    $this->getRedirector()->gotoSimple('mail', 'index', 'inscription', $params);
                } catch (Exception $e) {
                    $conn->rollback();
                }

            } else {
                $form->populate($request->getPost());
            }
        }

        $this->view->form = $form;
    }

    /**
     * Action d'inscription d'un animateur
     *
     * @Ademe_Annotation_Cu("201-03")
     * @Ademe_Annotation_WindowTitle("Inscription")
     * @Ademe_Annotation_PageTitle("Inscription")
     */
    public function animateurAction()
    {
        $email = urldecode($this->_getParam('email'));

        $form = new Ademe_Form_Modules_Inscription_Animateur($email, array('id' => 'form-inscriptionanimateur'));

        $request = $this->getRequest();
        if ($request->isPost()) {
            if ($form->isValid($request->getPost())) {
                // on récupère les données de l'utilisateur
                $nom = $request->getParam('nom');
                $prenom = $request->getParam('prenom');
                $telephone = $request->getParam('telephone');
                $fonction = $request->getParam('fonction');
                $mail = $request->getParam('mail');
                $consentement = $request->getParam('consentement');
                $dateRGPD = $request->getParam('date_rgpd');

                $user = new Ademe_Model_User();
                $user->setNom($nom);
                $user->setPrenom($prenom);
                $user->setTelephone($telephone);
                $user->setEmail($mail);
                $user->setFonction($fonction);
                $user->setEnabled(false);
                $user->setConsentement($consentement);
                $user->setDateRgpd($dateRGPD);

                // on récupère l'id du profil animateur dans la base
                $profilAnimateurId = Ademe_Model_AuthProfilTable::PROFIL_ANIMATEUR;
                // on effectue la liaison entre le profil et le user
                $userProfil = new Ademe_Model_UserAuthProfil();
                $userProfil->setUser($user);
                $userProfil->setAuthProfilId($profilAnimateurId);

                // on récupère les données de la structure
                $nomStructure = $request->getParam('nom_structure');
                $raisonSociale = $request->getParam('raison_sociale');
                $adresseNo = $request->getParam('adresse_no');
                $adresseVoie = $request->getParam('adresse_voie');
                $codePostal = $request->getParam('code_postal');
                $geoVilleId = $request->getParam('commune');
                // on instancie la structure animation
                $structureAnimation = new Ademe_Model_StructureAnimation();
                $structureAnimation->setNom($nomStructure);
                $structureAnimation->setRaisonSociale($raisonSociale);
                $structureAnimation->setAdresseNo($adresseNo);
                $structureAnimation->setAdresseVoie($adresseVoie);
                $structureAnimation->setCodePostal($codePostal);
                $structureAnimation->setGeoVilleId($geoVilleId);
                $structureAnimation->setUser($user);
                $structureAnimation->setTypeDemarcheId(Ademe_Model_TypeDemarche::PDE);
                $structureAnimation->setEnabled(false);

                // on récupère les données de la zone d'intervention
                $nomZone = $request->getParam('nom_zone');
                // on instancie la zone d'intervention
                $zoneIntervention = new Ademe_Model_ZoneIntervention();
                $zoneIntervention->setNom($nomZone);
                $zoneIntervention->setStructure($structureAnimation);

                // on récupère les territoires
                $contenuZone = $request->getParam('contenu_zone');
                $territoires = array();
                foreach ($contenuZone as $zone) {
                    //on découpe la chaine afin d'avoir les 3 id séparés
                    $zone = explode("/", $zone);
                    $idRegion = $zone[0];
                    $idDepartement = $zone[1];
                    $idVille = $zone[2];
                    $territoire = new Ademe_Model_Territoire();
                    $territoire->setZoneIntervention($zoneIntervention);
                    $territoire->setGeoRegionId($idRegion);
                    if ($idDepartement != '0') {
                        $territoire->setGeoDepartementId($idDepartement);
                    }
                    if ($idVille != '0') {
                        // on récupère la ville en base pour avoir le code ville
                        $ville = Ademe_Model_GeoVilleTable::get($idVille);
                        $territoire->setCodeVille($ville->getCode());
                    }
                    $territoire->setStatutDemandeId(Ademe_Model_StatutDemandeTable::EN_ATTENTE_VALID_ADMIN);
                    $territoires[] = $territoire;
                }

                // on récupère les établissements
                $etablissementsZone = $request->getParam('etablissements_zone');
                $etablissementsStructure = array();
                if (is_array($etablissementsZone)) {
                    foreach ($etablissementsZone as $e) {
                        $etablissementStructure = new Ademe_Model_EtablissementStructure();
                        $etablissementStructure->setEtablissementId($e);
                        $etablissementStructure->setStructure($structureAnimation);
                        $etablissementStructure->setStatutDemandeId(Ademe_Model_StatutDemandeTable::EN_ATTENTE_VALID_ADMIN);
                        $etablissementsStructure[] = $etablissementStructure;
                    }
                }

                $conn = Doctrine_Manager::connection();
                try {
                    $conn->beginTransaction();
                    $user->save($conn);
                    $userProfil->save($conn);
                    $structureAnimation->save($conn);
                    $zoneIntervention->save($conn);
                    foreach ($territoires as $t) {
                        $t->save($conn);
                    }
                    foreach ($etablissementsStructure as $e) {
                        $e->save($conn);
                    }
                    $conn->commit();
                    // on redirige vers le CU201-04
                    $params = array('email' => $mail, 'prenom' => $prenom, 'nom' => $nom, 'raison_sociale' => $raisonSociale);
                    $this->getRedirector()->gotoSimple('mail', 'index', 'inscription', $params);
                } catch (Exception $e) {
                    $conn->rollback();
                }
            } else {
                $form->populate($request->getPost());
            }
        }
        $this->view->form = $form;
    }

    /**
     * Action d'envoi d'inscription (mail)
     *
     * @Ademe_Annotation_Cu("201-04")
     * @Ademe_Annotation_WindowTitle("Inscription")
     * @Ademe_Annotation_PageTitle("Inscription")
     *
     */
    public function mailAction()
    {
        $email = $this->_getParam('email');

        // on récupère l'ensemble des administrateurs
        $usersProfilAdmin = Ademe_Model_UserAuthProfilTable::getUsersProfil(Ademe_Model_AuthProfilTable::PROFIL_ADMINISTRATEUR);

        //on récupère les données du mail
        $nom = $this->_getParam('nom');
        $prenom = $this->_getParam('prenom');
        $raisonSociale = $this->_getParam('raison_sociale');

        $serverUrl = new Zend_View_Helper_ServerUrl();

        $url = $serverUrl->serverUrl() . $this->_helper->url('token', 'index');

        // on calcule la date d'expiration du token (+60jours)
        $dateFin = date('Y-m-d', strtotime('+60 days'));

        // Envoi du mail pour chaque admin
        foreach ($usersProfilAdmin as $u) {
            $mail = new Ademe_Mail_Inscription($u->getUser());
            $options = array(
                    'nom'         => $nom,
                    'prenom'      => $prenom,
                    'raison_sociale'  => $raisonSociale,
                    'url'    => $url
            ) ;
            $mail->setOptions($options);
            //on récupère l'utilisateur par son email afin de rediriger le lien du mail en fonction de son profil
            $user = Ademe_Model_UserTable::getByEmail($email);
            if ($user instanceof Ademe_Model_User) {
                if ($user->getHighestProfil()->getId() == Ademe_Model_AuthProfilTable::PROFIL_REFERENT) {
                    $mail->config("/referent/id/".$user->getId(), $dateFin);
                } elseif ($user->getHighestProfil()->getId() == Ademe_Model_AuthProfilTable::PROFIL_ANIMATEUR) {
                    $mail->config("/animateur/id/".$user->getId(), $dateFin);
                } else {
                    $mail->config(null, $dateFin);
                }
            } else {
                $mail->config(null, $dateFin);
            }
            $mail->prepareMailAndSend();
        }

        $this->view->email = $email;
    }

    /**
     * Consomme le jeton, et redirige vers l'URL du jeton
     */
    public function tokenAction()
    {
        $request = $this->getRequest();

        if ($request->isGet()) {
            $token = $request->getParam('s');
            $userToken = Ademe_Model_UserTokenTable::getInstance()->findOneByToken($token);
            if ($userToken) {
                // authentification de l'utilisateur
                $auth = Zend_Auth::getInstance();
                $auth->getStorage()->write($userToken->getUserId());

                //Set profil in session
                $user = Ademe_Model_UserTable::getUser();
                $user->setProfilInSession($user->getHighestProfil());

                $url = $userToken->getUrl();

                if (!is_null($userToken->getExpireAt())) {
                    if (strtotime(date('Y-m-d')) > strtotime($userToken->getExpireAt())) {
                        $userToken->delete();
                        // on réinitialise la session
                        Zend_Auth::getInstance()->clearIdentity();
                        // redirection vers la page d'accueil avec un message
                        $this->_helper->flashMessenger->setNamespace('error')->addMessage("Le lien a expiré.");
                        $this->getRedirector()->gotoUrl('/');
                    }
                }
                $userToken->delete();
                $this->getRedirector()->gotoUrl($url);
            } else {
                // on réinitialise la session
                Zend_Auth::getInstance()->clearIdentity();
                // redirection vers la page d'accueil avec un message
                $this->_helper->flashMessenger->setNamespace('error')->addMessage("Le lien a expiré.");
                $this->getRedirector()->gotoUrl('/');
            }
        }
    }

    /**
     * Initialisation de la procédure de mot de passe oublié (étape 1)
     *
     * @Ademe_Annotation_Cu("202-01")
     * @Ademe_Annotation_WindowTitle("Eval PDE - Mot de passe oublié")
     * @Ademe_Annotation_PageTitle("Mot de passe oublié")
     */
    public function mdpinitAction()
    {
        if (Ademe_Model_UserTable::isLoggedIn()) {
            $this->_helper->flashMessenger->setNamespace('error')->addMessage("Vous ne devez pas être connecté pour accéder à cette fonctionnalité");
            $this->getRedirector()->gotoUrl('/');
        } else {
            $form = new Ademe_Form_Modules_Inscription_MdpInit(array('id' => 'validate'));

            $request = $this->getRequest();
            if ($request->isPost()) {
                if ($form->isValid($request->getPost())) {
                    $email = $request->getParam('mail');
                    // si l'utilisateur existe avec cette email et qu'il est actif, on poursuit la procédure sinon on recharge la page
                    $user = Ademe_Model_UserTable::existUserActif($email);
                    if ($user instanceof Ademe_Model_User) {
                        $serverUrl = new Zend_View_Helper_ServerUrl();
                        $url = $serverUrl->serverUrl() . $this->_helper->url('tokenmdp', 'index');

                        // on calcule la date d'expiration du token (+60jours)
                        $dateFin = date('Y-m-d', strtotime('+60 days'));
                        // on envoie le mail d'acceptation
                        $mail = new Ademe_Mail_MdpOublie($user);
                        $options = array(
                                'url'    =>    $url,
                        );
                        $mail->setOptions($options);
                        $mail->config(null, $dateFin);
                        $mail->prepareMailAndSend();

                        $params = array('email' => $email);
                        $this->getRedirector()->gotoSimple('mailmdp', 'index', 'inscription', $params);
                    } else {
                        $this->_helper->flashMessenger->setNamespace('error')->addMessage("L'identifiant que vous avez indiqué ne correspond à aucun utilisateur actif");
                        $this->getRedirector()->gotoUrl('/inscription/index/mdpinit');
                    }
                }
            }

            $this->view->form = $form;
        }

    }

    /**
     * Consomme le jeton, et redirige vers l'URL du jeton pour redéfinition du mdp
     */
    public function tokenmdpAction()
    {
        $request = $this->getRequest();

        if ($request->isGet()) {
            $token = $request->getParam('s');
            $userToken = Ademe_Model_UserTokenTable::getInstance()->findOneByToken($token);
            if ($userToken) {
                $url = $userToken->getUrl();

                if (!is_null($userToken->getExpireAt())) {
                    if (strtotime(date('Y-m-d')) > strtotime($userToken->getExpireAt())) {
                        $userToken->delete();
                        // redirection vers la page d'accueil avec un message
                        $this->_helper->flashMessenger->setNamespace('error')->addMessage("Le lien a expiré.");
                        $this->getRedirector()->gotoUrl('/');
                    }
                }
                $userToken->delete();

                // on met l'email en session pour éviter les failles de sécurité en modifiant l'url contenant l'email
                $session = Ademe_Session_SessionHandler::getEmailMdpOublie();
                $session->email = $userToken->getUser()->getEmail();

                $this->getRedirector()->gotoUrl($url."/email/".$userToken->getUser()->getEmail());
            } else {
                // redirection vers la page d'accueil avec un message
                $this->_helper->flashMessenger->setNamespace('error')->addMessage("Le lien a expiré.");
                $this->getRedirector()->gotoUrl('/');
            }
        }
    }

    /**
     * Action permettant de confirmer l'envoi du mail pour la redéfinition du mot de passe
     * @Ademe_Annotation_Cu("202-02")
     * @Ademe_Annotation_WindowTitle("Eval PDE - Mot de passe oublié")
     * @Ademe_Annotation_PageTitle("Mot de passe oublié")
     */
    public function mailmdpAction()
    {
        $email = $this->_getParam('email');

        $this->view->email = $email;
    }

    /**
     * Action permettant de définir un nouveau mot de passe
     * @Ademe_Annotation_Cu("202-03")
     * @Ademe_Annotation_WindowTitle("Eval PDE - Mot de passe oublié")
     * @Ademe_Annotation_PageTitle("Mot de passe oublié")
     */
    public function mdpAction()
    {
        $email = $this->_getParam('email');

        $session = Ademe_Session_SessionHandler::getEmailMdpOublie();
        $emailSession = $session->email;

        if ($email != $emailSession) {
            // redirection vers la page d'accueil avec un message
            $this->_helper->flashMessenger->setNamespace('error')->addMessage("L'email ne correspond pas à la demande initiale.");
            $this->getRedirector()->gotoUrl('/');
        }

        $form = new Ademe_Form_Modules_Inscription_Mdp($email);

        $request = $this->getRequest();
        if ($request->isPost()) {
            if ($form->isValidPartial($request->getPost())) {
                $user = Ademe_Model_UserTable::getByEmail($email);

                $mdp = $request->getParam('mdp');
                $user->setPassword($mdp);
                $user->save();

                // on redirige vers le CU201-04
                $this->getHelper('FlashMessenger')
                    ->setNamespace('success')
                    ->addMessage("La modification a réussi.<br/>Vous pouvez dès maintenant vous connecter avec votre nouveau mot de passe.");
                $this->getRedirector()->gotoSimple('mdpfin', 'index', 'inscription');
            }
        }

        $this->view->form = $form;
    }

    /**
     * Action permettant de confirmer la redéfinition du mot de passe
     *
     * @Ademe_Annotation_Cu("202-04")
     * @Ademe_Annotation_WindowTitle("Eval PDE - Mot de passe oublié")
     * @Ademe_Annotation_PageTitle("Mot de passe oublié")
     */
    public function mdpfinAction()
    {

    }
}