<?php
/**
 * Accueil du site
 */
class IndexController extends Ademe_Controller_CuController
{
    /**
     * Changement de profil de l'utilisateur
     *
     * @Ademe_Annotation_LoggedInRequired
     */
    public function changeprofilAction()
    {
        $profilAsked = $this->getRequest()->getParam('profil_id');
        if (!empty($profilAsked)) {

            if (Ademe_Model_UserTable::isLoggedIn()) {
                $user = Ademe_Model_UserTable::getUser();

                if ($user->hasProfilId($profilAsked)) {

                    //Reset all sessions
                    Ademe_Session_SessionHandler::resetSessionNamespace();

                    //Change current profil
                    $user->setProfilIdInSession($profilAsked);

                    //Change current établissement
                    if ($etablissement = $user->getHighestEtablissement()) {
                        $user->setEtablissementInSession($etablissement);
                    }

                    //Change current structure
                    if ($structure = $user->getHighestStructure()) {
                        $user->setStructureInSession($structure);
                    }

                    $this->_checkIsOrphelinForCurrentProfil($user);

                    //Réactualise la page
                    $url = base64_decode($this->getRequest()->getParam('url'));
                    $this->getRedirector()->gotoUrl($url);
                }
            }
        }

        //Profil not allowed
        $this->getHelper('FlashMessenger')
        ->setNamespace('error')
        ->addMessage("Profil non autorisé");
        $this->getRedirector()->gotoSimple('index', 'index', 'index');
    }

    /**
     * Changement d'établissement de l'utilisateur
     *
     * @Ademe_Annotation_LoggedInRequired
     */
    public function changeetablissementAction()
    {
        $etablissementAsked = $this->getRequest()->getParam('etablissement_id');
        if (!empty($etablissementAsked)) {

            if (Ademe_Model_UserTable::isLoggedIn()) {
                $user = Ademe_Model_UserTable::getUser();

                if ($user->hasEtablissementId($etablissementAsked)) {

                    //Change current etablissement
                    $user->setEtablissementIdInSession($etablissementAsked);

                    //Réactualise la page
                    $url = base64_decode($this->getRequest()->getParam('url'));
                    $this->getRedirector()->gotoUrl($url);
                }
            }
        }

        //Etablissement not allowed
        $this->getHelper('FlashMessenger')
        ->setNamespace('error')
        ->addMessage("Établissement non autorisé");
        $this->getRedirector()->gotoSimple('index', 'index', 'index');
    }

    /**
     * Changement de structure de l'utilisateur
     *
     * @Ademe_Annotation_LoggedInRequired
     */
    public function changestructureAction()
    {
        $structureAsked = $this->getRequest()->getParam('structure_id');
        if (!empty($structureAsked)) {

            if (Ademe_Model_UserTable::isLoggedIn()) {
                $user = Ademe_Model_UserTable::getUser();

                if ($user->hasStructureId($structureAsked)) {

                    //Change current structure
                    $user->setStructureIdInSession($structureAsked);

                    //Réactualise la page
                    $url = base64_decode($this->getRequest()->getParam('url'));
                    $this->getRedirector()->gotoUrl($url);
                }
            }
        }

        //Etablissement not allowed
        $this->getHelper('FlashMessenger')
        ->setNamespace('error')
        ->addMessage("Structure non autorisé");
        $this->getRedirector()->gotoSimple('index', 'index', 'index');
    }

