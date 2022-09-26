<?php
/**
 * Contrôleur pour la gestion du compte d'un utilisateur
 *
 * @author ASI
 */
class Private_CompteController extends Ademe_Controller_CuController
{
    /**
     * Action pour la redirection vers la gestion du compte en fonction du profil
     *
     * @Ademe_Annotation_Cu("310")
     * @Ademe_Annotation_LoggedInRequired()
     *
     */
    public function indexAction()
    {
        $user = Ademe_Model_UserTable::getUser();
        switch ($user->getProfil()->getId()) {
            case Ademe_Model_AuthProfilTable::PROFIL_REFERENT:
                $this->getRedirector()->gotoSimple('referent', 'compte', 'private');
                break;

            case Ademe_Model_AuthProfilTable::PROFIL_ANIMATEUR:
                $this->getRedirector()->gotoSimple('animateur', 'compte', 'private');
                break;

            case Ademe_Model_AuthProfilTable::PROFIL_ADMINISTRATEUR:
                $this->getRedirector()->gotoSimple('administrateur', 'compte', 'private');
                break;

            case Ademe_Model_AuthProfilTable::PROFIL_INVITE:
                $this->getRedirector()->gotoSimple('invite', 'compte', 'private');
                break;

            default:
                //Pas de page de gestion du compte, redirection vers la page d'accueil
                $this->getRedirector()->gotoSimple('accueil', 'index', 'ademe');
                break;
        }

    }

