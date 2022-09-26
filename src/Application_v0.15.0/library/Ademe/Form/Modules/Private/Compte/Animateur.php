<?php
/**
 * Formulaire pour la modification du compte animateur
 * @author ASI
 *
 */
class Ademe_Form_Modules_Private_Compte_Animateur extends Ademe_Form_Form
{
    public function init()
    {
        parent::init();

        $user = Ademe_Model_UserTable::getUser();

        /*
         * INFORMATIONS GENERALES
        */
        $this->addElement(
            'text',
            'nom',
            array(
                'label'      => 'Nom',
                'required'   => true,
                'filters'    => array('StringTrim'),
                'validators' => array(
                    array( new Zend_Validate_StringLength(array('min' => 1, 'max' => 64))),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'bloc_champs'))),
                'title'      => 'Nom'
            )
        );

        $this->addElement(
            'text',
            'prenom',
            array(
                'label'      => 'Prénom',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    array( new Zend_Validate_StringLength(array('min' => 1, 'max' => 64))),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'bloc_champs'))),
                'required'   => true,
                'title'      => 'Prénom'
            )
        );

        $this->addElement(
            'text',
            'telephone',
            array(
                'label'      => 'Téléphone',
                'filters'    => array(
                    'StringTrim',
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'bloc_champs'))),
                'validators'=> array(
                    array( new Ademe_Form_Validator_Telephone()),
                ),
                'required'   => true,
                'title'      => 'Téléphone'
            )
        );

        $this->addElement(
            'text',
            'fonction',
            array(
                'label'      => 'Fonction',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    array( new Zend_Validate_StringLength(array('min' => 1, 'max' => 64))),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'bloc_champs'))),
                'required'   => true,
                'title'      => 'Fonction'
            )
        );

        $this->addElement(
            'text',
            'mail',
            array(
                'label'      => 'Adresse email',
                'filters'    => array('StringTrim', 'StringToLower'),
                'validators' => array(
                    new Ademe_Form_Validator_EmailAddress(),
                    new Ademe_Form_Validator_Email(array('ignoreUser' => $user->getId())),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AideContextuelle(array(Ademe_Form_Decorator_AideContextuelle::OPTION_HELP_NAME => "HELP_CU310-02_EMAIL")),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs'))),
                'required'   => true,
                'title'      => 'Adresse email',
            )
        );

        $this->addDisplayGroup(
            array('nom', 'prenom', 'telephone', 'fonction', 'mail'),
            'informations_generales'
        );

        $informationsGenerales = $this->getDisplayGroup('informations_generales');
        $informationsGenerales->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_H2Wrapper(array('titre' => 'Informations générales')))
        );

        /*
         * STRUCTURE D'ANIMATION
        */
        $this->addElement(
            'text',
            'nom_structure',
            array(
                'label'      => 'Nom de la structure d\'animation',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    array( new Zend_Validate_StringLength(array('min' => 1, 'max' => 64))),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_nom_structure'))),
                'title'      => 'Nom de la structure d\'animation'
            )
        );

        $this->addElement(
            'text',
            'raison_sociale',
            array(
                'label'      => 'Raison sociale',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    array( new Zend_Validate_StringLength(array('min' => 1, 'max' => 64))),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_raison_sociale'))),
                'required'   => true,
                'title'      => 'Raison sociale'
            )
        );

        $this->addDisplayGroup(
            array('nom_structure', 'raison_sociale'),
            'structure'
        );

        $structure = $this->getDisplayGroup('structure');
        $structure->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_H2Wrapper(array('titre' => 'Structure d\'animation')))
        );

        $this->addElement(
            'text',
            'adresse_no',
            array(
                'label'      => 'N°',
                'title'      => 'Adresse (n°)',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    array( new Zend_Validate_StringLength(array('min' => 1, 'max' => 10))),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_adresse'))),
            )
        );

        $this->addElement(
            'text',
            'adresse_voie',
            array(
                'label'      => 'Voie',
                'title'      => 'Adresse (voie)',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    array( new Zend_Validate_StringLength(array('min' => 1, 'max' => 255))),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div',  'class' => 'champs_adresse_voie'))),
                'required'   => true,
            )
        );

        $this->addElement(
            'text',
            'code_postal',
            array(
                'label'      => 'Code postal',
                'filters'    => array('StringTrim'),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_CodePostal(array('villeInputName' => 'commune', 'cpInputName' => 'code_postal')),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_code_postal')),
                    new Ademe_Form_Decorator_Clear(array('placement' => Ademe_Form_Decorator_Clear::PREPEND))),
                'validators' => array(
                    new Ademe_Form_Validator_CodePostal(),
                ),
                'required'   => true,

                'title'      => 'Code postal'
            )
        );

        $this->addElement(
            'select',
            'commune',
            array(
                'label'      => 'Commune',
                'description'=> "Votre code postal n'existe pas, contactez l'administrateur par la rubrique 'Contacts' en bas de page",
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AjaxLoader(),
                    new Ademe_Form_Decorator_DescriptionCommune(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_commune'))),
                'required'   => true,
                'multiOptions' => array(0 => ""),
                'title'      => 'Commune'
            )
        );
        $this->getElement('commune')->setRegisterInArrayValidator(false);

        $this->addDisplayGroup(
            array('adresse_no', 'adresse_voie', 'code_postal', 'commune'),
            'adresse'
        );

        $this->getDisplayGroup('adresse')
        ->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_AdresseWrapper(),
            )
        );

        /*
         * ZONE D'INTERVENTION
        */
        $form = new Ademe_Form_Modules_Private_Compte_ZoneIntervention();
        $this->addSubForm($form, 'zone_intervention');

        $this->getSubForm('zone_intervention')->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_H2Wrapper(array('titre' => 'Zone d\'intervention')),
                new Ademe_Form_Decorator_Clear(array('placement' => Ademe_Form_Decorator_Clear::PREPEND)),
            )
        );

        /*
         * ETABLISSEMENTS
        */
        $this->addElement(
            'multiselect',
            'etablissements_zone',
            array(
                'label'      => 'Sélectionnez les établissements que vous souhaitez rattacher à votre zone',
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_ZoneEtablissements(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AjaxLoader(),
                    new Ademe_Form_Decorator_ToutSelectionner(),
                    new Ademe_Form_Decorator_AideContextuelle(array(Ademe_Form_Decorator_AideContextuelle::OPTION_HELP_NAME => "HELP_CU310-02_ZONE_ETABLISSEMENTS")),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_etablissements_zone'))),
                'title'      => 'Etablissements de la zone',
            )
        );
        $this->getElement('etablissements_zone')->setRegisterInArrayValidator(false);

        // multiselect caché pour stocker les établissements déjà rattachés à la structure afin de ne pas les perdre lors d'une redéfinition de la zone d'intervention
        $this->addElement(
            'multiselect',
            'etablissements_rattaches',
            array(
                'label'      => 'Sélectionnez les établissements que vous souhaitez rattacher à votre zone',
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper()),
                'title'      => 'Etablissements de la zone',
            )
        );
        $this->getElement('etablissements_rattaches')->setRegisterInArrayValidator(false);

        $this->addDisplayGroup(
            array('etablissements_zone'),
            'etablissements'
        );

        $verification = $this->getDisplayGroup('etablissements');
        $verification->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_H2Wrapper(array('titre' => 'Etablissements')),
                new Ademe_Form_Decorator_Clear(array('placement' => Ademe_Form_Decorator_Clear::PREPEND)),
            )
        );

        /*
         * MODIFIER MON MOT DE PASSE
        */
        $this->addElement(
            'password',
            'mdp',
            array(
                'label'      => 'Nouveau mot de passe',
                'title'      => 'Nouveau mot de passe',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    new Ademe_Form_Validator_Password(),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Zend_Form_Decorator_ViewHelper(),
                    new Zend_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AideContextuelle(array(Ademe_Form_Decorator_AideContextuelle::OPTION_HELP_NAME => "HELP_CU310-01_PASSWORD", 'placement' => Ademe_Form_Decorator_Clear::PREPEND)),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_mdp1')),
                )
            )
        );

        $this->addElement(
            'password',
            'mdp2',
            array(
                'label'      => 'Ressaisissez le nouveau mot de passe',
                'title'      => 'Ressaisissez le nouveau mot de passe',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    new Ademe_Form_Validator_EqualTo($this->getElement('mdp')),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Zend_Form_Decorator_ViewHelper(),
                    new Zend_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AideContextuelle(array(Ademe_Form_Decorator_AideContextuelle::OPTION_HELP_NAME => "HELP_CU202-03_PASSWORD")),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_mdp2')),
                )
            )
        );

        $this->addDisplayGroup(
            array('mdp', 'mdp2'),
            'mot_de_passe'
        );

        $informationsGenerales = $this->getDisplayGroup('mot_de_passe');
        $informationsGenerales->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_H2Wrapper(array('titre' => 'Modifier mon mot de passe')))
        );

        // Ajout du RGPD
        $this->addElement(
            'radio',
            'consentement',
            array(
                'label' => 'J\'accepte la <a href = "https://www.ademe.fr/politique-protection-donnees-personnelles" target = "_blank">politique de protection des données personnelles</a> de l\'ADEME&nbsp;:',
                'multiOptions' => array(
                    '1' => 'Oui',
                    '0' => 'Non'
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Zend_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_Clear(array('placement' => Ademe_Form_Decorator_Clear::PREPEND)),
                    new Zend_Form_Decorator_HtmlTag(array('tag' => 'div', 'class' => 'champs')),
                ),
            )
        );

        $this->addDisplayGroup(
            array('consentement'),
            'rgpd'
        );

        $consentement = $this->getDisplayGroup('rgpd');
        $consentement->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_H2Wrapper(array('titre' => 'Politique de protection des données personnelles'))
            )
        );

        /*
         * COMMENTAIRE
        */
        $this->addElement(
            'textarea',
            'commentaire',
            array(
                'label'      => 'Raison de la modification',
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label()),
                'required'   => true,
                'title'    => 'Raison de la modification'
            )
        );

        $this->addDisplayGroup(
            array('commentaire'),
            'zone_commentaire'
        );

        $informationsGenerales = $this->getDisplayGroup('zone_commentaire');
        $informationsGenerales->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_H2Wrapper(array('titre' => 'Commentaire')))
        );

        /*
         * BTN CANCEL
        */
        $this->addElement(
            'button',
            'btn_cancel',
            array(
                'label'      => 'Annuler',
                'decorators' => array(
                    new Ademe_Form_Decorator_Cancel(
                        array(
                            Ademe_Form_Decorator_Cancel::OPTION_URL => '/accueil',
                            Ademe_Form_Decorator_Cancel::OPTION_LABEL => 'Annuler',
                        )
                    ),
                    new Ademe_Form_Decorator_Clear(array('placement' => Ademe_Form_Decorator_Clear::PREPEND))
                ),
            )
        );

        /*
         * BTN SUBMIT
        */
        $this->addElement(
            'submit',
            'btn_submit',
            array(
                'label'      => 'Modifier mon compte',
                'decorators' => array(
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Submit()),
            )
        );
    }

    /**
     * Peuple les champs du formulaire
     *
     * @see Zend_Form::populate()
     */
    public function populate(array $values)
    {
        // on récupère les données de l'utilisateur
        $user = Ademe_Model_UserTable::getUser();
        if (empty($values)) {
            if ($user instanceof Ademe_Model_User) {
                $this->getElement('nom')->setValue($user->getNom());
                $this->getElement('prenom')->setValue($user->getPrenom());
                $this->getElement('telephone')->setValue($user->getTelephone());
                $this->getElement('fonction')->setValue($user->getFonction());
                $this->getElement('mail')->setValue($user->getEmail());
                $this->getElement('consentement')->setValue($user->getConsentement());
                $structure = $user->getStructure();
                $this->getElement('nom_structure')->setValue($structure->getNom());
                $this->getElement('raison_sociale')->setValue($structure->getRaisonSociale());
                $this->getElement('adresse_no')->setValue($structure->getAdresseNo());
                $this->getElement('adresse_voie')->setValue($structure->getAdresseVoie());

                $codePostal = $structure->getCodePostal();
                $this->getElement('code_postal')->setValue($structure->getCodePostal());

                // on récupère les villes correspondant au code postal
                // il n'y a pas de code postal pour la structure animateur
                if (!empty($codePostal)) {
                    $villes = Ademe_Model_GeoVilleTable::getInstance()->findByCodePostal($structure->getCodePostal());
                    $communes = array();
                    foreach ($villes as $v) {
                        $communes[$v->getId()] = $v->getNom();
                    }
                    $this->getElement('commune')->setMultiOptions($communes);
                }

                //Zones rattachées
                $v = array(); $w = array();
                $etablissementStructures = $structure->getEtablissementStructures();
                foreach ($etablissementStructures as $es) {
                    $v[$es->getEtablissementId()] = $es->getEtablissementId();
                    $w[$es->getEtablissementId()] = $es->getEtablissement()->getCodePostal()." - ".$es->getEtablissement()->getRaisonSociale();
                }
                $this->getElement('etablissements_zone')->setMultiOptions($v);
                $this->getElement('etablissements_rattaches')->setMultiOptions($w);
            }
        }

        parent::populate($values);

        if (isset($values['etablissements_zone'])) {
            $v = array();
            for ($i=0; $i < sizeof($values['etablissements_zone']); $i++) {
                $value = $values['etablissements_zone'][$i];
                $v[$value] = $i;
            }
            $this->getElement('etablissements_zone')->setMultiOptions($v);
        }
        if (isset($values['code_postal'])) {
            // on récupère les villes correspondant au code postal
            $villes = Ademe_Model_GeoVilleTable::getInstance()->findByCodePostal($values['code_postal']);
            $communes = array();
            foreach ($villes as $v) {
                $communes[$v->getId()] = $v->getNom();
            }
            $this->getElement('commune')->setMultiOptions($communes);
        }

        $this->getSubForm('zone_intervention')->populate($values, $user);
    }
}