    /**
     * Page d'accueil générale
     *
     * @Ademe_Annotation_Cu(200)
     * @Ademe_Annotation_WindowTitle("Accueil")
     */
    public function indexAction()
    {
        if (!Ademe_Model_UserTable::isLoggedIn()) {
            // on récupère les textes administrés
            $title = Ademe_Model_TexteTable::getTexte('TEXT_CU200-TITRE');
            $texteUn = Ademe_Model_TexteTable::getTexte('TEXT_CU200_01');
            $texteDeux = Ademe_Model_TexteTable::getTexte('TEXT_CU200_02');
            $this->view->title = $title->getTexte();
            $this->view->textCU20001 = $texteUn->getTexte();
            $this->view->textCU20002 = $texteDeux->getTexte();

            // on créé le formulaire de connexion
            $formConnexion = new Ademe_Form_Modules_Auth_Login(array('id' => 'form-login'));

            //Ajout d'un captcha présent toutes les 5 tentatives échouées
            $connexionAttemptCount = Ademe_Session_SessionHandler::getConnexionAttemptCount();
            if ($connexionAttemptCount != 0 && $connexionAttemptCount % 5 == 0) {
                $formConnexion->addCaptcha();
            }

            // on créé le formulaire d'inscription avec seulement l'adresse email
            $formInscription = new Ademe_Form_Modules_Inscription_Email(array('id' => 'form-inscription'));

            // on récupère le nombre de démarches dans la base
            $nbDemarches = Ademe_Model_EvaluationTable::getNombreEvaluations();

            $request = $this->getRequest();
            if ($request->isPost()) {
                $data = $request->getPost();
                // si l'email a été saisi, on redirige vers l'écran d'inscription, sinon on effectue le traitement pour la connexion
                if (isset($data['email2'])) {
                    if ($formInscription->isValid($data)) {
                        $params = array('email' => urlencode($data['email2']));
                        $this->getRedirector()->gotoSimple('index', 'index', 'inscription', $params);
                    }
                } else { //Traitement de la connexion

                    if ($formConnexion->isValid($request->getPost())) {

                        //Incrémente le compteur de tentatives de connexions échouées
                        Ademe_Session_SessionHandler::incrementConnexionAttemptCount();

                        if ($formConnexion->_process($formConnexion->getValues())) {
                            $user = Ademe_Model_UserTable::getUser();
                            if (!$user->getEnabled() || $user->getEnAttente()) {

                                /*
                                 * on déconnecte l'utilisateur
                                */
                                Zend_Auth::getInstance()->clearIdentity();

                                // Affichage d'une erreur
                                $this->getHelper('FlashMessenger')
                                ->setNamespace('error')
                                ->addMessage("L'utilisateur n'existe pas");
                                $this->getRedirector()->gotoUrl('/');
                            }

                            $this->_checkIsOrphelinForCurrentProfil($user);

                            if($user->getDateRgpd() == "0000-00-00 00:00:00"){
                                //On redirige l'utilisateur vers l'écran de choix de la transmission des données personnelles
                               // var_dump("Redirection vers RGPD"); die();
                                $this->getRedirector()->gotoSimple('rgpd', 'compte', 'private');
                            } else {
                                //OK, on redirige l'utilisateur vers son écran d'accueil en fonction de son profil
                                $this->getRedirector()->gotoUrl('/accueil');
                            }
                        } else {
                            // Affichage d'une erreur
                            $this->getHelper('FlashMessenger')
                            ->setNamespace('error')
                            ->addMessage("L'email ou le mot de passe saisi est incorrect");
                            $this->getRedirector()->gotoUrl('/');
                        }
                    }
                }
            }
            $this->view->formConnexion = $formConnexion;
            $this->view->formInscription = $formInscription;
            $this->view->nbDemarches = $nbDemarches;

            $this->_helper->layout->setLayout('main-accueil');
        } else {
            // on redirige l'utilisateur vers son écran d'accueil en fonction de son profil
            $this->getRedirector()->gotoUrl('/accueil');
        }
    }

    /**
     * Déconnexion
     */
    public function logoutAction()
    {
        $parameters = array();

        //Récupère les messages d'erreur en cours
        $errorMessenger = $this->getHelper('FlashMessenger')->setNamespace('error');
        if ($errorMessenger->hasMessages()) {
            $parameters['error_messages'] = urlencode(serialize($errorMessenger->getMessages()));
        }

        Zend_Auth::getInstance()->clearIdentity();

        //Réinitialise les sessions
        Ademe_Session_SessionHandler::resetSessionNamespace();

        //Clear Sessions
        Zend_Registry::get('log')->debug("Destruction de la session");
        Zend_Session::destroy();

        // back to login page
        $this->_helper->getHelper('Redirector')->gotoSimple('index', 'index', 'ademe', $parameters);
    }