    /**
     * Action pour la gestion du compte référent
     *
     * @Ademe_Annotation_Cu("310-01")
     * @Ademe_Annotation_WindowTitle("Mon compte")
     * @Ademe_Annotation_PageTitle("Mon compte")
     * @Ademe_Annotation_LoggedInRequired()
     * @Ademe_Annotation_PermissionRequired({"PERM_MOD_COMPTE"})
     * @Ademe_Annotation_ProfilRequired({"PROFIL_REFERENT"})
     * @Ademe_Annotation_EtablissementRequired()
     *
     */
    public function referentAction()
    {
        $form = new Ademe_Form_Modules_Private_Compte_Referent(array('id' => 'form-compte-referent'));

        $request = $this->getRequest();
        if ($request->isPost()) {

            //On peuple avant le isValid, car le validateur Ademe_Form_Validator_RequiredIfChanged
            //a besoin d'être peuplé par l'ancienne valeur avant isValid()
            $form->populate($request->getPost());

            if ($form->isValid($request->getPost())) {
                $conn = Doctrine_Manager::connection();
                try {
                    $conn->beginTransaction();
                    $user = Ademe_Model_UserTable::getUser();
                    // on récupère les infos de l'utilisateur
                    $nom = $request->getParam('nom');
                    $prenom = $request->getParam('prenom');
                    $telephone = $request->getParam('telephone');
                    $mail = $request->getParam('mail');
                    $fonction = $request->getParam('fonction');
                    $mdp = $request->getParam('mdp');
                    $consentement = $request->getParam('consentement');
                    $dateRGPD = date("Y-m-d H:m:s", time());

                    if ($mdp != null) {
                        $user->setPassword($mdp);
                    }
                    $user->setNom($nom);
                    $user->setPrenom($prenom);
                    $user->setTelephone($telephone);
                    $mailOld = $user->getEmail();
                    $mailNew = null;
                    if ($mail != $mailOld) {
                        $mailNew = $mail;
                    }
                    $user->setFonction($fonction);
                    $user->setConsentement($consentement);
                    $user->setDateRgpd($dateRGPD);
                    $user->save($conn);

                    // on récupère les données de l'établissement et de la structure
                    $raisonSociale = $request->getParam('nom_etablissement');
                    $adresseNo = $request->getParam('adresse_no');
                    $adresseVoie = $request->getParam('adresse_voie');
                    $codePostal = $request->getParam('code_postal');
                    $geoVilleId = $request->getParam('commune');
                    $siret = $request->getParam('siret');
                    $effectif = $request->getParam('effectif');
                    $dateEntree = $request->getParam('date_entree');
                    $nomDemarche = $request->getParam('nom_demarche');
                    $codeNaf = $request->getParam('activite');
                    $structureJuridiqueId = $request->getParam('structure_juridique');

                    // on convertit la date 'dd/mm/yyyy' en date mysql 'yyyy/mm/dd'
                    $tmp = explode("/", $dateEntree);
                    $dateIso = $tmp[2]."-".$tmp[1]."-".$tmp[0];

                    $etablissement = $user->getEtablissement();

                    $etablissement->setRaisonSociale($raisonSociale);
                    $etablissement->setAdresseNo($adresseNo);
                    $etablissement->setAdresseVoie($adresseVoie);
                    $etablissement->setCodePostal($codePostal);
                    $etablissement->setGeoVilleId($geoVilleId);
                    $etablissement->setEffectif($effectif);
                    $etablissement->setDateEntree($dateIso);
                    $etablissement->setNomDemarche($nomDemarche);
                    // on récupère la sous classe naf correspondant au code naf
                    $naf = Ademe_Model_NafSousClasseTable::getNafSousClasse($codeNaf);
                    $etablissement->setNafSousClasse($naf);
                    $etablissement->setStructureJuridiqueId($structureJuridiqueId);
                    $etablissement->setUser($user);
                    $etablissement->setEnabled(true);
                    $etablissement->save($conn);

                    // on récupère la structure entreprise
                    $structureEntreprise = $etablissement->getStructureEntreprise();
                    if ($structureEntreprise instanceof Ademe_Model_StructureEntreprise) {
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
                        $structureEntreprise->save($conn);
                    }

                    if ($mailNew != null) {
                        // on vérifie si il existe déjà une demande de modif dans la table user_profil_edit pour l'écraser par la nouvelle demande
                        $profilId = $user->getProfil()->getId();
                        $userId = $user->getId();
                        $demandeEdit = Ademe_Model_UserProfilEditTable::getInstance()->findOneByUserIdAndAuthProfilId($userId, $profilId);
                        $dateModification = date("Y-m-d");
                        $commentaire = $request->getParam('commentaire');
                        if ($demandeEdit instanceof Ademe_Model_UserProfilEdit) {
                            $demandeEdit->setDateModification($dateModification);
                            $demandeEdit->setCommentaire($commentaire);
                            $demandeEdit->setNewEmail($mailNew);
                        } else {
                            $demandeEdit = new Ademe_Model_UserProfilEdit();
                            $demandeEdit->setUser($user);
                            $demandeEdit->setAuthProfilId($profilId);
                            $demandeEdit->setDateModification($dateModification);
                            $demandeEdit->setCommentaire($commentaire);
                            $demandeEdit->setNewEmail($mailNew);
                            $demandeEdit->setEtablissementId($etablissement->getId());
                        }
                        $demandeEdit->save($conn);
                    }

                    $conn->commit();

                    // on envoie le mail de refus du référent à l'administrateur
                    // pas demandé finalement
                    /*if(!$consentement){
                        $mail = new Ademe_Mail_RefusTransmissionDonneesPersonnelles($user);
                        $options = array(
                            'nom' => $nom,
                            'prenom' => $prenom
                        );
                        $mail->setOptions($options);
                        $mail->config(null);
                        $mail->prepareMailAndSend();
                    }*/

                    if ($mailNew != null) {
                        $this->getRedirector()->gotoSimple('mail', 'compte', 'private');
                    } else {
                        $this->getHelper('FlashMessenger')
                            ->setNamespace('success')
                            ->addMessage("Vos modifications ont été prises en compte");
                        $this->getRedirector()->gotoSimple('index', 'index', 'accueil');
                    }
                } catch (Exception $e) {
                    $conn->rollback();
                }
            }
        }
        $form->populate(array());
        $this->view->form = $form;
    }

