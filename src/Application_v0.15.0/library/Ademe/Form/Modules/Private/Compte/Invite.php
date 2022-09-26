<?php
/**
 * Formulaire pour la modification du compte invité
 *
 * @author ASI
 *
 */
class Ademe_Form_Modules_Private_Compte_Invite extends Ademe_Form_Form
{
    public function __construct($options = null)
    {
        parent::__construct($options);
    }

    public function init()
    {
        parent::init();

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
                    array('EmailAddress'),
                ),
                'decorators' => array(
                    new Ademe_Form_Decorator_JqueryValidate(),
                    new Ademe_Form_Decorator_ViewHelper(),
                    new Ademe_Form_Decorator_Label(),
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
         * Contrairement aux specs, il n'y a pas de bloc "commentaire"
         */

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
            }
        }

        parent::populate($values);
    }

}