    /**
     * Ajoute un message d'information si l'utilisateur n'est pas relié
     * à une structure ou un établissement
     *
     * @param Ademe_Model_User $user
     */
    protected function _checkIsOrphelinForCurrentProfil(Ademe_Model_User $user)
    {
        switch ($user->getProfil()->getId()) {
            case Ademe_Model_AuthProfilTable::PROFIL_INVITE:
            case Ademe_Model_AuthProfilTable::PROFIL_REFERENT:
                if (!$user->getEtablissement()) {
                    $this->getHelper('FlashMessenger')
                    ->setNamespace('error')
                    ->addMessage("Vous n'êtes rattaché à aucun établissement, veuillez contacter votre administrateur.");

                    //Déconnexion automatique de l'utilisateur
                    $this->getRedirector()->gotoSimple('logout', 'index', '');
                }

                break;

            case Ademe_Model_AuthProfilTable::PROFIL_ANIMATEUR:
            case Ademe_Model_AuthProfilTable::PROFIL_ADMINISTRATEUR:
                if (!$user->getStructure()) {
                    $this->getHelper('FlashMessenger')
                    ->setNamespace('error')
                    ->addMessage("Vous n'êtes rattaché à aucune structure, veuillez contacter votre administrateur.");

                    //Déconnexion automatique de l'utilisateur
                    $this->getRedirector()->gotoSimple('logout', 'index', '');
                }

                break;

            case Ademe_Model_AuthProfilTable::PROFIL_INTERNAUTE:
            default:
                break;
        }
    }


    /**
     * Action pour activer l'assistant de l'utilisateur
     */
    public function activerassistantAction()
    {
        $user = Ademe_Model_UserTable::getUser();

        // On passe tous les user_textes à l'état "non lu".
        $user->setAssistantTextesLus(false);

        // On vide le cache du template du menu
        Ademe_Session_SessionHandler::clearMenuTemplateCache();

        // On réactualise la page
        $url = base64_decode($this->getRequest()->getParam('url'));
        $this->getRedirector()->gotoUrl($url);
    }

    /**
     * Action pour désactiver l'assistant de l'utilisateur
     */
    public function desactiverassistantAction()
    {
        $user = Ademe_Model_UserTable::getUser();

        // On passe tous les user_textes à l'état "lu".
        $user->setAssistantTextesLus(true);

        // On vide le cache du template du menu
        Ademe_Session_SessionHandler::clearMenuTemplateCache();

        // On réactualise la page
        $url = base64_decode($this->getRequest()->getParam('url'));
        $this->getRedirector()->gotoUrl($url);
    }

    /**
     * Déplace l'objet (position)
     * Dépend du ViewHelper "Move"
     *
     * @see Ademe_Helper_Move
     *
     * @Ademe_Annotation_PermissionRequired({"PERM_ADMIN"})
     * @Ademe_Annotation_LoggedInRequired()
     */
    public function moveAction()
    {
        // Parameters
        $id = $this->_getParam('id');
        $componentName = $this->_getParam('componentName');
        $urlRedirection = base64_decode($this->_getParam('urlRedirection'));
        $direction = $this->_getParam('direction');

        $table = Doctrine_Core::getTable($componentName);

        if ($table instanceof Doctrine_Table) {

            $record = $table->find($id);
            if ($record instanceof Doctrine_Record) {

                try {

                    $conn = Doctrine_Manager::connection();
                    $conn->beginTransaction();

                    if ($direction == Ademe_Helper_Move::MOVE_DIRECTION_UP) {
                        $record->moveUp($conn);
                    } elseif ($direction == Ademe_Helper_Move::MOVE_DIRECTION_DOWN) {
                        $record->moveDown($conn);
                    }

                    $conn->commit();

                } catch (Exception $e) {
                    $conn->rollback();
                    throw $e;
                }

                //Succès
                $this->getHelper('FlashMessenger')
                ->setNamespace('success')
                ->addMessage("Les informations ont été enregistrées à ".date('G:i'));
            }

            //Redirect
            $this->getRedirector()->gotoUrl($urlRedirection);
        }
    }
}