    /**
     * Action pour la gestion du compte animateur
     *
     * @Ademe_Annotation_Cu("310-02")
     * @Ademe_Annotation_WindowTitle("Mon compte")
     * @Ademe_Annotation_PageTitle("Mon compte")
     * @Ademe_Annotation_LoggedInRequired()
     * @Ademe_Annotation_PermissionRequired({"PERM_MOD_COMPTE"})
     * @Ademe_Annotation_ProfilRequired({"PROFIL_ANIMATEUR"})
     * @Ademe_Annotation_StructureRequired()
     *
     */
    public function animateurAction()
    {
        $form = new Ademe_Form_Modules_Private_Compte_Animateur(array('id' => 'form-compte-animateur'));

        $request = $this->getRequest();
        if ($request->isPost()) {
            if ($form->isValid($request->getPost())) {
                $conn = Doctrine_Manager::connection();
                try {
                    $conn->beginTransaction();
                    $user = Ademe_Model_UserTable::getUser();
                    // on récupère les infos de l'utilisateur
                    $nom = $request->getParam('nom');
                    $prenom = $request->getParam('prenom');
                    $telephone = $request->getParam('telephone');
                    $mail = $request->getParam('mail');
                    $fonction = $request->getParam('fonction');
                    $consentement = $request->getParam('consentement');
                    $dateRGPD = date("Y-m-d H:m:s", time());

                    $mdp = $request->getParam('mdp');
                    if ($mdp != null) {
                        $user->setPassword($mdp);
                    }
                    $user->setNom($nom);
                    $user->setPrenom($prenom);
                    $user->setTelephone($telephone);
                    $mailOld = $user->getEmail();
                    $mailNew = null;
                    // booléen afin de savoir si on doit envoyer le mail aux admins (si modifs)
                    $envoiMail = false;
                    if ($mail != $mailOld) {
                        $mailNew = $mail;
                        $envoiMail = true;
                    }
                    $user->setFonction($fonction);
                    $user->setConsentement($consentement);
                    $user->setDateRgpd($dateRGPD);
                    $user->save($conn);

                    $structure = $user->getStructure();
                    $zoneIntervention = $structure->getZoneInterventions()->getFirst();

                    // on récupère les territoires pour les regrouper dans un tableau
                    $contenuZone = $request->getParam('contenu_zone');
                    $_territoires = array();
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
                            $ville = Ademe_Model_GeoVilleTable::get($idVille);
                            $territoire->setCodeVille($ville->getCode());
                        }
                        $territoire->setStatutDemandeId(Ademe_Model_StatutDemandeTable::EN_ATTENTE_VALID_ADMIN);
                        $_territoires[] = $territoire;
                    }
                    // on parcourt d'abord les territoires déjà en base afin de connaitre ceux qui ne sont plus associés à la zone d'intervention
                    $territoires = $zoneIntervention->getTerritoire();
                    foreach ($territoires as $territoire) {
                        $trouve = false;
                        $idRegion = $territoire->getGeoRegionId();
                        $idDepartement = $territoire->getGeoDepartementId();
                        $codeVille = $territoire->getCodeVille();
                        foreach ($_territoires as $_territoire) {
                            // si le territoire existait déjà et qu'il n'est plus présent, on le supprime
                            $_idRegion = $_territoire->getGeoRegionId();
                            $_idDepartement = $_territoire->getGeoDepartementId();
                            $_codeVille = $_territoire->getCodeVille();
                            if ($idRegion == $_idRegion) {
                                if ($idDepartement == $_idDepartement) {
                                    if ($codeVille == $_codeVille) {
                                        $trouve = true;
                                    }
                                }
                            }
                        }
                        if (!$trouve) {
                            $territoire->delete($conn);
                            $envoiMail = true;
                        }
                    }

                    // on parcourt ensuite les territoires provenant du POST afin de sauvegarder en base les nouveaux territoires
                    foreach ($_territoires as $_territoire) {
                        $trouve = false;
                        $_idRegion = $_territoire->getGeoRegionId();
                        $_idDepartement = $_territoire->getGeoDepartementId();
                        $_codeVille = $_territoire->getCodeVille();
                        foreach ($territoires as $territoire) {
                            $idRegion = $territoire->getGeoRegionId();
                            $idDepartement = $territoire->getGeoDepartementId();
                            $codeVille = $territoire->getCodeVille();
                            if ($idRegion == $_idRegion) {
                                if ($idDepartement == $_idDepartement) {
                                    if ($codeVille == $_codeVille) {
                                        $trouve = true;
                                    }
                                }
                            }
                        }
                        if (!$trouve) {
                            $_territoire->save($conn);
                            $envoiMail = true;
                        }
                    }

                    // on met à jour les données de la zone et on la sauvegarde
                    $nomZone = $request->getParam('nom_zone');
                    $zoneIntervention->setNom($nomZone);
                    $zoneIntervention->clearRelated();
                    $zoneIntervention->save($conn);

                    // on récupère les établissements
                    $etablissementsZone = $request->getParam('etablissements_zone');
                    $etablissementStructures = Ademe_Model_EtablissementStructureTable::getInstance()->findByStructureId($structure->getId());
                    // on supprime les rattachements qui ne sont plus présents dans la liste des établissements provenant du POST
                    foreach ($etablissementStructures as $etablissementStructure) {
                        $trouve = false;
                        $id = $etablissementStructure->getEtablissementId();
                        foreach ($etablissementsZone as $etablissementZone) {
                            if ($etablissementZone == $id) {
                                $trouve = true;
                            }
                        }
                        if (!$trouve) {
                            $etablissementStructure->delete($conn);
                            $envoiMail = true;
                        }
                    }
                    // on parcourt les établissements (ids) provenant du POST et on supprime ceux qui ne sont pas validés et plus dans la ZI
                    //$zoneIntervention = $structure->getZoneInterventions()->getFirst();
                    foreach ($etablissementsZone as $etablissementZone) {
                        $etablissementStructure = Ademe_Model_EtablissementStructureTable::getInstance()->findOneByStructureIdAndEtablissementId($structure->getId(), $etablissementZone);
                        if ($etablissementStructure instanceof Ademe_Model_EtablissementStructure) {
                            if ($etablissementStructure->getStatutDemandeId() != Ademe_Model_StatutDemandeTable::VALIDEE) {
                                $_idVille = $etablissementStructure->getEtablissement()->getGeoVilleId();
                                if (!$this->_estDansLaZone($_idVille, $zoneIntervention)) {
                                    $etablissementStructure->delete($conn);
                                    $envoiMail = true;
                                }
                            }
                        } else {
                            $etablissementStructure = new Ademe_Model_EtablissementStructure();
                            $etablissementStructure->setEtablissementId($etablissementZone);
                            $etablissementStructure->setStructure($structure);
                            $etablissementStructure->setStatutDemandeId(Ademe_Model_StatutDemandeTable::EN_ATTENTE_VALID_ADMIN);
                            $etablissementStructure->save($conn);
                            $envoiMail = true;
                        }
                    }

                    // on met à jour les données de la structure
                    $nomStructure = $request->getParam('nom_structure');
                    $raisonSociale = $request->getParam('raison_sociale');
                    $adresseNo = $request->getParam('adresse_no');
                    $adresseVoie = $request->getParam('adresse_voie');
                    $codePostal = $request->getParam('code_postal');
                    $geoVilleId = $request->getParam('commune');
                    $structure->setNom($nomStructure);
                    $structure->setRaisonSociale($raisonSociale);
                    $structure->setAdresseNo($adresseNo);
                    $structure->setAdresseVoie($adresseVoie);
                    $structure->setCodePostal($codePostal);
                    $structure->setGeoVilleId($geoVilleId);
                    $structure->setTypeDemarcheId(Ademe_Model_TypeDemarche::PDE);
                    $structure->setEnAttente(false);
                    $structure->clearRelated();
                    $structure->save($conn);

                    if ($envoiMail) {
                        // on vérifie si il existe déjà une demande de modif dans la table user_profil_edit pour l'écraser par la nouvelle demande
                        $profilId = $user->getProfil()->getId();
                        $userId = $user->getId();
                        $demandeEdit = Ademe_Model_UserProfilEditTable::getInstance()->findOneByUserIdAndAuthProfilId($userId, $profilId);
                        $dateModification = date("Y-m-d");
                        $commentaire = $request->getParam('commentaire');
                        if ($demandeEdit instanceof Ademe_Model_UserProfilEdit) {
                            $demandeEdit->setDateModification($dateModification);
                            $demandeEdit->setCommentaire($commentaire);
                            $demandeEdit->setNewEmail($mailNew);
                        } else {
                            $demandeEdit = new Ademe_Model_UserProfilEdit();
                            $demandeEdit->setUser($user);
                            $demandeEdit->setAuthProfilId($profilId);
                            $demandeEdit->setDateModification($dateModification);
                            $demandeEdit->setCommentaire($commentaire);
                            $demandeEdit->setNewEmail($mailNew);
                            $demandeEdit->setStructureId($structure->getId());
                        }
                        $demandeEdit->save($conn);
                    }

                    $conn->commit();

                    if ($envoiMail) {
                        $this->getRedirector()->gotoSimple('mail', 'compte', 'private');
                    } else {
                        $this->getHelper('FlashMessenger')
                            ->setNamespace('success')
                            ->addMessage("Vos modifications ont été prises en compte");
                        $this->getRedirector()->gotoSimple('index', 'index', 'accueil');
                    }
                } catch (Exception $e) {
                    $conn->rollback();
                }
            } else {
                $form->populate($request->getPost());
            }
        } else {
            $form->populate(array());
        }

        $this->view->form = $form;
    }

    /**
     * Permet de savoir si une ville se situe dans une zone d'intervention
     * @param integer $_idVille
     * @param Ademe_Model_ZoneIntervention $zoneIntervention
     */
    private function _estDansLaZone($_idVille, $zoneIntervention)
    {
        $_ville = Ademe_Model_GeoVilleTable::getInstance()->find($_idVille);
        $_idRegion = $_ville->getGeoDepartement()->getGeoRegionId();
        $territoires = $zoneIntervention->getTerritoire();
        foreach ($territoires as $t) {
            $idRegion = $t->getGeoRegionId();
            if ($idRegion == $_idRegion) {
                return true;
            }
        }
        return false;
    }

    /**
     * Action d'envoi du mail pour confirmation changement
     *
     * @Ademe_Annotation_Cu("310-05")
     * @Ademe_Annotation_WindowTitle("Mon compte")
     * @Ademe_Annotation_PageTitle("Mon compte")
     *
     */
    public function mailAction()
    {
        // on récupère l'ensemble des administrateurs
        $usersProfilAdmin = Ademe_Model_UserAuthProfilTable::getUsersProfil(Ademe_Model_AuthProfilTable::PROFIL_ADMINISTRATEUR);

        // on récupère l'utilisateur
        $user = Ademe_Model_UserTable::getUser();
        $nom = $user->getNom();
        $prenom = $user->getPrenom();
        $idProfil = $user->getProfil()->getId();
        if ($idProfil == Ademe_Model_AuthProfilTable::PROFIL_REFERENT) {
            $raisonSociale = $user->getEtablissement()->getRaisonSociale();
        } elseif ($idProfil == Ademe_Model_AuthProfilTable::PROFIL_ANIMATEUR) {
            $raisonSociale = $user->getStructure()->getRaisonSociale();
        } else {
            $raisonSociale = "";
        }

        $serverUrl = new Zend_View_Helper_ServerUrl();
        $url = $serverUrl->serverUrl() . $this->_helper->url('token', 'compte');

        // on calcule la date d'expiration du token (+60jours)
        $dateFin = date('Y-m-d', strtotime('+60 days'));

        // Envoi du mail pour chaque admin
        foreach ($usersProfilAdmin as $u) {
            $mail = new Ademe_Mail_DemandeModification($u->getUser());
            $options = array(
                    'nom'         => $nom,
                    'prenom'      => $prenom,
                    'raison_sociale'  => $raisonSociale,
                    'url'    => $url
            ) ;
            $mail->setOptions($options);

            if ($user instanceof Ademe_Model_User) {
                if ($user->getProfil()->getId() == Ademe_Model_AuthProfilTable::PROFIL_REFERENT) {
                    $mail->config("/referent/userId/".$user->getId()."/profilId/".$user->getProfil()->getId(), $dateFin);
                } elseif ($user->getProfil()->getId() == Ademe_Model_AuthProfilTable::PROFIL_ANIMATEUR) {
                    $mail->config("/animateur/userId/".$user->getId()."/profilId/".$user->getProfil()->getId(), $dateFin);
                } else {
                    $mail->config(null, $dateFin);
                }
            } else {
                $mail->config(null, $dateFin);
            }
            $mail->prepareMailAndSend();
        }
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
     * Action pour la gestion du compte invité
     *
     * @Ademe_Annotation_Cu("310-03")
     * @Ademe_Annotation_WindowTitle("Mon compte")
     * @Ademe_Annotation_PageTitle("Mon compte")
     * @Ademe_Annotation_LoggedInRequired()
     * @Ademe_Annotation_PermissionRequired({"PERM_MOD_COMPTE"})
     * @Ademe_Annotation_ProfilRequired({"PROFIL_INVITE"})
     *
     */
    public function inviteAction()
    {
        $form = new Ademe_Form_Modules_Private_Compte_Invite(array('id' => 'form-compte-invite'));

        $request = $this->getRequest();
        if ($request->isPost()) {
            if ($form->isValid($request->getPost())) {
                $conn = Doctrine_Manager::connection();
                try {
                    $conn->beginTransaction();
                    $user = Ademe_Model_UserTable::getUser();
                    // on récupère les infos de l'utilisateur
                    $nom = $request->getParam('nom');
                    $prenom = $request->getParam('prenom');
                    $telephone = $request->getParam('telephone');
                    $mail = $request->getParam('mail');
                    $fonction = $request->getParam('fonction');
                    $mdp = $request->getParam('mdp');
                    $consentement = $request->getParam('consentement');
                    $dateRGPD = date("Y-m-d H:m:s", time());

                    if ($mdp != null) {
                        $user->setPassword($mdp);
                    }
                    $user->setNom($nom);
                    $user->setPrenom($prenom);
                    $user->setTelephone($telephone);
                    $user->setEmail($mail);
                    $user->setFonction($fonction);
                    $user->setConsentement($consentement);
                    $user->setDateRgpd($dateRGPD);
                    $user->save($conn);
                    $conn->commit();

                    // on envoie un mail aux référents des établissements de l'invité
                    $inviteEtablissements = $user->getInviteEtablissements();
                    foreach ($inviteEtablissements as $ie) {
                        $e = $ie->getEtablissement();
                        $referent = $e->getUser();
                        $mail = new Ademe_Mail_ModificationCompteInvite($referent);
                        $options = array(
                            'prenom'   => $prenom,
                            'nom'      => $nom
                        );
                        $mail->setOptions($options);
                        $mail->config(null);
                        $mail->prepareMailAndSend();
                    }

                    $this->getHelper('FlashMessenger')
                        ->setNamespace('success')
                        ->addMessage("Vos modifications ont été prises en compte");
                    $this->getRedirector()->gotoSimple('index', 'index', 'accueil');
                } catch (Exception $e) {
                    $conn->rollback();
                }
            }
        }

        $form->populate(array());

        $this->view->form = $form;
    }

    /**
     * Action pour la gestion du compte administrateur
     *
     * @Ademe_Annotation_Cu("310-04")
     * @Ademe_Annotation_WindowTitle("Mon compte")
     * @Ademe_Annotation_PageTitle("Mon compte")
     * @Ademe_Annotation_LoggedInRequired()
     * @Ademe_Annotation_PermissionRequired({"PERM_MOD_COMPTE"})
     * @Ademe_Annotation_ProfilRequired({"PROFIL_ADMINISTRATEUR"})
     *
     */
    public function administrateurAction()
    {
        $form = new Ademe_Form_Modules_Private_Compte_Administrateur(array('id' => 'form-compte-administrateur'));

        $request = $this->getRequest();
        if ($request->isPost()) {
            if ($form->isValid($request->getPost())) {
                $conn = Doctrine_Manager::connection();
                try {
                    $conn->beginTransaction();
                    $user = Ademe_Model_UserTable::getUser();
                    // on récupère les infos de l'utilisateur
                    $nom = $request->getParam('nom');
                    $prenom = $request->getParam('prenom');
                    $telephone = $request->getParam('telephone');
                    $mail = $request->getParam('mail');
                    $fonction = $request->getParam('fonction');
                    $mdp = $request->getParam('mdp');
                    $consentement = $request->getParam('consentement');
                    $dateRGPD = date("Y-m-d H:m:s", time());

                    if ($mdp != null) {
                        $user->setPassword($mdp);
                    }
                    $user->setNom($nom);
                    $user->setPrenom($prenom);
                    $user->setTelephone($telephone);
                    $user->setEmail($mail);
                    $user->setFonction($fonction);
                    $user->setConsentement($consentement);
                    $user->setDateRgpd($dateRGPD);
                    $user->save($conn);
                    $conn->commit();
                    $this->getHelper('FlashMessenger')
                        ->setNamespace('success')
                        ->addMessage("Vos modifications ont été prises en compte");
                    $this->getRedirector()->gotoSimple('index', 'index', 'accueil');
                } catch (Exception $e) {
                    $conn->rollback();
                }
            }
        }

        $form->populate(array());

        $this->view->form = $form;
    }

    /**
     * Action pour accepter ou refuser la transmission de ses données personnelles
     *
     * @Ademe_Annotation_Cu("310-06")
     * @Ademe_Annotation_WindowTitle("Transmission des données personnelles")
     * @Ademe_Annotation_PageTitle("Transmission des données personnelles")
     * @Ademe_Annotation_LoggedInRequired()
     *
     */
    public function rgpdAction()
    {
        $form = new Ademe_Form_Modules_Inscription_RGPD();

        $request = $this->getRequest();
        if ($request->isPost()) {
            $data = $request->getPost();
            if ($form->isValid($data)) {
                $conn = Doctrine_Manager::connection();
                try {
                    $conn->beginTransaction();
                    $user = Ademe_Model_UserTable::getUser();
                    $consentement = isset($data['rgpd']) && $data['rgpd'] == 1 ? 1 : 0;
                    $dateRGPD = date("Y-m-d H:m:s", time());
                    $user->setConsentement($consentement);
                    $user->setDateRgpd($dateRGPD);
                    $user->save($conn);
                    $conn->commit();
                } catch (Exception $e) {
                    $conn->rollback();
                }

                //OK, on redirige l'utilisateur vers son écran d'accueil en fonction de son profil
                $this->getRedirector()->gotoUrl('/accueil');
            }
        }

        $form->populate(array());

        $this->view->form = $form;
    }
}