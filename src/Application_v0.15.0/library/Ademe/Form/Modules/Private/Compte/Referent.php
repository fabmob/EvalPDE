<?php
/**
 * Formulaire pour la modification du compte référent
 *
 * @author ASI
 *
 */
class Ademe_Form_Modules_Private_Compte_Referent extends Ademe_Form_Form
{
    public function __construct($options = null)
    {
        parent::__construct($options);
    }

    public function init()
    {
        parent::init();

        // on récupère les structures juridiques
        $structuresJuridiques = Ademe_Model_StructureJuridiqueTable::getStructuresJuridiques();

        //on récupère l'utilisateur pour avoir l'id de son établissement en session
        $user = Ademe_Model_UserTable::getUser();
        $etablissementId = $user->getEtablissement()->getId();

        $structuresJuridiquesOptions = array();
        foreach ($structuresJuridiques as $s) {
            $structuresJuridiquesOptions[$s->getId()] =  $s->getNom();
        }

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
                    new Ademe_Form_Decorator_AideContextuelle(array(Ademe_Form_Decorator_AideContextuelle::OPTION_HELP_NAME => "HELP_CU310-01_EMAIL")),
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
         * STRUCTURE
        */
        $this->addElement(
            'text',
            'nom_etablissement',
            array(
                'label'      => 'Nom de l\'établissement',
                'filters'    => array('StringTrim'),
                'validators' => array(
                    array( new Zend_Validate_StringLength(array('min' => 1, 'max' => 64))),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AideContextuelleImage(array(Ademe_Form_Decorator_AideContextuelleImage::OPTION_HELP_NAME => "HELP_CU310-01_NOM_ETABLISSEMENT")),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs'))),
                'required'   => true,
                'title'      => 'Nom de l\'établissement'
            )
        );

        $this->addDisplayGroup(
            array('nom_etablissement'),
            'structure'
        );

        $structure = $this->getDisplayGroup('structure');
        $structure->setDecorators(
            array(
                'FormElements',
                new Ademe_Form_Decorator_H2Wrapper(array('titre' => 'Structure'))
            )
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
                    array('HtmlTag', array('tag' => 'div',  'class' => 'champs_adresse_voie'))
                 ),
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

        $this->addElement(
            'text',
            'activite',
            array(
                'label'      => 'Activité (code NAF)',
                'validators'=> array(
                    array( new Ademe_Form_Validator_NafSize(array('length' => 5))),
                    array( new Ademe_Form_Validator_Naf()),
                ),
                'description'=> 'Saisissez votre code NAF dans la zone (par exemple 7022Z)',
                'filters'    => array('StringTrim', 'StringToUpper'),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AjaxLoader(),
                    new Ademe_Form_Decorator_DescriptionNaf(),
                    new Ademe_Form_Decorator_NAF(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_activite')),
                    new Ademe_Form_Decorator_Clear(array('placement' => Ademe_Form_Decorator_Clear::PREPEND))),
                'required'   => true,
                'title'      => 'Activite'
            )
        );

        $mailAdmin = Zend_Registry::get('config')->get('global')->get('admin_mail');
        $messageSiret = "Il existe déjà un référent PDE pour ce numéro de SIRET, contactez l'administrateur fonctionnel à l'adresse ".$mailAdmin;
        $this->addElement(
            'text',
            'siret',
            array(
                'label'      => 'SIRET',
                'validators'=> array(
                    array( new Ademe_Form_Validator_SiretExceptUser($etablissementId, $mailAdmin)),
                    array( new Zend_Validate_Digits()),
                    array( new Ademe_Form_Validator_StringSize(14)),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_SIRETExceptUser(array('etablissementId' => $etablissementId)),
                    new Ademe_Form_Decorator_BaseSiren(),
                    new Ademe_Form_Decorator_JqueryValidate(array(Ademe_Form_Decorator_JqueryValidate::OPTION_MESSAGE_SIRET => $messageSiret)),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AjaxLoader(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_siret'))),
                'required'   => true,
                'title'      => 'SIRET'
            )
        );

        $this->addElement(
            'hidden',
            'siren',
            array(
                'decorators' => array(
                    new Ademe_Form_Decorator_ViewHelper(),
                )
            )
        );

        $this->addElement(
            'text',
            'effectif',
            array(
                'label'      => "Effectif de l'établissement",
                'description'=> 'Ce SIRET existe déjà en statut inactif dans la base de données pour le compte',
                'validators'=> array(
                    array( new Zend_Validate_Digits()),
                    array( new Ademe_Form_Validator_GreaterThanOrEqual(1))
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AideContextuelleImage(array(Ademe_Form_Decorator_AideContextuelleImage::OPTION_HELP_STATIC_NAME => " il s'agit du nombre de salariés et de l'ensemble des personnes qui travaillent pour le compte de l'établissement (sous-traitants...)")),
                    new Ademe_Form_Decorator_AideContextuelle(array(Ademe_Form_Decorator_AideContextuelle::OPTION_HELP_NAME => "HELP_CU310-01_SIRET")),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_effectif'))),
                'required'   => true,
                'title'      => "Effectif de l'établissement"
            )
        );

        $this->addElement(
            'select',
            'structure_juridique',
            array(
                'label'      => 'Structure juridique',
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_structure_juridique')),
                    new Ademe_Form_Decorator_Clear(array('placement' => Ademe_Form_Decorator_Clear::PREPEND))),
                'required'   => true,
                'multiOptions'=> $structuresJuridiquesOptions,
                'title'      => 'Structure juridique'
            )
        );

        $dateEntree = new Ademe_Form_Element_DatePicker(
            'date_entree',
            array(
                'label'      => 'Date d\'entrée dans la démarche',
                'validators' => array(
                    new Zend_Validate_Date(array('format' => 'dd/mm/yyyy')),
                ),
                'required'   => true,
                'title'      => 'Date d\'entrée dans la démarche'
            )
        );
        $dateEntree->addDecorator(new Zend_Form_Decorator_HtmlTag(array('tag' => 'div', 'class' => 'champs_date_entree')));
        $dateEntree->addValidator(new Zend_Validate_Date(array('format' => 'dd/mm/yyyy')));
        $dateEntree->setRequired(true);
        $dateEntree->addDecorator(new Ademe_Form_Decorator_JqueryValidate());

        $this->addElement($dateEntree);

        $this->addElement(
            'text',
            'nom_demarche',
            array(
                'label'      => 'Nom de la démarche',
                'filters'    => array('StringTrim'),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Zend_Form_Decorator_Label(),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_nom_demarche'))),
                'title'      => 'Nom de la démarche'
            )
        );

        $this->addDisplayGroup(
            array('adresse_no', 'adresse_voie', 'code_postal', 'commune', 'activite', 'siret', 'effectif', 'structure_juridique', 'date_entree', 'nom_demarche'),
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
                'filters'    => array('StringTrim'),
                'validators' => array(
                    new Ademe_Form_Validator_RequiredIfChanged($this->getElement("mail"), "Vous devez préciser la raison de la modification du compte."),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
                    new Ademe_Form_Decorator_AideContextuelle(array(Ademe_Form_Decorator_AideContextuelle::OPTION_HELP_NAME => "HELP_CU202-03_RAISON_MODIF", 'placement' => Ademe_Form_Decorator_Clear::APPEND)),
                    array('HtmlTag', array('tag' => 'div', 'class' => 'champs_commentaire')),
                 ),
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
        if (empty($values)) {
            // on récupère les données de l'utilisateur
            $user = Ademe_Model_UserTable::getUser();
            if ($user instanceof Ademe_Model_User) {
                $this->getElement('nom')->setValue($user->getNom());
                $this->getElement('prenom')->setValue($user->getPrenom());
                $this->getElement('telephone')->setValue($user->getTelephone());
                $this->getElement('fonction')->setValue($user->getFonction());
                $this->getElement('mail')->setValue($user->getEmail());
                $this->getElement('consentement')->setValue($user->getConsentement());
                $etablissement = $user->getEtablissement();
                $this->getElement('nom_etablissement')->setValue($etablissement->getRaisonSociale());
                $this->getElement('adresse_no')->setValue($etablissement->getAdresseNo());
                $this->getElement('adresse_voie')->setValue($etablissement->getAdresseVoie());
                $this->getElement('code_postal')->setValue($etablissement->getCodePostal());
                // on récupère les villes correspondant au code postal
                $villes = Ademe_Model_GeoVilleTable::getInstance()->findByCodePostal($etablissement->getCodePostal());
                $communes = array();
                foreach ($villes as $v) {
                    $communes[$v->getId()] = $v->getNom();
                }
                $this->getElement('commune')->setMultiOptions($communes);
                $this->getElement('activite')->setValue($etablissement->getNafSousClasse()->getCodeRecherche());
                $this->getElement('siret')->setValue($etablissement->getSiret());
                $siren = substr($etablissement->getSiret(), 0, 9);
                $this->getElement('siren')->setValue($siren);
                $this->getElement('effectif')->setValue($etablissement->getEffectif());
                $this->getElement('structure_juridique')->setValue($etablissement->getStructureJuridique()->getId());
                $date = strftime('%d/%m/%Y', strtotime($etablissement->getDateEntree()));
                $this->getElement('date_entree')->setValue($date);
                $this->getElement('nom_demarche')->setValue($etablissement->getNomDemarche());
            }
        } else {

            //POST
            $user = Ademe_Model_UserTable::getUser();
            if ($user instanceof Ademe_Model_User) {
                $validator = $this->getElement('commentaire')->getValidator('Ademe_Form_Validator_RequiredIfChanged');
                $validator->setOriginalValue($user->getEmail());
                $this->getElement('commentaire')->removeValidator('Ademe_Form_Validator_RequiredIfChanged');
                $this->getElement('commentaire')->addValidator($validator);
            }
        }

        parent::populate($values);
    }

    public function isValid($data)
    {
        // On met allowEmpty à false pour le champ 'commentaire' afin que la validation (appel de isValid) ait lieu
        // y compris si le champ est vide
        $this->getElement('commentaire')->setAllowEmpty(false);
        return parent::isValid($data);
    }


}